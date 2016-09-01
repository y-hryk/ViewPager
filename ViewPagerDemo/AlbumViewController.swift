//
//  AlbumViewController.swift
//  ViewPagerDemo
//
//  Created by yamaguchi on 2016/08/31.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

  
    }
    
    override func viewDidAppear(animated: Bool) {
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.orangeColor()
        
        let label = UILabel()
        label.frame = self.view.frame
        label.center = self.view.center
        label.textAlignment = .Center
        label.text = "AlbumViewController"
        
        self.view.addSubview(label)
        let view = UIView()
        view.frame = CGRectMake(0, self.view.frame.height - 50, 200, 50)
        view.backgroundColor = UIColor.redColor()
        self.view.addSubview(view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
