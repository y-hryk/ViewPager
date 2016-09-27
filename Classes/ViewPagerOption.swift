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
        case `default`
        case infinityFixed
        case infinityFlexible
        case segmeted
        
        func isInfinity() -> Bool {
            switch self {
            case .`default`:
                return false
            case .infinityFixed:
                fallthrough
            case .infinityFlexible:
                return true
            case .segmeted:
                return false
            }
        }
    }
    public var pagerType: pagerType = .segmeted
    
    // menuView
    public var backgroundColor = UIColor.white
    public var menuItemFontColor = UIColor.lightGray
    public var menuItemFont = UIFont.systemFont(ofSize: 15)
    public var menuItemSelectedFontColor = UIColor.black
    public var menuItemSelectedFont = UIFont.systemFont(ofSize: 15)
    public var menuItemIndicatorColor = UIColor.blue
    public var menuItemShadowColor = UIColor.lightGray
    public var menuItemHeight: CGFloat = 40.0
    public var menuItemMargin: CGFloat = 15.0
    public var menuItemWidth: CGFloat?
    
}
