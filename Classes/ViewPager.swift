//
//  ViewPager.swift
//  ViewPagerDemo
//
//  Created by yamaguchi on 2016/08/31.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit

public class ViewPager: UIViewController {
    
    var currentIndex: Int? {
        guard let viewController = self.pageViewController.viewControllers?.first else {
            return 0
        }
        return self.viewControllers.map{ $0 }.indexOf(viewController)
    }
    var movingIndex: Int = 0
    private var pageViewController: UIPageViewController!
    private var menuView: MenuView!
    private var titles = [String]()
    private var viewControllers = [UIViewController]()
    private var shouldScrollCurrentBar = false
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    init(controllers: [UIViewController], parentViewController: ViewController) {
        super.init(nibName: nil, bundle: nil)
        
        viewControllers = controllers
//        //
        parentViewController.addChildViewController(self)
//        parentViewController.automaticallyAdjustsScrollViewInsets = false
        self.didMoveToParentViewController(parentViewController)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidAppear(animated: Bool) {
        self.menuView.scrollToMenuItemAtIndex(index: 0)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
//        self.automaticallyAdjustsScrollViewInsets = false
        
        self.pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        self.pageViewController.dataSource = self
        self.pageViewController.delegate = self
        
        self.pageViewController.view.frame = CGRectMake(0, (64 + 40), self.view.frame.width, self.view.frame.height - (64 + 40))
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        
        
//        for controller in viewControllers {
//            controller.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height - (64 + 40))
//        }

        self.movingIndex = 0
        self.pageViewController.setViewControllers([viewControllers[0]], direction: .Forward, animated: true, completion: nil)
        
        self.controllerInset()
        
        menuView = MenuView(frame: CGRectMake(0, 64, self.view.frame.width, 40))
//        menuView = MenuView()
        menuView.backgroundColor = UIColor.clearColor()
//        menuView.alpha = 0.3
        self.view.addSubview(menuView)
        
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
            NSLayoutConstraint(item: self.pageViewController.view, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier:1.0, constant: 0),
            NSLayoutConstraint(item: self.pageViewController.view, attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: .Leading, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: self.pageViewController.view, attribute: .Trailing, relatedBy: .Equal, toItem: self.view, attribute: .Trailing, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: self.pageViewController.view, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: 0)
        ])
        
        // layout menuView
        self.menuView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: self.menuView, attribute: .Top, relatedBy: .Equal, toItem: topLayoutGuide, attribute: .Bottom, multiplier:1.0, constant: 0),
            NSLayoutConstraint(item: self.menuView, attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: .Leading, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: self.menuView, attribute: .Trailing, relatedBy: .Equal, toItem: self.view, attribute: .Trailing, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: self.menuView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1.0, constant: 40)
        ])
        
        self.titles = ["artistartistartistartist","album","playlist","sample"]
    }
    
    // MARK: Private
    func controllerInset() {
        
        for controller in viewControllers {
            if let controller = controller as? UITableViewController {
                controller.tableView.contentInset.top = 64 + 40
                controller.tableView.contentOffset.y = 64 + 40
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
}

extension ViewPager: UIPageViewControllerDataSource {
    
    private func nextViewController(viewController: UIViewController, isAfter: Bool) -> UIViewController? {
        guard var index = viewControllers.indexOf(viewController) else {
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
    
    public func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        return nextViewController(viewController, isAfter: true)
    }
    
    public func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        return nextViewController(viewController, isAfter: false)
    }
}

// MARK: - UIPageViewControllerDelegate

extension ViewPager: UIPageViewControllerDelegate {
    
    public func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
//        print("willTransitionToViewControllers")
//
//        self.menuView.scrollToHorizontalCenter(index: currentIndex)
        self.shouldScrollCurrentBar = true
        
    }
    
    public func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
//        print("datasource current index : \(currentIndex)")
//        self.menuView.updateCurrentIndex(index: currentIndex)
//        print("didFinishAnimating")
//        print("currentIndex : \(self.currentIndex)")
        
//        self.menuView.updateMenuScrollPosition(index: self.currentIndex!)
//        if completed {
//            print("YESSSSSSSSSSSSSSS")
//        }

        self.movingIndex = self.currentIndex!
        self.menuView.scrollToMenuItemAtIndex(index: self.currentIndex!)
    }
}



extension ViewPager: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(scrollView: UIScrollView) {
//        if (self.isDrag) {
//            return;
//        }
        if scrollView.contentOffset.x == self.view.frame.width || !self.shouldScrollCurrentBar {
            return
        }
//        print(scrollView.contentOffset.x)
//        let itemWidth = 80
//        let ratio = scrollView.frame.size.width
        
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
    
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
//        self.isDrag = false
//        print("----------------- end")
//        self.movingIndex = self.currentIndex!
//        //        self.menuView.scrollToMenuItemAtIndex(index: self.currentIndex!)
//        
////        self.menuView.updateMenuScrollPosition(index: self.currentIndex!)
//        self.menuView.scrollToMenuItemAtIndex(index: self.currentIndex!)
        
//        self.movingIndex = self.currentIndex!
//        self.menuView.scrollToMenuItemAtIndex(index: self.currentIndex!)
    }
    
    public func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
//        self.menuView.updateMenuScrollPosition(index: self.currentIndex!)
    }
    
}