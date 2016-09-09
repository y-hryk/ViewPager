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
        self.title = "View Pager"
        
        let artistVC = ArtistViewController()
        artistVC.title = "long long title"
        let playlistVC = PlayListViewController()
        playlistVC.title = "playlist"
        let albumVC = AlbumViewController()
        albumVC.title = "album"
        let sampleVC = SampleViewController()
        sampleVC.title = "sample"
        let controllers = [artistVC, playlistVC, albumVC, sampleVC]
        
        
        let viewpager = ViewPager(controllers: controllers,
                                  option: ViewPagerOption(),
                                  parentViewController: self)
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

