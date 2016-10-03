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
        let sampleVC1 = SampleViewController()
        sampleVC1.title = "long long long title"
        let sampleVC2 = SampleViewController()
        sampleVC2.title = "sample2"
        let sampleVC3 = SampleViewController()
        sampleVC3.title = "sample3"
        let sampleVC4 = SampleViewController()
        sampleVC4.title = "sample4"
        let sampleVC5 = SampleViewController()
        sampleVC5.title = "sample5"
        let controllers = [artistVC, playlistVC, albumVC, sampleVC1, sampleVC2, sampleVC3]
        
        
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

