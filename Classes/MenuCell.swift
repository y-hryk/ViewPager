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
    
    open var index: CGFloat = 0
    open var label: UILabel!
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
//        label.frame = CGRectMake(0, 0, self.frame.width, 40)
//        label.font = UIFont.systemFontOfSize(15)
        self.label.textColor = UIColor.black
        self.label.textAlignment = .center
        self.label.lineBreakMode = .byWordWrapping
        self.label.isUserInteractionEnabled = true
        self.label.backgroundColor = UIColor.clear
        self.contentView.addSubview(self.label)
        
        // tapGesture
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapAction))
//        self.label.addGestureRecognizer(tapGesture)
        
//        let view = UIView()
//        view.frame = CGRectMake(0, 0, 5, 40)
//        view.backgroundColor = UIColor.yellowColor()
//        self.contentView.addSubview(view)
    
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([
            NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .top, multiplier:1.0, constant: 0),
            NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: label, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1.0, constant: 0)
            ])
    }
    
    // MARK: Public
//    func setRowData(_ datas: [String], indexPath: IndexPath) {
//        
//        guard let text: String = datas[(indexPath as NSIndexPath).row] else {
//            return
//        }
//        
//        self.label.tag = (indexPath as NSIndexPath).row
//        self.label.text = "\(text)"
//    }
    
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
//        return 100
        return frame.width + (15 * 2)
//        return CGFloat(Int(frame.width) + 30)
    }
}

