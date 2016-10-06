//
//  MenuCell.swift
//  ViewPagerDemo
//
//  Created by yamaguchi on 2016/09/01.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit

open class MenuCell: UICollectionViewCell {
    
    open var label: UILabel!
    open var indicator: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private
    func setupViews() {
        self.backgroundColor = UIColor.clear
        
        self.indicator = UIView()
        self.contentView.addSubview(self.indicator)
        
        self.label = UILabel()
        self.label.textColor = UIColor.black
        self.label.textAlignment = .center
        self.label.lineBreakMode = .byTruncatingTail
        self.label.isUserInteractionEnabled = true
        self.label.backgroundColor = UIColor.clear
        self.contentView.addSubview(self.label)
        
    
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([
            NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .top, multiplier:1.0, constant: 0),
            NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: label, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1.0, constant: 0)
            ])
    }
    
    // MARK: Public
    func setRowData( datas: [String], indexPath: IndexPath, currentIndex: Int, option: ViewPagerOption) {
        
        if datas.isEmpty { return }
        
        let index = indexPath.row % datas.count
        
        self.label.tag = indexPath.row
        self.label.text = ""
        
        self.label.font = option.menuItemFont
        self.label.text = datas[index]
        
        self.indicator.backgroundColor = option.menuItemIndicatorColor
        let width = MenuCell.cellWidth(datas[index], option: option)
        
        self.indicator.layer.cornerRadius = option.indicatorRadius
        if option.indicatorType == .line {
            self.indicator.frame = CGRect(x: 0, y: self.frame.size.height - 1.5, width: width, height: 1.5)
        } else {
            self.indicator.frame = CGRect(x: 0, y: 5, width: width, height: 30)
        }
        
        if currentIndex % datas.count == index {
            self.label.textColor = option.menuItemSelectedFontColor
            self.label.font = option.menuItemSelectedFont
            self.indicator.isHidden = false
        } else {
            self.label.textColor = option.menuItemFontColor
            self.label.font = option.menuItemFont
            self.indicator.isHidden = true
        }
    }
    
    static func cellWidth(_ text: String, option: ViewPagerOption) -> CGFloat {
//        CGSize maxSize = CGSizeMake(CGFloat.max, 40);
        
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        style.lineBreakMode = .byWordWrapping
        
        let attributes =  [NSFontAttributeName : option.menuItemFont,
                           NSParagraphStyleAttributeName : style]
        
        let options = unsafeBitCast(
            NSStringDrawingOptions.usesLineFragmentOrigin.rawValue |
                NSStringDrawingOptions.usesFontLeading.rawValue,
            to: NSStringDrawingOptions.self)
        
        let frame = text.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 40),
                                                    options: options,
                                                    attributes: attributes,
                                                    context: nil)
//        let width = max(frame.width + 10 + 10,80)
        
//        return frame.width + (5 * 2) + (5 * 2)
//        return 100
        
        if let itemWidth = option.menuItemWidth {
            return itemWidth
        } else {
            return CGFloat(Int(frame.width) + (Int(option.menuItemMargin) * 2))
        }
    }
}

