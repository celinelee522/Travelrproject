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
    func addNew(_ newTravel:TravelWhere) {
        
        dataCenter.travels.append(newTravel)
        
        dataCenter.save()
        
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    @IBAction func toTravelList(_ unwind:UIStoryboardSegue){
        
        self.tableView.reloadData()
        
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataCenter.travels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "travelListView", for: indexPath) as! TravelContentTableViewCell

        let travelItem = dataCenter.travels[(indexPath as NSIndexPath).row]
        
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

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataCenter.travels.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            dataCenter.save()
            
            self.tableView.reloadData()
            
        } else if editingStyle == .insert {
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "mainSegue" {
            //목적지 뷰 컨트롤러 확보
            let destVC = segue.destination as! MainViewController
            
            //테이블 뷰에서 선택된 오브젝트 확보
            let selectedIndex:IndexPath = self.tableView.indexPathForSelectedRow!
            
            let indexOfTravel = (selectedIndex as NSIndexPath).row
            let travelTitle = dataCenter.travels[(selectedIndex as NSIndexPath).row].title
            
            //목적지 뷰 컨트롤러에 선택된 오브젝트 전달
            destVC.travelIndex = indexOfTravel
            destVC.travelName = travelTitle
            destVC.travelCurrencyIndex = cashCurrencyIndex
        }
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
