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

        self.view.backgroundColor = UIColor.orange
        
        let label = UILabel()
        label.frame = self.view.frame
        label.center = self.view.center
        label.textAlignment = .center
        label.text = "AlbumViewController"
        
        self.view.addSubview(label)
        let view = UIView()
        view.frame = CGRect(x: 0, y: self.view.frame.height - 50, width: 200, height: 50)
        view.backgroundColor = UIColor.red
        self.view.addSubview(view)
  
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Do any additional setup after loading the view.
 
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
