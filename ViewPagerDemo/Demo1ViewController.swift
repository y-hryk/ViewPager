//
//  Demo1ViewController.swift
//  ViewPagerDemo
//
//  Created by yamaguchi on 2016/10/04.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit

class Demo1ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        var option = ViewPagerOption()
        option.pagerType = .normal
        
        let viewpager = ViewPager(controllers: controllers,
                                  option: option,
                                  parentViewController: self)
        self.view.addSubview(viewpager.view)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
