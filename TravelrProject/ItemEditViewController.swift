//
//  ItemEditViewController.swift
//  TravelrProject
//
//  Created by Kim Seong Yup on 2016. 8. 23..
//  Copyright © 2016년 LEE. All rights reserved.
//

import UIKit
import MobileCoreServices

class ItemEditViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var datePicker:UIDatePicker!
    
    var imagePicker: UIImagePickerController! = UIImagePickerController()
    var captureImage:UIImage!
    var flagImageSave = false
    
    @IBOutlet weak var itemImage: UIImageView!
    
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
    
    @IBOutlet weak var currencyLabel: UILabel!
    
    var itemTitle:String?
    var travelIndex:Int?
    var itemIndex:Int?
    var categorySelect:Int?
    
    @IBOutlet weak var naviTitle: UINavigationItem!
    
    // MARK : TextField Delegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.itemView()
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
        
    }
    
    @IBAction func currencySetting(sender: AnyObject) {
        
        for i in 0...1{
            
            if currency.selectedSegmentIndex == i {
                
                currencyLabel.text = currency.titleForSegmentAtIndex(i)
                
            }
        }
        
    }

    
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
            
            itemImage.image = captureImage
            
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
    
    func getPay(input:String) -> Int {
        
        if input == "card" {
            return 0
        }
        
        else {
            return 1
        }
    }
    
    
    @IBAction func openCameraButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
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
            
            itemImage.image = item.photo
            date.text = item.ItemDate()
            numOfPeople.text = String(item.numberOfPerson)
            currency.setTitle(dataCenter.travels[travelIndex!].initCardBudget.BudgetCurrency.symbol,forSegmentAtIndex: 1)
            currency.setTitle(dataCenter.travels[travelIndex!].initCashBudget[0].BudgetCurrency.symbol,forSegmentAtIndex: 0)
            
            currencyLabel.text = currency.titleForSegmentAtIndex(currency.selectedSegmentIndex)
            
            shoppingImage.image = UIImage(named: "shopping")
            transportImage.image = UIImage(named: "transport")
            eatingImage.image = UIImage(named: "dining")
            sleepingImage.image = UIImage(named:"hotel")
            shoppingImage.image = UIImage(named: "shopping")
            etcImage.image = UIImage(named: "etc")
            
            for i in 0...4{
                if item.category == setCategory(i){
                    categorySelect = i
                }
            }
            
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
            let editItem = Item((price as NSString).doubleValue , Currency(rawValue:currencyNumber)!, pay.selectedSegmentIndex, categorySelect!, (numOfPeople.text! as NSString).integerValue)
                // 카테고리
            if let detail = detail.text{
                
                editItem.detail = detail
                
            }
            
            editItem.photo = itemImage.image
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd"
            editItem.date = dateFormatter.dateFromString(date.text!)!
            
            dataCenter.travels[travelIndex!].items![itemIndex!] = editItem

        }
        
        dataCenter.save()
    }
    // datepicker
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        self.pickUpDate(self.date)
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
    func pickUpDate(textField : UITextField){
        
        // DatePicker
        self.datePicker = UIDatePicker(frame:CGRectMake(0, 0, self.view.frame.size.width, 216))
        self.datePicker.backgroundColor = UIColor.whiteColor()
        self.datePicker.datePickerMode = UIDatePickerMode.Date
        textField.inputView = self.datePicker
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 215/255, green: 30/255, blue: 46/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: #selector(ItemEditViewController.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(ItemEditViewController.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    
    // MARK:- Button Done and Cancel
    func doneClick() {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        date.text = formatter.stringFromDate(datePicker.date) //string
        date.resignFirstResponder()
    }
    func cancelClick() {
        date.resignFirstResponder()
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
