//
//  BudgetEditViewController.swift
//  TravelrProject
//
//  Created by 이우재 on 2016. 8. 23..
//  Copyright © 2016년 LEE. All rights reserved.
//

import UIKit
import MobileCoreServices

class BudgetEditViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextFieldDelegate {

    var imagePicker: UIImagePickerController! = UIImagePickerController()
    var captureImage:UIImage!
    var flagImageSave = false
    
    @IBOutlet weak var cardBudgetSet: UITextField!
    
    @IBOutlet weak var cashBudgetSet1: UITextField!
    
    @IBOutlet weak var cashBudgetSet2: UITextField!
    
    @IBOutlet weak var navTitle: UINavigationItem!
    
    
    @IBOutlet weak var dateText1: UITextField!
    
    @IBOutlet weak var dateText2: UITextField!
    
    var travelIndex:Int?
    
    var titlename:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let travelInitial = dataCenter.travels[travelIndex!]
        
        cardBudgetSet.text = String(travelInitial.initCardBudget.Money)
        cashBudgetSet1.text = String(travelInitial.initCashBudget[0].Money)
        cashBudgetSet2.text = String(travelInitial.initCashBudget[1].Money)
        currencySegment.selectedSegmentIndex = travelInitial.initCashBudget[0].BudgetCurrency.rawValue - 1
        currencySet.text = currencySegment.titleForSegmentAtIndex(currencySegment.selectedSegmentIndex)
        dateText1.text = travelInitial.periodStart
        dateText2.text = travelInitial.periodEnd
        imgView.image = travelInitial.background
        
        dateText1.delegate = self
        dateText2.delegate = self
        
        navTitle.title = titlename
        
        
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
    
    //date picker
    
    func textFieldDidEndEditing(textField: UITextField) {
        let datePicker1 = UIDatePicker()
        let datePicker2 = UIDatePicker()
        dateText1.inputView = datePicker1
        dateText2.inputView = datePicker2
        datePicker1.addTarget(self, action: #selector(BudgetSetViewController.datePickerChanged1(_:)), forControlEvents: .ValueChanged)
        datePicker2.addTarget(self, action: #selector(BudgetSetViewController.datePickerChanged2(_:)), forControlEvents: .ValueChanged)
    }
    
    
    func datePickerChanged1(sender: UIDatePicker) {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .ShortStyle
        dateText1.text = formatter.stringFromDate(sender.date)
    }
    
    func datePickerChanged2(sender: UIDatePicker) {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .ShortStyle
        dateText2.text = formatter.stringFromDate(sender.date)
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func closeKeyBoard() {
        self.view.endEditing(true)
    }
    
    
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    
    @IBOutlet weak var imgView: UIImageView!
    
    
    @IBAction func loadingImgView(sender: AnyObject) {
        
        if(UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary)){
            flagImageSave = false
            
            
            imagePicker.delegate = self
            imagePicker.sourceType = .PhotoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = true
            
            presentViewController(imagePicker, animated: true, completion: nil)
        }
            
        else {
            
            imageAlert("Photo album inaccessable", message: "Application cannot access the photo album")
            
        }
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        
        if mediaType.isEqualToString(kUTTypeImage as NSString as String){
            
            captureImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            if flagImageSave{
                UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
            }
            
            imgView.image = captureImage
            
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // 이미지 경고창띄우는것
    func imageAlert(title: String, message:String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle:UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(action)
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var currencySet: UILabel!
    
    @IBOutlet weak var currencySegment: UISegmentedControl!
    
    @IBAction func currencySetting(sender: AnyObject) {
        
        for i in 0...3{
            
            if currencySegment.selectedSegmentIndex == i {
                
                currencySet.text = currencySegment.titleForSegmentAtIndex(i)
                
            }
        }
        
    }
    
    
    func editingTravel() {
        
        
        if let cardBudget = cardBudgetSet.text {
            
            var cardbudget:Budget
            let cardMoney = (cardBudget as NSString).doubleValue
            cardbudget = Budget(0, cardMoney, Currency(rawValue: 0)!)
            dataCenter.travels[travelIndex!].initCardBudget = cardbudget
        }
        
        if let cashBudget1 = cashBudgetSet1.text{
            
            var cashbudget:[Budget] = []
            let cashMoney1 = (cashBudget1 as NSString).doubleValue
            cashbudget.append(Budget(1, cashMoney1, Currency(rawValue: currencySegment.selectedSegmentIndex + 1)!))
            dataCenter.travels[travelIndex!].initCashBudget = cashbudget
        }
        
        if let cashBudget2 = cashBudgetSet2.text{
            
            var cashbudget:Budget
            let cashMoney2 = (cashBudget2 as NSString).doubleValue
            cashbudget = Budget(1, cashMoney2, Currency(rawValue: 0)!)
            dataCenter.travels[travelIndex!].initCashBudget.append(cashbudget)
            
        }
        
        dataCenter.travels[travelIndex!].background = imgView.image
        dataCenter.travels[travelIndex!].periodStart = dateText1.text!
        dataCenter.travels[travelIndex!].periodEnd = dateText2.text!
        
        dataCenter.travels[travelIndex!].period = dateText1.text! + " - " + dateText2.text!
        
    }
    
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "budgetEditSegue" {
            
            
            self.editingTravel()
            
            dataCenter.save()

            
        }
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
    
}
