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
    public var pagerBackgoundColor: UIColor = UIColor.white
    public enum pagerType {
        
        case normal
        case segmeted
        case infinity
        
        func isInfinity() -> Bool {
            switch self {
            case .normal:
                return false
            case .segmeted:
                return false
            case .infinity:
                return true
            }
        }
    }
    public var pagerType: pagerType = .normal
    
    public enum pagerLayoutType {
        case fullScreen
        case flexible
    }
    
    public enum indicatorType {
        case line
        case box
    }
    
    public var pagerLayoutType: pagerLayoutType = .fullScreen
    public var indicatorType: indicatorType = .line
    
    // menuView
    public var backgroundColor = UIColor.white
    public var menuItemFontColor = UIColor.lightGray
    public var menuItemFont = UIFont.systemFont(ofSize: 15)
    public var menuItemSelectedFontColor = UIColor.black
    public var menuItemSelectedFont = UIFont.systemFont(ofSize: 15)
    public var menuItemIndicatorColor = UIColor.blue
    public var menuItemShadowColor = UIColor.lightGray
    public var menuItemHeight: CGFloat = 40.0
    public var menuItemMargin: CGFloat = 10.0
    public var menuItemWidth: CGFloat?
    public var indicatorRadius: CGFloat = 0.0
    
}
