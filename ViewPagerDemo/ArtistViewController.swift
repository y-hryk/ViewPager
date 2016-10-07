//
//  ArtistViewController.swift
//  ViewPagerDemo
//
//  Created by yamaguchi on 2016/08/31.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit

class ArtistViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
//        self.tableView.contentOffset = CGPoint(x: 0, y: self.tableView.contentInset.top)
        
        self.tableView.contentInset.top = 64 + 40
        self.tableView.contentOffset = CGPoint(x: 0, y: -self.tableView.contentInset.top)
        
        
        self.viewPagerController.viewPagerWillBeginDraggingHandler = { viewpager -> Void in
//            print("viewPagerWillBeginDraggingHandler")
        }
        
        self.viewPagerController.viewPagerDidEndDraggingHandler = { viewpager -> Void in
//            print("viewPagerDidEndDraggingHandler")
        }

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
//         NSLog("\(tableView.contentInset)")
        
//        self.tableView.contentInset.top = 64 + 40
//        self.tableView.contentOffset = CGPoint(x: 0, y: -self.tableView.contentInset.top)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.scrollsToTop = true
        
        self.viewPagerController.syncScrollViewOffset(scrollView: self.tableView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tableView.scrollsToTop = false
    }
    
    override func viewDidLayoutSubviews() {
        //        print("viewDidLayoutSubviews")
        //        print(self.view.frame)
        //        tableView.frame = self.view.frame
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 20
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        
        cell.textLabel!.text = "\((indexPath as NSIndexPath).row)"

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = UIViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
        print(self.parent?.parent)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        self.viewPagerController.updateScrollViewOffset(scrollView: scrollView)
    }
}

extension ArtistViewController: ViewPagerProtocol {
    
    var viewPagerController: ViewPager {
        return self.parent?.parent as! ViewPager
    }
    
    var scrollView: UIScrollView {
        return self.tableView
    }
}
