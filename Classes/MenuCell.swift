//
//  MenuCell.swift
//  ViewPagerDemo
//
//  Created by yamaguchi on 2016/09/01.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit

public class MenuCell: UICollectionViewCell {
    
    private var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private
    func setupViews() {
        self.backgroundColor = UIColor.clearColor()
        label = UILabel()
//        label.frame = CGRectMake(0, 0, self.frame.width, 40)
        label.font = UIFont.systemFontOfSize(15)
        label.textColor = UIColor.blackColor()
        label.textAlignment = .Center
//        label.lineBreakMode = .ByWordWrapping
        self.label.backgroundColor = UIColor.clearColor()
        self.contentView.addSubview(label)
        
        // label layout
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([
            NSLayoutConstraint(item: label, attribute: .Top, relatedBy: .Equal, toItem: self.contentView, attribute: .Top, multiplier:1.0, constant: 0),
            NSLayoutConstraint(item: label, attribute: .Leading, relatedBy: .Equal, toItem: self.contentView, attribute: .Leading, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: label, attribute: .Trailing, relatedBy: .Equal, toItem: self.contentView, attribute: .Trailing, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: label, attribute: .Bottom, relatedBy: .Equal, toItem: self.contentView, attribute: .Bottom, multiplier: 1.0, constant: 0)
            ])
    }
    
    // MARK: Public
    func setRowData(datas: [String], indexPath: NSIndexPath) {
        guard let text: String = datas[indexPath.row] else {
            return
        }
        
        label.text = "\(text)" + "\(indexPath.row)"
        
//        let width = MenuCell.cellWidth(text, font: UIFont.systemFontOfSize(15))
//        label.frame = CGRectMake(0, 0, width, 40)
//        print(self.frame.size.width)

        
    }
    
    static func cellWidth(text: String, font: UIFont) -> CGFloat {
//        CGSize maxSize = CGSizeMake(CGFloat.max, 40);
        
        let style = NSMutableParagraphStyle()
//        style.alignment = .Center
//        style.lineBreakMode = .ByWordWrapping
        
        let attributes =  [NSFontAttributeName : font,
                           NSParagraphStyleAttributeName : style]
        
        let options = unsafeBitCast(
            NSStringDrawingOptions.UsesLineFragmentOrigin.rawValue |
                NSStringDrawingOptions.UsesFontLeading.rawValue,
            NSStringDrawingOptions.self)
        
        let frame = text.boundingRectWithSize(CGSizeMake(CGFloat.max, 40),
                                                    options: options,
                                                    attributes: attributes,
                                                    context: nil)
//        let width = max(frame.width + 10 + 10,80)
        return 100
//        return CGFloat(Int(frame.width) + 30)
    }
}

