//
//  ViewPager.swift
//  ViewPagerDemo
//
//  Created by yamaguchi on 2016/08/31.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit

protocol ViewPagerProtocol {
    var viewPagerController: ViewPager { get }
    var scrollView: UIScrollView { get }
}

public protocol ViewPagerDelegate: class {
//    func viewPagerWillBeginDragging(viewPager: ViewPager)
    func viewPagerDidEndDragging(viewPager: ViewPager)
}

open class ViewPager: UIViewController {

    // publlic
    open var selectedIndex: Int = 0
    
    // Handler
    open var viewPagerWillBeginDraggingHandler : ((ViewPager) -> Void)?
    open var viewPagerDidEndDraggingHandler : ((ViewPager) -> Void)?
    
//    open weak var delegate: Set<ViewPagerDelegate>()?
    // Views
    fileprivate var pageViewController: UIPageViewController!
    fileprivate var menuView: MenuView!
    
    // other
    fileprivate var titles = [String]()
    fileprivate var viewControllers = [UIViewController]()
    
    fileprivate var option = ViewPagerOption()
    fileprivate var currentIndex: Int {
        guard let viewController = self.pageViewController.viewControllers?.first else {
            return 0
        }
        return self.viewControllers.map{ $0 }.index(of: viewController)!
    }
    fileprivate var draggingIndex: Int?         // current dragging controller index
    fileprivate var isTapMenuItem = false
    fileprivate var isDragging = false
    
    fileprivate var navigationBarOffsetY : CGFloat = 0.0
    fileprivate var beforeOffsetY : CGFloat = 0.0
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    init(controllers: [UIViewController], option: ViewPagerOption, parentViewController: UIViewController) {
        super.init(nibName: nil, bundle: nil)
        
        parentViewController.addChildViewController(self)
        self.didMove(toParentViewController: parentViewController)
        
        self.viewControllers = controllers
        // titles
        controllers.forEach {
            guard let title = $0.title else {
                fatalError("Please set the title of the viewController")
            }
            self.titles.append(title)
        }
        self.option = option
        parentViewController.automaticallyAdjustsScrollViewInsets = false
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewWillAppear(_ animated: Bool) {
//        print("viewWillAppear")
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
//        print("viewWillDisappear")
        
        if let originY = self.navigationController?.navigationBar.frame.origin.y {
            if originY < 0.0 {
                self.updateNavigation(ratio: 0)
            }
        }
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pageViewController.dataSource = self
        self.pageViewController.delegate = self
        
//        self.pageViewController.view.frame = CGRectMake(0, (64 + 40), self.view.frame.width, self.view.frame.height - (64 + 40))
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMove(toParentViewController: self)

     
//        menuView = MenuView(frame: CGRectMake(0, 64, self.view.frame.width, 40))
        self.menuView = MenuView(titles: self.titles, option: self.option)
        self.menuView.delegate = self
        self.view.addSubview(self.menuView)
        
        for view in self.pageViewController.view.subviews {
            if let scrollView = view as? UIScrollView {
                scrollView.scrollsToTop = false
                scrollView.delegate = self
            }
        }
        
        // layout pageController
        self.pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: self.pageViewController.view, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: self.pageViewController.view, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: self.pageViewController.view, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0)
        ])
        
        // layout menuView
        self.menuView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: self.menuView, attribute: .top, relatedBy: .equal, toItem: topLayoutGuide, attribute: .bottom, multiplier:1.0, constant: 0),
            NSLayoutConstraint(item: self.menuView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: self.menuView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: self.menuView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 40)
        ])
        
        if self.option.pagerLayoutType == .fullScreen {
            self.view.addConstraints([
                NSLayoutConstraint(item: self.pageViewController.view, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier:1.0, constant: 0),
                ])
        } else {
            self.view.addConstraints([
                NSLayoutConstraint(item: self.pageViewController.view, attribute: .top, relatedBy: .equal, toItem: topLayoutGuide, attribute: .bottom, multiplier:1.0, constant: 40),
                ])
        }
        
        self.view.layoutIfNeeded()
        self.draggingIndex = selectedIndex
        self.menuView.scrollToMenuItemAtIndex(index: self.draggingIndex!)
        
        // setup pageview
        self.pageViewController.setViewControllers([self.viewControllers[self.selectedIndex]], direction: .forward, animated: false, completion: nil)
    }
    
    // MARK: Private
    fileprivate func controllerInset() {
        
        for controller in viewControllers {
            if let controller = controller as? UITableViewController {
                controller.tableView.contentInset.top = 64 + 40
                controller.tableView.contentOffset.y = -40
//                controller.tableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
//                controller.tableView.contentOffset = CGPoint(x: 0, y: controller.tableView.contentInset.top)
                continue
            }
            if let controller = controller as? UICollectionViewController {
                controller.collectionView!.contentInset.top = 64 + 40
                controller.collectionView!.contentOffset.y = -40
                controller.view.setNeedsLayout()
                continue
            }
            
//            for view in controller.view.subviews {
////                if let view = view as? UITableView {
////                    view.contentInset.top = 64 + 40
////                    break
////                }
////                if let view = view as? UICollectionView {
////                    view.contentInset.top = 64 + 40
////                    break
////                }
//                if let view = view as? UIScrollView {
//                    view.contentInset.top = 64 + 40
//                    break
//                }
//            }
        }
    }
    
    // MARK: Public
    open func setupPageControllerAtIndex(index: Int, direction: UIPageViewControllerNavigationDirection) {
        self.isTapMenuItem = true
        
        if (index == self.currentIndex) {
            self.isTapMenuItem = false
            self.menuView.updateCollectionViewUserInteractionEnabled(userInteractionEnabled: true)
            return
        }
        
        self.draggingIndex = index
        self.pageViewController.setViewControllers([viewControllers[index]], direction: direction, animated: true) { [weak self] (isFinish) in
            
            guard let weakself = self else {
                return
            }
            
            weakself.isTapMenuItem = false
            
            // To Disable CollectionView UserInteractionEnabled
            weakself.menuView.updateCollectionViewUserInteractionEnabled(userInteractionEnabled: true)
            weakself.menuView.scrollToMenuItemAtIndex(index: weakself.currentIndex)
            
            weakself.viewPagerDidEndDraggingHandler?(weakself)
        }
    }
    
    open func syncScrollViewOffset(scrollView: UIScrollView) {
        
        let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
        let navigationBarHeight = self.navigationController?.navigationBar.frame.height ?? 0
        let topInset = (statusBarHeight + navigationBarHeight + self.option.menuItemHeight)
        
        let offsetY = scrollView.contentOffset.y + topInset
        self.beforeOffsetY = offsetY
        
        if offsetY <= 0 && self.navigationBarOffsetY > 0 {
            scrollView.contentOffset.y = statusBarHeight - navigationBarHeight
            scrollView.layoutIfNeeded()
        }
        
        if offsetY == topInset - (statusBarHeight + navigationBarHeight) && self.navigationBarOffsetY == 0 {
            scrollView.contentOffset.y = -topInset
            scrollView.layoutIfNeeded()

        }
    }
    
    open func startScroll() {
    }
    
    open func endScroll() {

    }
    
    open func defaultPosition() {
    }
    
    open func updateScrollViewOffset(scrollView: UIScrollView) {
     
        let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
        let navigationBarHeight = self.navigationController?.navigationBar.frame.height ?? 0
        let topInset = (statusBarHeight + navigationBarHeight + self.option.menuItemHeight)
        
        let offsetY = scrollView.contentOffset.y + topInset
        
        if !self.isDragging && offsetY > 0 && offsetY < scrollView.contentSize.height - scrollView.frame.size.height + topInset {
            let scrollDiff: CGFloat = self.beforeOffsetY - offsetY;
            let movePositionY = (self.navigationController?.navigationBar.frame.origin.y)! + scrollDiff
            
            let navigationFinalPosition: CGFloat = -navigationBarHeight + statusBarHeight
            let navigationDefaultPosition: CGFloat = statusBarHeight
            
            let positionY: CGFloat = max(min(movePositionY, CGFloat(navigationDefaultPosition)), CGFloat(navigationFinalPosition))

            self.navigationBarOffsetY = positionY

            if positionY == navigationFinalPosition {
                self.navigationBarOffsetY = navigationBarHeight
            }
    
            if positionY == navigationDefaultPosition {
                self.navigationBarOffsetY = 0
            }
    
            self.updateNavigation(ratio: fabs(positionY - statusBarHeight) / navigationBarHeight)
    
        }
        
//        let margin: CGFloat = 0
//        if (offsetY > 0 + margin) {
//            if offsetY >= 44 + margin {
//                self.updateNavigation(ratio: 1)
//                self.navigationBarOffsetY = 44
//                
//            } else {
//                self.updateNavigation(ratio: ((offsetY - margin) / 44))
//                self.navigationBarOffsetY = offsetY
//            }
//        } else {
//            self.updateNavigation(ratio: 0)
//            self.navigationBarOffsetY = 0.0
//        }

        self.beforeOffsetY = offsetY
    }
    
    fileprivate func updateNavigation(ratio: CGFloat) {
        
        let navigationBarHeight = self.navigationController?.navigationBar.frame.height ?? 0
        
        self.navigationController?.navigationBar.transform = CGAffineTransform(translationX: 0, y: ratio * -navigationBarHeight)
        self.menuView.transform = CGAffineTransform(translationX: 0, y: ratio * -navigationBarHeight)
        
        
        let alphaRatio = 1 - ratio
        
        self.navigationController?.navigationBar.subviews.forEach({
            
            if NSStringFromClass(type(of: $0)) != "_UINavigationBarBackground" {
                $0.alpha = alphaRatio
            }
        })
    }
}

extension ViewPager: UIPageViewControllerDataSource {
     
    fileprivate func loadNextViewController(_ viewController: UIViewController, isAfter: Bool) -> UIViewController? {
        guard var index = viewControllers.index(of: viewController) else {
            return nil
        }

        if isAfter {
            index += 1
        } else {
            index -= 1
        }
        
        if self.option.pagerType.isInfinity() {
            if index == viewControllers.count {
                index = 0
            }
            
            if index < 0 {
                index = viewControllers.count - 1
            }
        }
        
        if index >= 0 && index < viewControllers.count {
            return viewControllers[index]
        }
        return nil
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return loadNextViewController(viewController, isAfter: true)
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return loadNextViewController(viewController, isAfter: false)
    }
}

// MARK: - UIPageViewControllerDelegate
extension ViewPager: UIPageViewControllerDelegate {
    
    public func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {

        self.isTapMenuItem = false
        self.viewPagerWillBeginDraggingHandler?(self)
        self.menuView.updateCollectionViewUserInteractionEnabled(userInteractionEnabled: false)
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

        if completed && self.draggingIndex != self.currentIndex {
            self.draggingIndex = self.currentIndex
            self.menuView.scrollToMenuItemAtIndex(index: self.currentIndex)
            
            self.viewPagerDidEndDraggingHandler?(self)
        }
        
        self.menuView.updateCollectionViewUserInteractionEnabled(userInteractionEnabled: true)
    }
}


// MARK: - UIScrollViewDelegate
extension ViewPager: UIScrollViewDelegate {

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x == self.view.frame.width || self.isTapMenuItem {
            return
        }

        var targetIndex = 0
        if scrollView.contentOffset.x > self.view.frame.width {
            targetIndex = self.draggingIndex! + 1
        } else {
            targetIndex = self.draggingIndex! - 1
        }
        
        // infinity setting
        if self.option.pagerType.isInfinity() {
            if targetIndex == viewControllers.count {
                targetIndex = 0
            }
            
            if targetIndex < 0 {
                targetIndex = viewControllers.count - 1
            }
        }
        
        let offsetX = scrollView.contentOffset.x - self.view.frame.width
        

        let ratio = offsetX / self.menuView.frame.width
        if fabs(ratio) >= 1.0 && self.isDragging {
            self.draggingIndex = targetIndex
            if !self.option.pagerType.isInfinity() {
                if targetIndex == viewControllers.count - 1 {
                    self.draggingIndex = viewControllers.count - 1
                }
                if targetIndex <= 0 {
                    self.draggingIndex = 0
                }
            }
            self.menuView.scrollToMenuItemAtIndex(index: self.draggingIndex!)
            return
        }
        
        self.menuView.updateMenuItemOffset(currentIndex: self.draggingIndex!, nextIndex: targetIndex, offsetX: offsetX)
    
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.isDragging = true
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.isDragging = false
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    }

}

// MARK: - MenuViewDelegate
extension ViewPager: MenuViewDelegate {
    public func menuViewDidTapMeunItem(index: Int, direction: UIPageViewControllerNavigationDirection) {
        self.viewPagerWillBeginDraggingHandler?(self)
        self.setupPageControllerAtIndex(index: index, direction: direction)
    }
    
    public func menuViewWillBeginDragging(scrollView: UIScrollView) {
        self.pageViewController.view.isUserInteractionEnabled = false
    }
    
    public func menuViewDidEndDragging(scrollView: UIScrollView) {
        self.pageViewController.view.isUserInteractionEnabled = true
    }
}
