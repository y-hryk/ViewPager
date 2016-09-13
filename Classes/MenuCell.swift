//
//  MenuCell.swift
//  ViewPagerDemo
//
//  Created by yamaguchi on 2016/09/01.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit

public protocol MenuCellDelegate: class {
    func menuCellDidTapItem(index index: Int)
}

public class MenuCell: UICollectionViewCell {
    
    public var label: UILabel!
    public weak var delegate: MenuCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private
    func setupViews() {
        self.backgroundColor = UIColor.whiteColor()
        self.label = UILabel()
//        label.frame = CGRectMake(0, 0, self.frame.width, 40)
//        label.font = UIFont.systemFontOfSize(15)
        self.label.textColor = UIColor.blackColor()
        self.label.textAlignment = .Center
        self.label.lineBreakMode = .ByWordWrapping
        self.label.userInteractionEnabled = true
        self.label.backgroundColor = UIColor.clearColor()
        self.contentView.addSubview(self.label)
        
        // tapGesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapAction))
        self.label.addGestureRecognizer(tapGesture)
        
//        let view = UIView()
//        view.frame = CGRectMake(0, 0, 5, 40)
//        view.backgroundColor = UIColor.yellowColor()
//        self.contentView.addSubview(view)
    
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
        
        self.label.tag = indexPath.row
        self.label.text = "\(text)"
    }
    
    // MARK: Selctor
    func labelTapAction(gesture gesture: UITapGestureRecognizer) {
        
        guard let index = gesture.view?.tag else {
            return
        }
        
        self.delegate?.menuCellDidTapItem(index: index)
    }
    
    static func cellWidth(text: String, font: UIFont) -> CGFloat {
//        CGSize maxSize = CGSizeMake(CGFloat.max, 40);
        
        let style = NSMutableParagraphStyle()
        style.alignment = .Center
        style.lineBreakMode = .ByWordWrapping
        
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
//        return 100
        return frame.width + (15 * 2)
//        return CGFloat(Int(frame.width) + 30)
    }
}

