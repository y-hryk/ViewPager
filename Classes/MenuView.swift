
//
//  MenuView.swift
//  ViewPagerDemo
//
//  Created by yamaguchi on 2016/08/31.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit

public protocol MenuViewDelegate: class {
    func menuViewDidTapMeunItem(index index: Int)
}

public class MenuView: UIView {
    
    public weak var delegate: MenuViewDelegate?
    private var option = ViewPagerOption()
    var indicatorView: UIView!
    private let factor: CGFloat = 4
    private var currentIndex: Int = 0
    private var currentOffsetX: CGFloat = 0.0
    private var itemsWidth: CGFloat = 0.0
    private var collectionView : UICollectionView!
    private var titles = [String]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        self.setupViews()
    }
    
    init(titles: [String], option: ViewPagerOption) {
        super.init(frame: CGRectZero)
        self.titles = titles
        self.option = option
        self.setupViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private
    private func setupViews() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        self.collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        self.collectionView.backgroundColor = UIColor.whiteColor()
        self.collectionView.registerClass(MenuCell.self, forCellWithReuseIdentifier: "MenuCell")
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.alwaysBounceHorizontal = true
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.scrollsToTop = false
        self.addSubview(self.collectionView)
        
        let shadowView = UIView()
        shadowView.backgroundColor = UIColor.lightGrayColor()
        self.addSubview(shadowView)
        
        self.indicatorView = UIView()
        self.indicatorView.frame = CGRectMake((self.frame.width / 2) - (80 / 2), self.frame.height - 2, 80, 2)
        self.indicatorView.backgroundColor = UIColor.blueColor()
        self.addSubview(self.indicatorView)
        
        
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([
            NSLayoutConstraint(item: self.collectionView, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier:1.0, constant: 0),
            NSLayoutConstraint(item: self.collectionView, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: self.collectionView, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: self.collectionView, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1.0, constant: 0)
        ])
        
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([
            NSLayoutConstraint(item: shadowView, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: shadowView, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: shadowView, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1.0, constant: 0.5),
            NSLayoutConstraint(item: shadowView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1.0, constant: 0.5)
        ])
    }
    
    
    // MARK: Public
    
    public func scrollToMenuItemAtIndex(index index: Int, animated: Bool) {
        currentIndex = index + self.titles.count
//        print("currentIndex: \(currentIndex)")
        let indexPath = NSIndexPath(forItem: currentIndex, inSection: 0)
        self.collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredHorizontally, animated: animated)
        self.currentOffsetX = self.collectionView.contentOffset.x
        let itemWidth = MenuCell.cellWidth(self.titles[index], font: UIFont.systemFontOfSize(15))
        self.indicatorView.frame = CGRectMake((self.frame.width / 2) - (itemWidth / 2), self.frame.height - 2, itemWidth, 2)
//        print("------------------ \(self.currentOffsetX)")
    }
    
    public func updateMenuScrollPosition(index index: Int) {
       self.currentOffsetX = self.collectionView.contentOffset.x
    }
    
    public func moveIndicator(currentIndex currentIndex: Int, nextIndex: Int, offsetX: CGFloat) {
        let currentItemWidth = MenuCell.cellWidth(self.titles[currentIndex], font: UIFont.systemFontOfSize(15))
        let nextItemWidth = MenuCell.cellWidth(self.titles[nextIndex], font: UIFont.systemFontOfSize(15))
        
//        print(offsetX)
//        print("currentItemWidth : \(currentItemWidth)")
//        print("nextItemWidth : \(nextItemWidth)")
        
//        if self.currentOffsetX == 0 {
//            self.currentOffsetX = self.collectionView.contentOffset.x
//        }
        
        let diff = offsetX / self.frame.width
        let diffWidth = fabs(diff) * (nextItemWidth - currentItemWidth)
        let itemWidth = currentItemWidth + diffWidth
        self.indicatorView.frame = CGRectMake((self.frame.width / 2) - (itemWidth / 2), self.frame.height - 2, itemWidth, 2)
        let itemOffetX = (currentItemWidth / 2.0) + (nextItemWidth / 2.0)
        
        let scrollOffsetX = diff * itemOffetX
        self.collectionView.contentOffset.x = self.currentOffsetX + scrollOffsetX
        
        //
//        if self.collectionView.contentOffset.x >= self.currentOffsetX + itemOffetX {
//            self.scrollToMenuItemAtIndex(index: currentIndex)
//        }
    }
}

// MARK: UICollectionViewDataSource
extension MenuView : UICollectionViewDataSource {
    
    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.titles.count * Int(factor)
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MenuCell", forIndexPath: indexPath) as! MenuCell
        
        let index = indexPath.row % self.titles.count
//        print("currentIndex : \(indexPath.row) \(index)")
//        print(index)
        cell.label.font = self.option.menuItemFont
        cell.delegate = self
        cell.setRowData(self.titles, indexPath: NSIndexPath(forRow: index, inSection: 1))
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
        
//        print(scrollView.contentOffset.x)
    }

    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        return CGSize(width: MenuCell.width, height: MenuCell.height)
        
        let index = indexPath.row % self.titles.count
        let width = MenuCell.cellWidth(self.titles[index], font: self.option.menuItemFont)
        return CGSize(width: width, height: self.frame.height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
    
    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }

}

extension MenuView: MenuCellDelegate {
    public func menuCellDidTapItem(index index: Int) {
        print(index)
        self.delegate?.menuViewDidTapMeunItem(index: index)
    }
}
