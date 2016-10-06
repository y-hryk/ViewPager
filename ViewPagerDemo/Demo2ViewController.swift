//
//  Demo2ViewController.swift
//  ViewPagerDemo
//
//  Created by yamaguchi on 2016/10/04.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit

class Demo2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "View Pager"
        
        let vc1 = ArtistViewController()
        vc1.title = "月"
        let vc2 = ArtistViewController()
        vc2.title = "火"
        let vc3 = ArtistViewController()
        vc3.title = "水"
        let vc4 = ArtistViewController()
        vc4.title = "木"
        let vc5 = ArtistViewController()
        vc5.title = "金"
        let vc6 = ArtistViewController()
        vc6.title = "土"
        let vc7 = ArtistViewController()
        vc7.title = "日"
        let controllers = [vc1, vc2, vc3, vc4, vc5, vc6, vc7]
        
        var option = ViewPagerOption()
        option.pagerType = .segmeted
        
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
