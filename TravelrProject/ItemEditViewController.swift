//
//  ItemEditViewController.swift
//  TravelrProject
//
//  Created by Kim Seong Yup on 2016. 8. 23..
//  Copyright © 2016년 LEE. All rights reserved.
//

import UIKit

class ItemEditViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var shoppingImage: UIImageView!
    
    @IBOutlet weak var transportImage: UIImageView!
    
    @IBOutlet weak var eatingImage: UIImageView!
    
    @IBOutlet weak var etcImage: UIImageView!
   
    @IBOutlet weak var sleepingImage: UIImageView!
    
    @IBOutlet weak var numOfPeople: UITextField!
    @IBOutlet weak var date: UITextField!
    @IBOutlet weak var detail: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var currency: UISegmentedControl!
    @IBOutlet weak var pay: UISegmentedControl!
    
    var itemTitle:String?
    var travelIndex:Int?
    var itemIndex:Int?
    var categorySelect:Int = 0
    
    @IBOutlet weak var naviTitle: UINavigationItem!
    
    // MARK : TextField Delegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        date.delegate = self
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
            
            if item.currency.rawValue == 0{
                
                currency.selectedSegmentIndex = 1
            }
            else{
                currency.selectedSegmentIndex = 0
            }
            
            pay.selectedSegmentIndex = getPay(item.pay)
            
            price.text = String(item.price)
            detail.text = item.detail
            date.text = item.ItemDate()
            numOfPeople.text = String(item.numberOfPerson)
            currency.setTitle(dataCenter.travels[travelIndex!].initCardBudget.BudgetCurrency.symbol,forSegmentAtIndex: 1)
            currency.setTitle(dataCenter.travels[travelIndex!].initCashBudget[0].BudgetCurrency.symbol,forSegmentAtIndex: 0)
            
            shoppingImage.image = UIImage(named: "shopping")
            transportImage.image = UIImage(named: "transport")
            eatingImage.image = UIImage(named: "dining")
            sleepingImage.image = UIImage(named:"hotel")
            shoppingImage.image = UIImage(named: "shopping")
            etcImage.image = UIImage(named: "etc")
            
            for i in 0...4{
                if item.category == setCategory(i){
                    switch i {
                    case 0:
                        eatingImage.image = UIImage(named: "dining_sel")
                    case 1:
                        sleepingImage.image = UIImage(named: "hotel_sel")
                    case 2:
                        transportImage.image = UIImage(named: "transport_sel")
                    case 3:
                        shoppingImage.image = UIImage(named: "shopping_sel")
                    default:
                        etcImage.image = UIImage(named: "etc_sel")
                    }

                    
                }
            }
            
        }
    }
    
    @IBAction func eatingCategory(sender: AnyObject) {
        
        categorySelect = 0
        eatingImage.image = UIImage(named: "dining_sel")
        shoppingImage.image = UIImage(named: "shopping")
        sleepingImage.image = UIImage(named:"hotel")
        transportImage.image = UIImage(named: "transport")
        etcImage.image = UIImage(named: "etc")
        
        
    }
    
    @IBAction func sleepingCategory(sender: AnyObject) {
        
        categorySelect = 1
        sleepingImage.image = UIImage(named:"hotel_sel")
        eatingImage.image = UIImage(named: "dining")
        shoppingImage.image = UIImage(named:"shopping")
        transportImage.image = UIImage(named: "transport")
        etcImage.image = UIImage(named: "etc")
        
    }
    
    @IBAction func transportCategory(sender: AnyObject) {
        
        categorySelect = 2
        transportImage.image = UIImage(named: "transport_sel")
        eatingImage.image = UIImage(named: "dining")
        sleepingImage.image = UIImage(named:"hotel")
        shoppingImage.image = UIImage(named: "shopping")
        etcImage.image = UIImage(named: "etc")
        
    }
    
    @IBAction func shoppingCategory(sender: AnyObject) {
        
        categorySelect = 3
        shoppingImage.image = UIImage(named: "shopping_sel")
        eatingImage.image = UIImage(named: "dining")
        sleepingImage.image = UIImage(named:"hotel")
        transportImage.image = UIImage(named: "transport")
        etcImage.image = UIImage(named: "etc")
        
    }
    
    @IBAction func etcCategory(sender: AnyObject) {
        
        categorySelect = 4
        etcImage.image = UIImage(named: "etc_sel")
        eatingImage.image = UIImage(named: "dining")
        sleepingImage.image = UIImage(named:"hotel")
        transportImage.image = UIImage(named: "transport")
        shoppingImage.image = UIImage(named: "shopping")
        
        
    }
    
    
    
    func editingItem(){
        
        var currencyNumber:Int = 0
        // 세그먼트 인덱스 설정 바꿔야함
        if currency.selectedSegmentIndex == 0 {
            
            currencyNumber = dataCenter.travels[travelIndex!].initCashBudget[0].BudgetCurrency.rawValue
        }
        
        if let price = price.text{
            let editItem = Item((price as NSString).doubleValue , Currency(rawValue:currencyNumber)!, pay.selectedSegmentIndex, categorySelect, (numOfPeople.text! as NSString).integerValue)
                // 카테고리
            if let detail = detail.text{
                
                editItem.detail = detail
                
            }
            
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy년 MM월 dd일"
            editItem.date = dateFormatter.dateFromString(date.text!)!
            
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
        formatter.dateFormat = "yyyy년 MM월 dd일"
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
