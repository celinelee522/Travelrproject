//
//  ItemListTableViewController.swift
//  TravelrProject
//
//  Created by 이우재 on 2016. 8. 21..
//  Copyright © 2016년 LEE. All rights reserved.
//

import UIKit

class ItemListTableViewController: UITableViewController {

    @IBOutlet weak var travelNavibar: UINavigationItem!
    
    
    var travelTitle:String?
    var travelindex:Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        travelNavibar.title = travelTitle
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func getCategory(input:String) -> String {
        
        if input == "eating" {
            return "dining"
        }
        else if input == "sleeping" {
            return "hotel"
        }
        else if input == "transport" {
            return "transport"
        }
        else if input == "shopping" {
            return "shopping"
        }
        else {
            return "etc"
        }
        
    }
    
    func getPay(input:String) -> String {
        
        if input == "card" {
            return "card"
        }
        else {
            return "cash"
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        
        if let items = dataCenter.travels[travelindex!].items{
            let number = items.count
            return number
        }
        
        return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("itemList", forIndexPath: indexPath) as! ItemListTableViewCell
        
        if let itemlist = dataCenter.travels[travelindex!].items{
            
            
            cell.detail.text = itemlist[indexPath.row].detail
            cell.category.image = UIImage(named:getCategory(itemlist[indexPath.row].category))
            cell.pay.image = UIImage(named:getPay(itemlist[indexPath.row].pay))
            cell.currency.text = itemlist[indexPath.row].currency.symbol
            cell.price.text = String(itemlist[indexPath.row].price)
   
        }
        
        
        return cell
        
        
        
        // Configure the cell...

        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
       return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            dataCenter.travels[travelindex!].items!.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            dataCenter.save()
            
            self.tableView.reloadData()
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "itemEdit" {
            let destVC = segue.destinationViewController as! EditViewController
            
            let selectedIndex:NSIndexPath = self.tableView.indexPathForSelectedRow!
            let indexOfItem = selectedIndex.row
            let itemTitle = dataCenter.travels[travelindex!].items![selectedIndex.row].detail
            destVC.itemTitle = itemTitle
            destVC.itemIndex = indexOfItem
        }
        
    }
    

}
