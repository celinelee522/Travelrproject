//
//  ItemEditViewController.swift
//  TravelrProject
//
//  Created by Kim Seong Yup on 2016. 8. 23..
//  Copyright © 2016년 LEE. All rights reserved.
//

import UIKit

class ItemEditViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var numOfPeople: UITextField!
    @IBOutlet weak var date: UITextField!
    @IBOutlet weak var detail: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var currency: UISegmentedControl!
    @IBOutlet weak var pay: UISegmentedControl!
    
    var itemTitle:String?
    var travelIndex:Int?
    var itemIndex:Int?
    var currencyIndex:Int?
    
    @IBOutlet weak var naviTitle: UINavigationItem!
    
    // MARK : TextField Delegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        naviTitle.title = itemTitle
        
        //date.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.itemView()
    }
    
    func getPay(input:String) -> Int {
        
        if input == "card" {
            return 0
        }
        
        else {
            return 1
        }
    }
    
    func itemView() {
        
        if let index = itemIndex {
            
            let item = dataCenter.travels[travelIndex!].items![index]
            
            
            pay.selectedSegmentIndex = getPay(item.pay)
            currency.selectedSegmentIndex = currencyIndex!
            price.text = String(item.price)
            detail.text = item.detail
            date.text = item.ItemDate()
            numOfPeople.text = String(item.numberOfPerson)
            currency.setTitle(dataCenter.travels[travelIndex!].initCardBudget.BudgetCurrency.symbol,forSegmentAtIndex: 1)
            currency.setTitle(dataCenter.travels[travelIndex!].initCashBudget[0].BudgetCurrency.symbol,forSegmentAtIndex: 0)
            
        }
    }
    
    
    
    func editingItem(){
        
        var currencyNumber:Int = 0
        // 세그먼트 인덱스 설정 바꿔야함
        if currency.selectedSegmentIndex == 0 {
            
            currencyNumber = dataCenter.travels[travelIndex!].initCashBudget[0].BudgetCurrency.rawValue
        }
        
        if let price = price.text{
        let editItem = Item((price as NSString).doubleValue , Currency(rawValue:currencyNumber)!, pay.selectedSegmentIndex, 0, (numOfPeople.text! as NSString).integerValue)
        // 카테고리
            if let detail = detail.text{
                
                editItem.detail = detail
                
            }
            
            dataCenter.travels[travelIndex!].items![itemIndex!] = editItem

        }
        
        dataCenter.save()
    }

    
    func textFieldDidEndEditing(textField: UITextField) {
        let datePicker = UIDatePicker()
        textField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(ItemEditViewController.datePickerChanged(_:)), forControlEvents: .ValueChanged)
    }
    
    
    func datePickerChanged(sender: UIDatePicker) {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .LongStyle
        date.text = formatter.stringFromDate(sender.date) //string
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func closeKeyBoard() {
        self.view.endEditing(true)
    }
    
    // MARK : Touch event
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        closeKeyBoard()
    }
    
    
    @IBAction func cancel(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    
    
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if segue.identifier == "itemEditSegue" {
            
            let destVC = segue.destinationViewController as! ItemListTableViewController
            
            self.editingItem()
            
            destVC.itemEditing()
            
        }
        
        
    }
    

}
