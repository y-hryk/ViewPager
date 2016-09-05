//
//  SampleViewController.swift
//  ViewPagerDemo
//
//  Created by yamaguchi on 2016/08/31.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit

class SampleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = UITableView(frame: self.view.frame, style: .Plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = UIColor.orangeColor()
        self.view.addSubview(tableView)
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")

        // Do any additional setup after loading the view.
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        self.view.addConstraints([
            // Top
            NSLayoutConstraint(
                item: self.tableView,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: topLayoutGuide,
                attribute: .Bottom,
                multiplier: 1.0,
                constant: 0
            ),

            // Left
            NSLayoutConstraint(
                item: self.tableView,
                attribute: .Leading,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Leading,
                multiplier: 1.0,
                constant: 0
            ),
            
            // right
            NSLayoutConstraint(
                item: self.tableView,
                attribute: .Trailing,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Trailing,
                multiplier: 1.0,
                constant: 0
            ),
            
            // bottom
            NSLayoutConstraint(
                item: self.tableView,
                attribute: .Bottom,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Bottom,
                multiplier: 1.0,
                constant: 0
            )
            ]
        )
    }
    
    override func viewDidLayoutSubviews() {
        print("viewDidLayoutSubviews")
//        tableView.frame = self.view.frame
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        
        // Configure the cell...
        
        cell.textLabel!.text = "\(indexPath.row)"
        
        return cell
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
