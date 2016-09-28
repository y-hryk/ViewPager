//
//  MenuCell.swift
//  ViewPagerDemo
//
//  Created by yamaguchi on 2016/09/01.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit

public protocol MenuCellDelegate: class {
    func menuCellDidTapItem(index: Int)
}

open class MenuCell: UICollectionViewCell {
    
    open var label: UILabel!
    open var indicator: UIView!
    open weak var delegate: MenuCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private
    func setupViews() {
        self.backgroundColor = UIColor.white
        
        self.label = UILabel()
        self.label.textColor = UIColor.black
        self.label.textAlignment = .center
        self.label.lineBreakMode = .byWordWrapping
        self.label.isUserInteractionEnabled = true
        self.label.backgroundColor = UIColor.orange
        self.contentView.addSubview(self.label)
        
        self.indicator = UIView()
        self.contentView.addSubview(self.indicator)
    
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
        let width = MenuCell.cellWidth(datas[index], font: option.menuItemFont)
        self.indicator.frame = CGRect(x: 0, y: self.frame.size.height - 2, width: width, height: 2)
        
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
    
    // MARK: Selctor
    func labelTapAction(gesture: UITapGestureRecognizer) {
        
        guard let index = gesture.view?.tag else {
            return
        }
        
        self.delegate?.menuCellDidTapItem(index: index)
    }
    
    static func cellWidth(_ text: String, font: UIFont) -> CGFloat {
//        CGSize maxSize = CGSizeMake(CGFloat.max, 40);
        
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        style.lineBreakMode = .byWordWrapping
        
        let attributes =  [NSFontAttributeName : font,
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
        return CGFloat(Int(frame.width) + (10 * 2))
//        return CGFloat(Int(frame.width) + 30)
    }
}

