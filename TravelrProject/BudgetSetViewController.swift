//
//  BudgetSetViewController.swift
//  TravelrProject
//
//  Created by 이우재 on 2016. 8. 17..
//  Copyright © 2016년 LEE. All rights reserved.
//

import UIKit
import MobileCoreServices

class BudgetSetViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var imagePicker: UIImagePickerController! = UIImagePickerController()
    var captureImage:UIImage!
    var flagImageSave = false

    @IBOutlet weak var cardBudgetSet: UITextField!
    
    @IBOutlet weak var navTitle: UINavigationItem!
    
    @IBOutlet weak var budget1: UILabel!
    
    @IBOutlet weak var budget2: UILabel!
    
    @IBOutlet weak var budget3: UILabel!
    
    @IBOutlet weak var budget4: UILabel!
    
    
    var titlename:String?
    
    var budget:String?
    var selectCurrency:Int?
    var buget:String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navTitle.title = titlename
        
        if let index = selectCurrency{
            
            if index == 0{
                budget1.text = budget
            }
            
            else if index == 1{
                budget2.text = budget
            }
            
            else if index == 2{
                budget3.text = budget
            }
            
            else if index == 3{
                budget4.text = budget
            }


            
        }
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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
   
    // 현금예산팝업보여주기
    @IBAction func shoPopup(sender: AnyObject) {
        
        let popOverVC  = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("sbPopUpID") as! BudgetPopupViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMoveToParentViewController(self)
        
        self.navigationController?.navigationBarHidden = true // 네비 사라지게함
    }
    
    
    
    @IBAction func popup(sender: AnyObject) {
        let alert = UIAlertController(title: "₩", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        
        let cancel = UIAlertAction(title: "취소", style: UIAlertActionStyle.Cancel, handler: nil)
        
        alert.addAction(cancel)
        
        let ok = UIAlertAction(title: "추가", style: UIAlertActionStyle.Default) { (action: UIAlertAction) -> Void in
//            print("추가")
            let textField = alert.textFields?[0]
            
//            print(textField?.text)
            
            self.budget1.text = textField?.text
            
            
        }
        
        alert.addAction(ok)
        
        alert.addTextFieldWithConfigurationHandler{ (textField: UITextField) -> Void in
            textField.placeholder = "금액"
            textField.keyboardType = UIKeyboardType.NumberPad
        }
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func popup2(sender: AnyObject) {
        
        let alert = UIAlertController(title: "$", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        
        let cancel = UIAlertAction(title: "취소", style: UIAlertActionStyle.Cancel, handler: nil)
        
        alert.addAction(cancel)
        
        let ok = UIAlertAction(title: "추가", style: UIAlertActionStyle.Default) { (action: UIAlertAction) -> Void in
            //            print("추가")
            let textField = alert.textFields?[0]
            
            //            print(textField?.text)
            
            self.budget2.text = textField?.text
            
            
        }
        
        alert.addAction(ok)
        
        alert.addTextFieldWithConfigurationHandler{ (textField: UITextField) -> Void in
            textField.placeholder = "금액"
            textField.keyboardType = UIKeyboardType.NumberPad
        }
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func popup3(sender: AnyObject) {
        
        let alert = UIAlertController(title: "¥", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        
        let cancel = UIAlertAction(title: "취소", style: UIAlertActionStyle.Cancel, handler: nil)
        
        alert.addAction(cancel)
        
        let ok = UIAlertAction(title: "추가", style: UIAlertActionStyle.Default) { (action: UIAlertAction) -> Void in
            //            print("추가")
            let textField = alert.textFields?[0]
            
            //            print(textField?.text)
            
            self.budget3.text = textField?.text
            
            
        }
        
        alert.addAction(ok)
        
        alert.addTextFieldWithConfigurationHandler{ (textField: UITextField) -> Void in
            textField.placeholder = "금액"
            textField.keyboardType = UIKeyboardType.NumberPad
        }
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func popup4(sender: AnyObject) {
        
        let alert = UIAlertController(title: "€", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        
        let cancel = UIAlertAction(title: "취소", style: UIAlertActionStyle.Cancel, handler: nil)
        
        alert.addAction(cancel)
        
        let ok = UIAlertAction(title: "추가", style: UIAlertActionStyle.Default) { (action: UIAlertAction) -> Void in
            //            print("추가")
            let textField = alert.textFields?[0]
            
            //            print(textField?.text)
            
            self.budget4.text = textField?.text
            
            
        }
        
        alert.addAction(ok)
        
        alert.addTextFieldWithConfigurationHandler{ (textField: UITextField) -> Void in
            textField.placeholder = "금액"
            textField.keyboardType = UIKeyboardType.NumberPad
        }
        
        self.presentViewController(alert, animated: true, completion: nil)
        
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
    
    func addItem() {
        
        let newItem = Item()
        
        dataCenter.travels.append(<#T##newElement: Element##Element#>)
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
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        let destVC1 = segue.destinationViewController as! MainViewController

        let cardMoney = cardBudgetSet.text!
        
        destVC1.money = cardMoney
        
        
        //textfield 숫자로 변화해야함;;
//        if let cardBudget = cardBudgetSet.text , cashBudget = cashBudgetSet.text{
//            let cardMoney = (cardBudget as NSString).doubleValue
//        
//        
//            let cashMoney = (cashBudget as NSString).doubleValue
//        }
        
        
//        if budgetList
//        let cashMoney = ( as NSString).doubleValue
//        
//        destVC1.cardBudget = Budget(0, cardMoney, Currency(rawValue: 0)!)
//        destVC1.cashBudget =
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 
    

}
