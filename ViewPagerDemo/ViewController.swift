//
//  ViewController.swift
//  ViewPagerDemo
//
//  Created by yamaguchi on 2016/08/31.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let viewpager = ViewPager(controllers: [ArtistViewController(), PlayListViewController(), AlbumViewController(), SampleViewController()], parentViewController: self)
        self.view.addSubview(viewpager.view)
        
//        self.addChildViewController(viewpager)
//        //        parentViewController.automaticallyAdjustsScrollViewInsets = false
//        viewpager.didMoveToParentViewController(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

