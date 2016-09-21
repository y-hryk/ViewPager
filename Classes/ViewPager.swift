//
//  ViewPager.swift
//  ViewPagerDemo
//
//  Created by yamaguchi on 2016/08/31.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit

open class ViewPager: UIViewController {
    
    fileprivate var option = ViewPagerOption()
    var currentIndex: Int? {
        guard let viewController = self.pageViewController.viewControllers?.first else {
            return 0
        }
        return self.viewControllers.map{ $0 }.index(of: viewController)
    }
    var movingIndex: Int = 0
    fileprivate var isTapMenuItem = false
    fileprivate var pageViewController: UIPageViewController!
    fileprivate var menuView: MenuView!
    fileprivate var titles = [String]()
    fileprivate var viewControllers = [UIViewController]()
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    init(controllers: [UIViewController], option: ViewPagerOption, parentViewController: ViewController) {
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
//        parentViewController.automaticallyAdjustsScrollViewInsets = false
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        self.menuView.scrollToMenuItemAtIndex(index: 0, animated: false)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
//        self.automaticallyAdjustsScrollViewInsets = false
        
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pageViewController.dataSource = self
        self.pageViewController.delegate = self
        
//        self.pageViewController.view.frame = CGRectMake(0, (64 + 40), self.view.frame.width, self.view.frame.height - (64 + 40))
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMove(toParentViewController: self)
        
        
//        for controller in viewControllers {
//            controller.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height - (64 + 40))
//        }

        self.movingIndex = 0
        self.pageViewController.setViewControllers([viewControllers[self.movingIndex]], direction: .forward, animated: true, completion: nil)
        self.controllerInset()
        
//        menuView = MenuView(frame: CGRectMake(0, 64, self.view.frame.width, 40))
        self.menuView = MenuView(titles: self.titles, option: self.option)
        self.menuView.backgroundColor = UIColor.clear
        self.menuView.delegate = self
//        menuView.alpha = 0.3
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
//            NSLayoutConstraint(item: self.pageViewController.view, attribute: .Top, relatedBy: .Equal, toItem: topLayoutGuide, attribute: .Bottom, multiplier:1.0, constant: 0),
            NSLayoutConstraint(item: self.pageViewController.view, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier:1.0, constant: 0),
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
    }
    
    // MARK: Private
    fileprivate func controllerInset() {
        
        for controller in viewControllers {
            if let controller = controller as? UITableViewController {
                controller.tableView.contentInset.top = 64 + 40
                controller.tableView.contentOffset.y = -40
                continue
            }
            if let controller = controller as? UICollectionViewController {
                controller.collectionView!.contentInset.top = 64 + 40
                controller.collectionView!.contentOffset.y = 64 + 40
                continue
            }
            
            for view in controller.view.subviews {
//                if let view = view as? UITableView {
//                    view.contentInset.top = 64 + 40
//                    break
//                }
//                if let view = view as? UICollectionView {
//                    view.contentInset.top = 64 + 40
//                    break
//                }
                if let view = view as? UIScrollView {
                    view.contentInset.top = 64 + 40
                    break
                }
            }
        }
    }
    
    // MARK: Public
    open func setupPageControllerAtIndex(index: Int, direction: UIPageViewControllerNavigationDirection) {
        self.isTapMenuItem = true
        
        if (index == self.currentIndex!) {
            self.isTapMenuItem = false
            self.menuView.updateCollectionViewUserInteractionEnabled(userInteractionEnabled: true)
            return
        }
        
        self.movingIndex = index
        self.pageViewController.setViewControllers([viewControllers[index]], direction: direction, animated: true) { (isFinish) in
//            print("currentIndex \(self.currentIndex!)")
//            self.menuView.scrollToMenuItemAtIndex(index: self.currentIndex!, animated: false)
//            self.menuView.scrollToMenuItemAtIndexAnimation(index: self.currentIndex!)
            self.isTapMenuItem = false
            
            // To Disable CollectionView UserInteractionEnabled
            self.menuView.updateCollectionViewUserInteractionEnabled(userInteractionEnabled: true)
            
            self.menuView.scrollToMenuItemAtIndex(index: self.currentIndex!, animated: false)
        }
    }
}

extension ViewPager: UIPageViewControllerDataSource {
     
    fileprivate func nextViewController(_ viewController: UIViewController, isAfter: Bool) -> UIViewController? {
        guard var index = viewControllers.index(of: viewController) else {
            return nil
        }

//        print("datasource current index : \(currentIndex)")
        if isAfter {
            index += 1
        } else {
            index -= 1
        }

        
//        print("next index : \(index)")
        
        if index < 0 {
            index = viewControllers.count - 1
        } else if index == viewControllers.count {
            index = 0
            
        }
        
        if index >= 0 && index < viewControllers.count {
            return viewControllers[index]
        }
        return nil
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nextViewController(viewController, isAfter: true)
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nextViewController(viewController, isAfter: false)
    }
}

// MARK: - UIPageViewControllerDelegate

extension ViewPager: UIPageViewControllerDelegate {
    
    public func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
//        print("willTransitionToViewControllers")
//
//        self.menuView.scrollToHorizontalCenter(index: currentIndex)
        self.isTapMenuItem = false
        
        // To Disable CollectionView UserInteractionEnabled
        self.menuView.updateCollectionViewUserInteractionEnabled(userInteractionEnabled: false)
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
//        print("datasource current index : \(currentIndex)")
//        self.menuView.updateCurrentIndex(index: currentIndex)
//        print("didFinishAnimating")
//        print("currentIndex : \(self.currentIndex)")
        
        if completed {
            self.movingIndex = self.currentIndex!
            self.menuView.scrollToMenuItemAtIndex(index: self.currentIndex!, animated: false)
        }
        
        // To Disable CollectionView UserInteractionEnabled
        self.menuView.updateCollectionViewUserInteractionEnabled(userInteractionEnabled: true)
    }
}



extension ViewPager: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x == self.view.frame.width || self.isTapMenuItem {
            return
        }
//        print(scrollView.contentOffset.x)
        // nextViewController Index
        
        var targetIndex = 0
        if scrollView.contentOffset.x > self.view.frame.width {
            targetIndex = self.movingIndex + 1
        } else {
            targetIndex = self.movingIndex - 1
        }
        
        // infinity setting
        if targetIndex == viewControllers.count {
            targetIndex = 0
        }
        
        if targetIndex < 0 {
            targetIndex = viewControllers.count - 1
        }
        
//        print("self.currentIndex : \(self.movingIndex)")
//        print("targetIndex : \(targetIndex)")
        let offsetX = scrollView.contentOffset.x - self.view.frame.width
        self.menuView.moveIndicator(currentIndex: self.movingIndex, nextIndex: targetIndex, offsetX: offsetX)
        
//        print(targetIndex)
//        print(scrollView.contentOffset.x)
    }
}

extension ViewPager: MenuViewDelegate {
    public func menuViewDidTapMeunItem(index: Int, direction: UIPageViewControllerNavigationDirection) {
        self.setupPageControllerAtIndex(index: index, direction: direction)
    }
}
