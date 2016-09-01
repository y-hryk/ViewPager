//
//  ViewPager2.swift
//  ViewPagerDemo
//
//  Created by yamaguchi on 2016/08/31.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit

public class ViewPager2: UIViewController {
    
    private var pageViewController: UIPageViewController!
    private var menuView: MenuView!
    
    private var currentIndex = 0
    private var viewControllers = [UIViewController]()
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    init(controllers: [UIViewController], parentViewController: ViewController) {
        super.init(nibName: nil, bundle: nil)
        
        viewControllers = controllers
        //
        parentViewController.addChildViewController(self)
//        parentViewController.automaticallyAdjustsScrollViewInsets = false
        self.didMoveToParentViewController(parentViewController)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        self.pageViewController.dataSource = self
        
        self.pageViewController.view.frame = CGRectMake(0, (64 + 40), self.view.frame.width, self.view.frame.height - (64 + 40))
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        
        for controller in viewControllers {
            controller.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height - (64 + 40))
        }
//
        for controller in viewControllers {
            NSLog("\(controller.view.frame)")
        }
        
        self.pageViewController.setViewControllers(
            [viewControllers[0]],
            direction: .Forward,
            animated: true,
            completion: nil)
        
//        self.controllerInset()
        
        menuView = MenuView(frame: CGRectMake(0, 64, self.view.frame.width, 40))
        menuView.backgroundColor = UIColor.blueColor()
//        menuView.alpha = 0.3
        self.view.addSubview(menuView)
        
        for view in self.pageViewController.view.subviews {
            if let scrollView = view as? UIScrollView {
                scrollView.delegate = self
            }
        }
    }
    
    // MARK: Private
    func controllerInset() {
        
        for controller in viewControllers {
            if let controller = controller as? UITableViewController {
                controller.tableView.contentInset.top = 64 + 50
                continue
            }
            if let controller = controller as? UICollectionViewController {
                controller.collectionView!.contentInset.top = 64 + 50
                continue
            }
            
            for view in controller.view.subviews {
                if let view = view as? UITableView {
                    view.contentInset.top = 64 + 50
                    break
                }
                if let view = view as? UICollectionView {
                    view.contentInset.top = 64 + 50
                    break
                }
                if let view = view as? UIScrollView {
                    view.contentInset.top = 64 + 50
                    break
                }
            }
        }
    }
}

extension ViewPager2: UIPageViewControllerDataSource {
    
    private func nextViewController(viewController: UIViewController, isAfter: Bool) -> UIViewController? {
        guard var index = viewControllers.indexOf(viewController) else {
            return nil
        }
        
        currentIndex = index
        print("current index : \(currentIndex)")
        if isAfter {
            index += 1
        } else {
            index -= 1
        }

        
        print("next index : \(index)")
        
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


extension ViewPager2: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        print(scrollView.contentOffset.x)
    }
}