//
//  BudgetSetViewController.swift
//  TravelrProject
//
//  Created by 이우재 on 2016. 8. 17..
//  Copyright © 2016년 LEE. All rights reserved.
//

import UIKit

class BudgetSetViewController: UIViewController {

    @IBOutlet weak var titleName: UILabel!
    
    @IBOutlet weak var cardBudgetSet: UITextField!
    
    @IBOutlet weak var cashBudgetSet: UITextField!
    
    @IBOutlet weak var navTitle: UINavigationItem!
    
    @IBOutlet weak var currencySelect: UISegmentedControl!
    
    @IBOutlet weak var budget1: UILabel!
    
    @IBOutlet weak var budget2: UILabel!
    
    @IBOutlet weak var budget3: UILabel!
    
    @IBOutlet weak var budget4: UILabel!
    
    @IBOutlet weak var cashCurrencyChoice: UILabel!
    
    
    var titlename:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navTitle.title = titlename
        titleName.text = titlename
        
        
        // 숫자만 받게하는 것
        func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
            
            let aSet = NSCharacterSet(charactersInString:"0123456789").invertedSet
            let compSepByCharInSet = string.componentsSeparatedByCharactersInSet(aSet)
            let numberFiltered = compSepByCharInSet.joinWithSeparator("")
            return string == numberFiltered
            
        }
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool)
    {
        self.navigationController?.navigationBarHidden = false
    }
    
    @IBAction func currencyChoice(sender: AnyObject) {
        
        for i in 0...3{
            
            if currencySelect.selectedSegmentIndex == i {
                
                cashCurrencyChoice.text = currencySelect.titleForSegmentAtIndex(i)
                
            }
        }
        
    }

    @IBAction func budgetAdd(sender: AnyObject) {
        
        
        var budgetlist = [budget1,budget2,budget3,budget4]
        
            for i in 0...3{
                
                if currencySelect.selectedSegmentIndex == i {
                    
                    budgetlist[i].text = Currency(rawValue:i)!.symbol + cashBudgetSet.text!
                }
            }
        
        
        
        
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        let destVC1 = segue.destinationViewController as! MainViewController

        
        
        //textfield 숫자로 변화해야함;;
//        if let cardBudget = cardBudgetSet.text , cashBudget = cashBudgetSet.text{
//            let cardMoney = (cardBudget as NSString).doubleValue
//        
//        
//            let cashMoney = (cashBudget as NSString).doubleValue
//        }
        let cardMoney = (cardBudgetSet.text! as NSString).doubleValue
        let cashMoney = (cashBudgetSet.text! as NSString).doubleValue
        
        destVC1.cardBudget = Budget(0, cardMoney, Currency(rawValue: 0)!)
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
