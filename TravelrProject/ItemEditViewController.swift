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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func currencySetting(_ sender: AnyObject) {
        
        for i in 0...1{
            
            if currency.selectedSegmentIndex == i {
                
                currencyLabel.text = currency.titleForSegment(at: i)
                
            }
        }
        
    }

    
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
            
            itemImage.image = captureImage
            
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
    
    func getPay(_ input:String) -> Int {
        
        if input == "card" {
            return 0
        }
        
        else {
            return 1
        }
    }
    
    
    @IBAction func openCameraButton(_ sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
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
            currency.setTitle(dataCenter.travels[travelIndex!].initCardBudget.BudgetCurrency.symbol,forSegmentAt: 1)
            currency.setTitle(dataCenter.travels[travelIndex!].initCashBudget[0].BudgetCurrency.symbol,forSegmentAt: 0)
            
            currencyLabel.text = currency.titleForSegment(at: currency.selectedSegmentIndex)
            
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
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd"
            editItem.date = dateFormatter.date(from: date.text!)!
            
            dataCenter.travels[travelIndex!].items![itemIndex!] = editItem

        }
        
        dataCenter.save()
    }
    // datepicker
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.pickUpDate(self.date)
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
    func pickUpDate(_ textField : UITextField){
        
        // DatePicker
        self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker.backgroundColor = UIColor.white
        self.datePicker.datePickerMode = UIDatePickerMode.date
        textField.inputView = self.datePicker
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 215/255, green: 30/255, blue: 46/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(ItemEditViewController.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(ItemEditViewController.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    
    // MARK:- Button Done and Cancel
    func doneClick() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        date.text = formatter.string(from: datePicker.date) //string
        date.resignFirstResponder()
    }
    func cancelClick() {
        date.resignFirstResponder()
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "itemEditSegue" {
            
            let destVC = segue.destination as! ItemListTableViewController
            
            self.editingItem()
            
            destVC.itemEditing()
            
        }
        
        
    }
    

}
