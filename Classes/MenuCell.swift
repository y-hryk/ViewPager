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
    
    func setupViews() {
        label = UILabel()
        label.frame = CGRectMake(0, 0, self.frame.width, 40)
        label.font = UIFont.systemFontOfSize(15)
        label.textColor = UIColor.blackColor()
        label.textAlignment = .Center
        self.contentView.addSubview(label)
    }
    
    func setRowData(datas: [String], indexPath: NSIndexPath) {
//        guard let text = datas[indexPath.row] as? String else {
//            return
//        }
        
        label.text = "index" + "\(indexPath.row)"
    }
}

