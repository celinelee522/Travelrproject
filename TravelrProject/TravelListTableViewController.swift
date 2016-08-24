//
//  TravelListTableViewController.swift
//  TravelrProject
//
//  Created by 이우재 on 2016. 8. 19..
//  Copyright © 2016년 LEE. All rights reserved.
//

import UIKit

class TravelListTableViewController: UITableViewController {
    
    var cashCurrencyIndex:Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    //여행추가 및 저장 하여 테이블뷰 다시 보여주는 함수
    func addNew(newTravel:TravelWhere) {
        
        dataCenter.travels.append(newTravel)
        
        dataCenter.save()
        
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool)
    {
        self.navigationController?.navigationBarHidden = false
    }
    
    
    @IBAction func toTravelList(unwind:UIStoryboardSegue){
        
        self.tableView.reloadData()
        
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
        return dataCenter.travels.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("travelListView", forIndexPath: indexPath) as! TravelContentTableViewCell

        let travelItem = dataCenter.travels[indexPath.row]
        
        cell.travelTitle.text = travelItem.title
        cell.travelPeriod.text = travelItem.period
        
        cell.travelBackground.image = travelItem.background
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            dataCenter.travels.removeAtIndex(indexPath.row)
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
        
        
        if segue.identifier == "mainSegue" {
            //목적지 뷰 컨트롤러 확보
            let destVC = segue.destinationViewController as! MainViewController
            
            //테이블 뷰에서 선택된 오브젝트 확보
            let selectedIndex:NSIndexPath = self.tableView.indexPathForSelectedRow!
            
            let indexOfTravel = selectedIndex.row
            let travelTitle = dataCenter.travels[selectedIndex.row].title
            
            //목적지 뷰 컨트롤러에 선택된 오브젝트 전달
            destVC.travelIndex = indexOfTravel
            destVC.travelName = travelTitle
            destVC.travelCurrencyIndex = cashCurrencyIndex
        }
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
