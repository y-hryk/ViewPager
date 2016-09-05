
//
//  MenuView.swift
//  ViewPagerDemo
//
//  Created by yamaguchi on 2016/08/31.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit

public class MenuView: UIView {
    
    var indicatorView: UIView!
    private let factor: CGFloat = 4
    private var itemsWidth: CGFloat = 0.0
    private var collectionView : UICollectionView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        self.setupViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private
    private func setupViews() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        
        self.collectionView = UICollectionView(frame: CGRectMake(0, 0, self.frame.width, self.frame.height),
                                               collectionViewLayout: layout)
        self.collectionView.backgroundColor = UIColor.orangeColor()
        self.collectionView.registerClass(MenuCell.self, forCellWithReuseIdentifier: "MenuCell")
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.alwaysBounceHorizontal = true
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.addSubview(collectionView)
        
        indicatorView = UIView()
        indicatorView.frame = CGRectMake(0, self.frame.height - 2, 80, 2)
        indicatorView.backgroundColor = UIColor.blueColor()
        self.addSubview(indicatorView)
        
        
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([
            NSLayoutConstraint(item: self.collectionView, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier:1.0, constant: 0),
            NSLayoutConstraint(item: self.collectionView, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: self.collectionView, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: self.collectionView, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1.0, constant: 0)
        ])
    }
    
    
    // MARK: Public
    public func moveIndicator() {
        
    }
}

// MARK: UICollectionViewDataSource
extension MenuView : UICollectionViewDataSource {
    
    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5 * Int(factor)
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MenuCell", forIndexPath: indexPath) as! MenuCell
        
        cell.backgroundColor = UIColor.whiteColor()
        let index = indexPath.row % 5
        print("currentIndex : \(indexPath.row) \(index)")
//        print(index)
        cell.setRowData(["","","","","","","","","","",""], indexPath: NSIndexPath(forRow: index, inSection: 1))
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension MenuView: UICollectionViewDelegate {
    
    
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if itemsWidth == 0.0 {
            itemsWidth = floor(scrollView.contentSize.width / factor)
        }
        
        if (scrollView.contentOffset.x <= 0.0) || (scrollView.contentOffset.x > itemsWidth * 2.0) {
            scrollView.contentOffset.x = itemsWidth
        }
    }

    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 10.0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        return CGSize(width: MenuCell.width, height: MenuCell.height)
        return CGSize(width: 80, height: self.frame.height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10.0
    }
    
    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }

}
