//
//  MainViewController.swift
//  TravelrProject
//
//  Created by 이우재 on 2016. 8. 17..
//  Copyright © 2016년 LEE. All rights reserved.
//

import UIKit



class MainViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var eatingImage: UIImageView!
    
    @IBOutlet weak var shoppingImage: UIImageView!
    
    @IBOutlet weak var sleepingImage: UIImageView!
    
    @IBOutlet weak var transportImage: UIImageView!
    
    @IBOutlet weak var etcImage: UIImageView!
    
    @IBOutlet weak var priceSet: UITextField!
    
    @IBOutlet weak var detailSet: UITextField!
    
    @IBOutlet weak var travelTitle: UINavigationItem!
    
    @IBOutlet weak var currencySegment: UISegmentedControl!
    
    
    @IBOutlet weak var cashCurrency: UILabel!
    
    @IBOutlet weak var cashUsed1: UILabel!
    @IBOutlet weak var cashBudget1: UILabel!
    @IBOutlet weak var cashUsedWon: UILabel!
    @IBOutlet weak var cashBudget2: UILabel!

    @IBOutlet weak var cardCurrency: UILabel!
    
    @IBOutlet weak var cardUsedWon: UILabel!
    @IBOutlet weak var cardUsed: UILabel!
    @IBOutlet weak var cardBudget: UILabel!
    
    
    var travelName:String?
    var travelIndex:Int?
    var travelCurrencyIndex:Int?
    var payCashOrCard:Int = 0
    var categorySelect:Int = 0
    
    
    @IBAction func toMainAfterEdit(unwind:UIStoryboardSegue){
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        travelTitle.title = travelName
        
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func payCard(sender: AnyObject) {
        
        
        
        
    }
    @IBAction func payCash(sender: AnyObject) {
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.budgetView()
        priceSet.text = ""
        detailSet.text = ""
    }
    
    
    
    @IBAction func toMainView(unwind:UIStoryboardSegue){
    }
    
    
    func budgetView() {
        
        if let index = travelIndex{
            
            
            let indexCurrency = dataCenter.travels[index].initCashBudget[0].BudgetCurrency
            let indexCurrencyWon = Currency(rawValue: 0)!
            
            cashCurrency.text = indexCurrency.symbol
            cardCurrency.text = indexCurrency.symbol
            cashUsed1.text = String(dataCenter.travels[index].MoneyByPayCurrency(indexCurrency).cashSpend)
            cashUsedWon.text = String(dataCenter.travels[index].MoneyByPayCurrency(indexCurrencyWon).cashSpend)
            cashBudget1.text = String(dataCenter.travels[index].initCashBudget[0].Money)
            cashBudget2.text = String(dataCenter.travels[index].initCashBudget[1].Money)
            cardUsed.text = String(dataCenter.travels[index].MoneyByPayCurrency(indexCurrency).cardSpend)
            cardUsedWon.text = String(dataCenter.travels[index].MoneyByPayCurrency(indexCurrencyWon).cardSpend)
            cardBudget.text = String(dataCenter.travels[index].initCardBudget.Money)
            
            currencySegment.setTitle(dataCenter.travels[index].initCardBudget.BudgetCurrency.symbol,forSegmentAtIndex: 1)
            currencySegment.setTitle(dataCenter.travels[index].initCashBudget[0].BudgetCurrency.symbol,forSegmentAtIndex: 0)
            
            shoppingImage.image = UIImage(named: "shopping")
            transportImage.image = UIImage(named: "transport")
            eatingImage.image = UIImage(named: "dining")
            sleepingImage.image = UIImage(named:"hotel")
            shoppingImage.image = UIImage(named: "shopping")
            etcImage.image = UIImage(named: "etc")
            
            
            
        }
        
        
    }
    
    @IBAction func cashPay(sender: AnyObject) {
        self.detailSet.resignFirstResponder()
        payCashOrCard = 1
        let new = self.addingitem()
        self.addNewItem(new)
        self.budgetView()
        
    }
    
    @IBAction func cardPay(sender: AnyObject) {
        self.detailSet.resignFirstResponder()
        payCashOrCard = 0
        let new = self.addingitem()
        self.addNewItem(new)
        self.budgetView()
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
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
    
    func addNewItem(newItem:Item) {
        
        if dataCenter.travels[travelIndex!].items == nil{
            dataCenter.travels[travelIndex!].items = [newItem]
        }
        else {
            dataCenter.travels[travelIndex!].items!.append(newItem)
        }
        
        dataCenter.save()
        
    }
    
    
    
    
    func addingitem() -> Item {
        
        var currencyNumber:Int = 0
        // 세그먼트 인덱스 설정 바꿔야함
        if currencySegment.selectedSegmentIndex == 0 {
            
            currencyNumber = currencySegment.selectedSegmentIndex + dataCenter.travels[travelIndex!].initCashBudget[0].BudgetCurrency.rawValue
        }
        
        let newItem = Item(0, Currency(rawValue:currencyNumber)!, payCashOrCard, categorySelect, 1)
        //지불수단, 카테고리 ,인원 고정되있음
        
        if let price = priceSet.text{
            newItem.price = (price as NSString).doubleValue
            newItem.detail = detailSet.text!
            
        }
       
        return newItem
    }

    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if segue.identifier == "itemSegue" {
          
            let destVC = segue.destinationViewController as! ItemListTableViewController
            
            
            destVC.travelTitle = travelName
            destVC.travelindex = travelIndex
            
            
        }
        
        
        if segue.identifier == "itemAdd"{
            
            
            let destVC = segue.destinationViewController as! ItemListTableViewController
            
            destVC.travelindex = travelIndex
            
            
            destVC.travelTitle = travelName
            
            
            
        }
        
        if segue.identifier == "budgetEditSegue"{
            
            let destVC = segue.destinationViewController as! BudgetEditViewController
            
            destVC.travelIndex = travelIndex
            destVC.titlename = travelName
            
        
        
        }
        
              
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
    }

}
