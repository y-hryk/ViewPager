//
//  ViewPagerOption.swift
//  ViewPagerDemo
//
//  Created by yamaguchi on 2016/09/10.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit

public struct ViewPagerOption {
    
    public init() {}
    // viewPager
    public var pagerBackgoundColor: UIColor = UIColor.whiteColor()
    
    public enum pageType {
        case Default
        case Infinity
    }
    
    // menuView
    public var backgroundColor = UIColor.whiteColor()
    public var menuItemFontColor = UIColor.blackColor()
    public var menuItemFont = UIFont.systemFontOfSize(15)
    public var menuItemIndicatorColor = UIColor.blueColor()
    public var menuItemShadowColor = UIColor.lightGrayColor()
    public var menuItemHeight: CGFloat = 40.0
    public var menuItemMargin: CGFloat = 15.0
    public var menuItemWidth: CGFloat?
    
}