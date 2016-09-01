//
//  ViewPager.swift
//  ViewPagerDemo
//
//  Created by yamaguchi on 2016/08/31.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit

protocol ViewPagerDelegate {
    
}

public class ViewPager: UIViewController {
    
    private var viewControllers = [UIViewController]()
    private var containerScrollView = UIScrollView()
    
    private var topBarHeight: CGFloat = 0
    
    init(controllers: [UIViewController], parentViewController: ViewController) {
        super.init(nibName: nil, bundle: nil)
        NSLog("init")
        
        viewControllers = controllers
        topBarHeight = 64
        //
        parentViewController.addChildViewController(self)
        parentViewController.automaticallyAdjustsScrollViewInsets = false
//        parentViewController.navigationController?.hidesBarsOnSwipe = true
        self.didMoveToParentViewController(parentViewController)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        // scrollView Setting
//        self.automaticallyAdjustsScrollViewInsets = false;
        containerScrollView.frame = CGRectMake(0, topBarHeight, self.view.frame.width, self.view.frame.height - topBarHeight)
        containerScrollView.pagingEnabled = true
        containerScrollView.showsHorizontalScrollIndicator = false;
        containerScrollView.delegate = self
        containerScrollView.contentSize = CGSizeMake(containerScrollView.frame.size.width * CGFloat(viewControllers.count), containerScrollView.frame.size.height);
        
        for (index, element) in viewControllers.enumerate() {
            NSLog("\(index)")
            let width: CGFloat = containerScrollView.frame.width
            let height: CGFloat = containerScrollView.frame.height
            element.view.frame = CGRectMake(CGFloat(index) * width , 0, width, height)
//            element.view.backgroundColor = UIColor.grayColor()
            if index == 1 {
                element.view.backgroundColor = UIColor.orangeColor()
            }
            containerScrollView.addSubview(element.view)
        }
        
        self.view.addSubview(containerScrollView)
    }

}

extension ViewPager: UIScrollViewDelegate {
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        NSLog("\(scrollView.contentOffset.x)")
    }
}

