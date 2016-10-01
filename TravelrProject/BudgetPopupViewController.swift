//
//  BudgetPopupViewController.swift
//  TravelrProject
//
//  Created by 이우재 on 2016. 8. 17..
//  Copyright © 2016년 LEE. All rights reserved.
//

import UIKit



class BudgetPopupViewController: UIViewController {

    func showAnimate(){
        
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate(){
        
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
            }, completion: {(finished :Bool) in
                if (finished)
                {
                    self.view.removeFromSuperview()
                }
        });
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        self.showAnimate()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closePopup(_ sender: AnyObject) {
        
        //self.view.removeFromSuperview()
        
        self.navigationController?.isNavigationBarHidden = false
        
        self.removeAnimate()
    }
    
    @IBOutlet weak var currencySelect: UISegmentedControl!
    
    @IBOutlet weak var cashCurrencyChoice: UILabel!
    
    @IBOutlet weak var cashMoney: UITextField!
    
    //세그먼트 누르는 동시에 바뀜
    @IBAction func currencySelect(_ sender: AnyObject) {
        
        for i in 0...3{
            
            if currencySelect.selectedSegmentIndex == i {
                
                cashCurrencyChoice.text = currencySelect.titleForSegment(at: i)
                
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let ChooseCurrency = currencySelect.selectedSegmentIndex
        let ChooseBudget = currencySelect.titleForSegmentAtIndex(currencySelect.selectedSegmentIndex)! + " " + cashMoney.text!
        
        let destVC = segue.destinationViewController as! BudgetSetViewController
        
        self.navigationController?.navigationBarHidden = false
        
        
//        self.navigationController?.navigationBarHidden = false
//        
        
     
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
 */
}
