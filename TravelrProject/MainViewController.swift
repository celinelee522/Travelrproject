//
//  MainViewController.swift
//  TravelrProject
//
//  Created by 이우재 on 2016. 8. 17..
//  Copyright © 2016년 LEE. All rights reserved.
//

import UIKit



class MainViewController: UIViewController {
    
    
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            
            
            
        }
        
        travelTitle.title = travelName
        
        

        // Do any additional setup after loading the view.
    }
    
    
    func addingitem() -> Item {
        
        // 세그먼트 인덱스 설정 바꿔야함
        let currencyNumber = currencySegment.selectedSegmentIndex + dataCenter.travels[travelIndex!].initCashBudget[0].BudgetCurrency.rawValue
        let newItem = Item(0, Currency(rawValue:currencyNumber)!, 0, 0, 1)
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
            if let index = travelIndex{
                destVC.items = dataCenter.travels[index].items
                destVC.travelindex = travelIndex
            }//이제 아이템 뿌려줘야함
            
        }
        
        
        if segue.identifier == "itemAdd"{
            
            
            let destVC = segue.destinationViewController as! ItemListTableViewController
            
            destVC.travelindex = travelIndex
            let new = self.addingitem()
            destVC.addNewItem(new)
            destVC.travelTitle = travelName
            if let index = travelIndex{
                destVC.items = dataCenter.travels[index].items
            }
            
            
            
        }
        
        
        
        

        
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
