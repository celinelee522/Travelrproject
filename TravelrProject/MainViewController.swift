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
    @IBOutlet weak var cardUsedTotal: UILabel!
    
    
    var travelName:String?
    var travelIndex:Int?
    var travelCurrencyIndex:Int?
    var payCashOrCard:Int = 0
    var categorySelect:Int = 0
    
    
    @IBAction func toMainAfterEdit(_ unwind:UIStoryboardSegue){
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        travelTitle.title = travelName
        
        

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.budgetView()
        priceSet.text = ""
        detailSet.text = ""
    }
    
    
    
    
    
    
    
    
    @IBAction func toMainView(_ unwind:UIStoryboardSegue){
        self.budgetView()
    }
    
    
    func budgetView() {
        
        if let index = travelIndex{
            
            
            let indexCurrency = dataCenter.travels[index].initCashBudget[0].BudgetCurrency
            let indexCurrencyWon = Currency(rawValue: 0)!
            
            let cardUsedDouble = dataCenter.travels[index].MoneyByPayCurrency(indexCurrency).cardSpend
            let cardUsedWonDouble = dataCenter.travels[index].MoneyByPayCurrency(indexCurrencyWon).cardSpend
            let cardUsedWonTotal = cardUsedWonDouble + cardUsedDouble * indexCurrency.ratio
            
            let cashRemainWon = dataCenter.travels[index].MoneyByPayCurrency(indexCurrencyWon).cashRemain
            let cashRemainDouble = dataCenter.travels[index].MoneyByPayCurrency(indexCurrency).cashRemain
            let cardRemainWon = dataCenter.travels[index].MoneyByPayCurrency(indexCurrency).cardRemian - dataCenter.travels[index].MoneyByPayCurrency(indexCurrencyWon).cardSpend
            
            cashCurrency.text = indexCurrency.symbol
            cardCurrency.text = indexCurrency.symbol
            cashUsed1.text = String(dataCenter.travels[index].MoneyByPayCurrency(indexCurrency).cashSpend)
            cashUsedWon.text = String(dataCenter.travels[index].MoneyByPayCurrency(indexCurrencyWon).cashSpend)
            cashBudget1.text = String(cashRemainDouble)
            cashBudget2.text = String(cashRemainWon)
            cardUsed.text = String(cardUsedDouble)
            cardUsedWon.text = String(cardUsedWonDouble)
            cardUsedTotal.text = "(합계 : 약 \(String(cardUsedWonTotal)))"
            cardBudget.text = String(cardRemainWon)
            
            currencySegment.setTitle(dataCenter.travels[index].initCardBudget.BudgetCurrency.symbol,forSegmentAt: 1)
            currencySegment.setTitle(dataCenter.travels[index].initCashBudget[0].BudgetCurrency.symbol,forSegmentAt: 0)
            
            shoppingImage.image = UIImage(named: "shopping")
            transportImage.image = UIImage(named: "transport")
            eatingImage.image = UIImage(named: "dining")
            sleepingImage.image = UIImage(named:"hotel")
            shoppingImage.image = UIImage(named: "shopping")
            etcImage.image = UIImage(named: "etc")
            
            
            
        }
        
        
    }
    
    @IBAction func cashPay(_ sender: AnyObject) {
        self.detailSet.resignFirstResponder()
        payCashOrCard = 1
        let new = self.addingitem()
        self.addNewItem(new)
        self.budgetView()
        
        priceSet.text = ""
        detailSet.text = ""
        
    }
    
    @IBAction func cardPay(_ sender: AnyObject) {
        self.detailSet.resignFirstResponder()
        payCashOrCard = 0
        let new = self.addingitem()
        self.addNewItem(new)
        self.budgetView()
        
        priceSet.text = ""
        detailSet.text = ""
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    
    
    @IBAction func eatingCategory(_ sender: AnyObject) {
        
        categorySelect = 0
        eatingImage.image = UIImage(named: "dining_sel")
        shoppingImage.image = UIImage(named: "shopping")
        sleepingImage.image = UIImage(named:"hotel")
        transportImage.image = UIImage(named: "transport")
        etcImage.image = UIImage(named: "etc")

        
    }
    
    @IBAction func sleepingCategory(_ sender: AnyObject) {
        
        categorySelect = 1
        sleepingImage.image = UIImage(named:"hotel_sel")
        eatingImage.image = UIImage(named: "dining")
        shoppingImage.image = UIImage(named:"shopping")
        transportImage.image = UIImage(named: "transport")
        etcImage.image = UIImage(named: "etc")

    }
    
    @IBAction func transportCategory(_ sender: AnyObject) {
        
        categorySelect = 2
        transportImage.image = UIImage(named: "transport_sel")
        eatingImage.image = UIImage(named: "dining")
        sleepingImage.image = UIImage(named:"hotel")
        shoppingImage.image = UIImage(named: "shopping")
        etcImage.image = UIImage(named: "etc")

    }
    
    @IBAction func shoppingCategory(_ sender: AnyObject) {
        
        categorySelect = 3
        shoppingImage.image = UIImage(named: "shopping_sel")
        eatingImage.image = UIImage(named: "dining")
        sleepingImage.image = UIImage(named:"hotel")
        transportImage.image = UIImage(named: "transport")
        etcImage.image = UIImage(named: "etc")
        
    }
    
    @IBAction func etcCategory(_ sender: AnyObject) {
        
        categorySelect = 4
        etcImage.image = UIImage(named: "etc_sel")
        eatingImage.image = UIImage(named: "dining")
        sleepingImage.image = UIImage(named:"hotel")
        transportImage.image = UIImage(named: "transport")
        shoppingImage.image = UIImage(named: "shopping")

        
    }
    
    func addNewItem(_ newItem:Item) {
        
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
        
        for i in 0...4{
            if newItem.category == setCategory(i){
                switch i {
                case 0:
                    newItem.photo = UIImage(named: "itemDefault5")
                case 1:
                    newItem.photo = UIImage(named: "itemDefault1")
                case 2:
                    newItem.photo = UIImage(named: "itemDefault3")
                case 3:
                    newItem.photo = UIImage(named: "itemDefault2")
                default:
                    newItem.photo = UIImage(named: "itemDefault4")
                    
                }
                
                
            }
        }
        
        
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "itemSegue" {
          
            let destVC = segue.destination as! ItemListTableViewController
            
            
            destVC.travelTitle = travelName
            destVC.travelindex = travelIndex
            
            
        }
        
        
//        if segue.identifier == "itemAdd"{
//            
//            
//            let destVC = segue.destinationViewController as! ItemListTableViewController
//            
//            destVC.travelindex = travelIndex
//            
//            
//            destVC.travelTitle = travelName
//            
//            
//            
//        }
        
        if segue.identifier == "budgetEditSegue"{
            
            let destVC = segue.destination as! BudgetEditViewController
            
            destVC.travelIndex = travelIndex
            destVC.titlename = travelName
            
        
        
        }
        
              
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }

}
