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

    var datePicker1:UIDatePicker!
    var datePicker2:UIDatePicker!
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
    
    
    // datepicker
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        self.pickUpDate1(self.dateText1)
        self.pickUpDate2(self.dateText2)
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
    
    
    
    
    //MARK:- Function of datePicker
    func pickUpDate1(textField : UITextField){
        
        // DatePicker
        self.datePicker1 = UIDatePicker(frame:CGRectMake(0, 0, self.view.frame.size.width, 216))
        self.datePicker1.backgroundColor = UIColor.whiteColor()
        self.datePicker1.datePickerMode = UIDatePickerMode.Date
        textField.inputView = self.datePicker1
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 215/255, green: 30/255, blue: 46/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: "doneClick1")
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: "cancelClick1")
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    
    //MARK:- Function of datePicker
    func pickUpDate2(textField : UITextField){
        
        // DatePicker
        self.datePicker2 = UIDatePicker(frame:CGRectMake(0, 0, self.view.frame.size.width, 216))
        self.datePicker2.backgroundColor = UIColor.whiteColor()
        self.datePicker2.datePickerMode = UIDatePickerMode.Date
        textField.inputView = self.datePicker2
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 215/255, green: 30/255, blue: 46/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: "doneClick2")
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: "cancelClick2")
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }

    
    // MARK:- Button Done and Cancel
    func doneClick1() {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        dateText1.text = formatter.stringFromDate(datePicker1.date) //string
        dateText1.resignFirstResponder()
    }
    func cancelClick1() {
        dateText1.resignFirstResponder()
    }
    
    func doneClick2() {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        dateText2.text = formatter.stringFromDate(datePicker2.date) //string
        dateText2.resignFirstResponder()
    }
    func cancelClick2() {
        dateText2.resignFirstResponder()
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
