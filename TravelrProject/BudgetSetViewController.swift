//
//  BudgetSetViewController.swift
//  TravelrProject
//
//  Created by 이우재 on 2016. 8. 17..
//  Copyright © 2016년 LEE. All rights reserved.
//

import UIKit
import MobileCoreServices

class BudgetSetViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextFieldDelegate {
    
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
    
    
    var titlename:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateText1.delegate = self
        dateText2.delegate = self
        
        navTitle.title = titlename
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    
    
    
    
    // datepicker
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.pickUpDate1(self.dateText1)
        self.pickUpDate2(self.dateText2)
        return true
    }
    
    func closeKeyBoard() {
        self.view.endEditing(true)
    }
    
    // MARK : Touch event
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        closeKeyBoard()
    }
    
    
    @IBAction func cancel(_ sender: AnyObject) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    
    
    //MARK:- Function of datePicker
    func pickUpDate1(_ textField : UITextField){
        
        // DatePicker
        self.datePicker1 = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker1.backgroundColor = UIColor.white
        self.datePicker1.datePickerMode = UIDatePickerMode.date
        textField.inputView = self.datePicker1
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 215/255, green: 30/255, blue: 46/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(BudgetSetViewController.doneClick1))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(BudgetSetViewController.cancelClick1))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    
    //MARK:- Function of datePicker
    func pickUpDate2(_ textField : UITextField){
        
        // DatePicker
        self.datePicker2 = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker2.backgroundColor = UIColor.white
        self.datePicker2.datePickerMode = UIDatePickerMode.date
        textField.inputView = self.datePicker2
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 215/255, green: 30/255, blue: 46/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(BudgetSetViewController.doneClick2))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(BudgetSetViewController.cancelClick2))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }

    
    // MARK:- Button Done and Cancel
    func doneClick1() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        dateText1.text = formatter.string(from: datePicker1.date) //string
        dateText1.resignFirstResponder()
    }
    func cancelClick1() {
        dateText1.resignFirstResponder()
    }
    
    func doneClick2() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        dateText2.text = formatter.string(from: datePicker2.date) //string
        dateText2.resignFirstResponder()
    }
    func cancelClick2() {
        dateText2.resignFirstResponder()
    }

    
    @IBOutlet weak var imgView: UIImageView!
    
    
    @IBAction func loadingImgView(_ sender: AnyObject) {

    if(UIImagePickerController.isSourceTypeAvailable(.photoLibrary)){
            flagImageSave = false
        
        
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = true
        
            present(imagePicker, animated: true, completion: nil)
        }
        
    else {
        
        imageAlert("Photo album inaccessable", message: "Application cannot access the photo album")
        
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        
        if mediaType.isEqual(to: kUTTypeImage as NSString as String){
            
            captureImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            if flagImageSave{
                UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
            }
            
            imgView.image = captureImage
            
        }
        
        self.dismiss(animated: true, completion: nil)
        
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // 이미지 경고창띄우는것
    func imageAlert(_ title: String, message:String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle:UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var currencySet: UILabel!
    
    @IBOutlet weak var currencySegment: UISegmentedControl!
    
    @IBAction func currencySetting(_ sender: AnyObject) {
        
        for i in 0...4{
            
            if currencySegment.selectedSegmentIndex == i {
                
                currencySet.text = currencySegment.titleForSegment(at: i)
                
            }
        }
        
    }
    
    
    func addingTravel() -> TravelWhere {
        
        let newTravel = TravelWhere(titlename!, "날짜", Budget(0,0,Currency(rawValue: 0)!), [Budget(1,0,Currency(rawValue: 1)!)])
        
        if let cardBudget = cardBudgetSet.text {
            
            var cardbudget:Budget
            let cardMoney = (cardBudget as NSString).doubleValue
            cardbudget = Budget(0, cardMoney, Currency(rawValue: 0)!)
            newTravel.initCardBudget = cardbudget
        }
        
        if let cashBudget1 = cashBudgetSet1.text{
            
            var cashbudget:[Budget] = []
            let cashMoney1 = (cashBudget1 as NSString).doubleValue
            cashbudget.append(Budget(1, cashMoney1, Currency(rawValue: currencySegment.selectedSegmentIndex + 1)!))
            newTravel.initCashBudget = cashbudget
        }
        
        if let cashBudget2 = cashBudgetSet2.text{
            
            var cashbudget:Budget
            let cashMoney2 = (cashBudget2 as NSString).doubleValue
            cashbudget = Budget(1, cashMoney2, Currency(rawValue: 0)!)
            newTravel.initCashBudget.append(cashbudget)
            
        }
        
        newTravel.background = imgView.image
        newTravel.periodStart = dateText1.text!
        newTravel.periodEnd = dateText2.text!
        newTravel.period = newTravel.periodStart! + " - " + newTravel.periodEnd!
        
        return newTravel
    }
 
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "doneUnwind" {
            
            
            let destVC = segue.destination as! TravelListTableViewController
            
            let newTravel  = self.addingTravel()
            
            destVC.cashCurrencyIndex = currencySegment.selectedSegmentIndex
            destVC.addNew(newTravel)
        }
        
        
        
//        let newtravel = self.addingTravel()
//        let destVC = segue.destinationViewController as! TravelListTableViewController
//
//        destVC.addNew(newtravel)
          
        
        
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 
    

}
