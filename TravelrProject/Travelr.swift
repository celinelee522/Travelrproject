//
//  Travelr.swift
//  TravelrProject
//
//  Created by 이우재 on 2016. 8. 17..
//  Copyright © 2016년 LEE. All rights reserved.
//

import Foundation
import UIKit

let dataCenter:TravelData = TravelData()
let fileName = "BranchData.csv"

class TravelData {
    var travels:[TravelWhere] = []
    
    var filePath:String { get{
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        return documentDirectory + fileName
        }}
    
    init() {
        if NSFileManager.defaultManager().fileExistsAtPath(self.filePath) {
            //read
            if let unarchArray = NSKeyedUnarchiver.unarchiveObjectWithFile(self.filePath) as? [TravelWhere] {
                travels += unarchArray
            }
        } else {
            //create
//            travels += defaultData()
        }
        
        
    }
    
//    func defaultData() -> Array<TravelWhere> {
//        
//        let Item1 = Item(100000, Currency(rawValue:0)!, 0, 4, 1) // 면세점에서 원화로 삼
//        let Item2 = Item(10000, Currency(rawValue:2)!, 1, 2, 3) // 방값계산
//        let Item3 = Item(1000, Currency(rawValue:2)!, 0, 3, 1) // 일본 기차탐
//        
//        let cardbudget1 = Budget(0,300000,Currency(rawValue:0)!)
//        let cashbudget1 = Budget(1,100000,Currency(rawValue:2)!)
//        let cashbudget2 = Budget(1,300000,Currency(rawValue:0)!)
//        
//        let Travel:TravelWhere = TravelWhere("Japan", "2016.08.20-08.25" ,cardbudget1,[cashbudget1,cashbudget2])
//        
//        Travel.items = [Item1,Item2,Item3]
//        
//        let travelArray = [Travel]
//        return travelArray
//    }
    
    func save(){
        NSKeyedArchiver.archiveRootObject(self.travels, toFile: self.filePath)
    }
}

// 환율계산 및 화폐단위심볼


enum Currency:Int{
    case KRW = 0, USD, JPY, EUR, GBP, CNY
    
    var ratio:Double { // 원화로의 환율
        get{
            switch self {
            case .KRW : return 1.0
            case .USD : return 1104.50
            case .JPY : return 10.92
            case .EUR : return 1236.76
            case .GBP : return 1435.74
            case .CNY : return 166.31
            }
        }
    }
    
    var symbol:String {
        get{
            switch self {
            case .KRW : return "₩"
            case .USD : return "$"
            case .JPY : return "¥"
            case .EUR : return "€"
            case .GBP : return "£"
            case .CNY : return "元"
            }
        }
    }
    
    
    
    func refreshCurrency() {
        let lotteURL = NSURL(string: "http://api.fixer.io/latest?symbols=USD,KRW")
        
        do {
            let jsonData =  try NSData(contentsOfURL:lotteURL!)
            //print(jsonString)
            let jsonDictionary:NSDictionary = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: .MutableContainers) as! Dictionary<String, AnyObject>
            print(jsonDictionary)
//            print(jsonDictionary["teamName"])
//            guard let teamName = jsonDictionary["teamName"] as? String else {
//                return
//            }
//            
//            let jsonHitters = jsonDictionary["hitters"] as! Array<Dictionary<String,String>>
//            var hitterObjArray:[Hitter] = []
//            for hitter in jsonHitters {
//                let newHitter = Hitter(name:hitter["name"]!)
//                newHitter.average = Double(hitter["average"]!)!
//                hitterObjArray += [newHitter]
//            }
//            
//            hitters[teamName] = hitterObjArray
        } catch {
            
        }

    }
    
    
    
}



//category설정
func setCategory(n:Int) -> (String) {
    let categories:Array<String> = ["eating" ,"sleeping", "transport", "shopping", "etc"] // <- 나중에 아이콘으로 표시할시에 img파일로 받는 것으로 바꿔줘야함
    let category = categories[n]
    return category
}




//card,cash 설정
func setPay(n:Int) -> (String) {
    let pays:Array<String> = ["card" , "cash"]
    let pay = pays[n]
    return pay
}



class Budget:NSObject, NSCoding {
    
    var CardOrCash:String
    var Money:Double
    var BudgetCurrency:Currency // 원, 달러, 엔, 유로, 파운드, 위안
    
    // 카드 예산의 경우 화폐단위를 원화로 하기
    init(_ _cardorcash:Int,_ _money:Double,_ _currency:Currency){
        
        self.CardOrCash = setPay(_cardorcash)
        self.Money = _money
        self.BudgetCurrency = _currency
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.CardOrCash = aDecoder.decodeObjectForKey("CardOrCash") as! String
        self.Money = aDecoder.decodeObjectForKey("Money") as! Double
        self.BudgetCurrency = Currency(rawValue: aDecoder.decodeIntegerForKey("BudgetCurrency"))!
       
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(self.CardOrCash, forKey: "CardOrCash")
        aCoder.encodeObject(self.Money, forKey: "Money")
        aCoder.encodeInteger(self.BudgetCurrency.rawValue, forKey: "BudgetCurrency")
        
    }
    
    //각 예산을 원화로 바꿈
    func CurrencyToWon() -> Double {
        return  Money * BudgetCurrency.ratio
    }
    
    
}


class TravelWhere:NSObject, NSCoding {
    
    var title : String
    var period : String //UIDatePicker // 기간 어떤타입?? 데이트피커에서 받아와야함
    var periodStart:String?
    var periodEnd:String?
    var background : UIImage?
    var plan : String?
    var items : [Item]?
    var initCardBudget:Budget
    var initCashBudget:[Budget] // 현금의 경우 여러가지 단위 받게 함 (배열로)
    
    init(_ title:String, _ period:String ,_ initCardBudget:Budget,_ initCashBudget:[Budget]){
        
        self.title  = title
        self.period = period
        self.initCardBudget = initCardBudget
        self.initCashBudget = initCashBudget
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        
        self.title = aDecoder.decodeObjectForKey("title") as! String
        self.period = aDecoder.decodeObjectForKey("period") as! String
        self.background = aDecoder.decodeObjectForKey("background") as? UIImage
        self.plan = aDecoder.decodeObjectForKey("plan") as? String
        self.items = aDecoder.decodeObjectForKey("items") as? [Item]
        
        self.initCardBudget = aDecoder.decodeObjectForKey("initCardBudget") as! Budget
        self.initCashBudget = aDecoder.decodeObjectForKey("initCashBudget") as! [Budget]
        self.periodStart = aDecoder.decodeObjectForKey("periodStart") as? String
        self.periodEnd = aDecoder.decodeObjectForKey("periodEnd") as? String
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(self.title, forKey: "title")
        aCoder.encodeObject(self.period, forKey: "period")
        aCoder.encodeObject(self.background, forKey: "background")
        aCoder.encodeObject(self.plan, forKey: "plan")
        aCoder.encodeObject(self.items, forKey: "items")
        aCoder.encodeObject(self.initCardBudget, forKey: "initCardBudget")
        aCoder.encodeObject(self.initCashBudget, forKey: "initCashBudget")
        aCoder.encodeObject(self.periodStart, forKey: "periodStart")
        aCoder.encodeObject(self.periodEnd, forKey: "periodEnd")
        
    }
    
    // 1. 지불수단별로 아이템들 분류한 배열을 리턴하는 함수
    
    func itemsByPay() -> (cardItems:[Item], cashItems:[Item]){
        
        var card:[Item] = []
        var cash:[Item] = []
        
        if let items = items{
            
            let carditems = items.filter({ $0.pay == "card" })
            card = carditems
            
            let cashitems = items.filter({ $0.pay == "cash" })
            cash = cashitems
            
        }
        
        return(card,cash)
    }
    
    
    // 2. 지불수단별로 아이템들 계산하여 카드쓴돈, 현금쓴돈, 카드남은돈, 현금남은돈 ( 인풋으로 기준 화폐단위 넣어주면 분류해서 아웃풋줌)
    
    func MoneyByPayCurrency(indexCurrency:Currency) -> (cardSpend:Double, cashSpend:Double, cardRemian:Double, cashRemain:Double){
        var cardspend:Double = 0
        var cashspend:Double = 0
        
        if let items = items{
            let carditems = items.filter({ $0.pay == "card" })
            let cardCurrencyitems = carditems.filter({ $0.currency.symbol == indexCurrency.symbol})
            
            for i in cardCurrencyitems{
                cardspend += i.price
            }
            
            let cashitems = items.filter({ $0.pay == "cash" })
            let cashCurrencyitems = cashitems.filter({ $0.currency.symbol == indexCurrency.symbol})
            
            for i in cashCurrencyitems{
                cashspend += i.price
            }
        }
        
        let cardremain = initCardBudget.Money - cardspend*indexCurrency.ratio
        
        let filterdCashBudget = initCashBudget.filter({$0.BudgetCurrency.symbol == indexCurrency.symbol}) // 현금 예산 중 기준 화폐단위와 일치하는거 골라냄
        let cashremain = filterdCashBudget[0].Money-cashspend // 기준화폐단위와 일치하는 예산은 하나 일 것이기 때문에 [0] 써도 무관
        
        return (cardspend,cashspend,cardremain,cashremain)
        
    }
    
}



class Item:NSObject, NSCoding {
    
    var price : Double
    var currency : Currency
    var pay : String
    var category : String // 나중에 radio button 이나 아이콘선택으로 대체
    var date = NSDate() // 현재시간 받기 <- 초기선택은 현재 년,월,일이고 데이트피커로 선택해 넣기
    var numberOfPerson : Int // 피커로 인원수 받기
    var photo : UIImage?
    var detail : String?
    
    init(_ _price:Double, _ _currency:Currency, _ _pay:Int, _ _category:Int, _ _numberofperson:Int ){
        
        price = _price
        currency = _currency
        pay = setPay(_pay)
        category = setCategory(_category)
        numberOfPerson = _numberofperson
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        self.price = aDecoder.decodeObjectForKey("price") as! Double
        self.currency = Currency(rawValue: aDecoder.decodeIntegerForKey("currency"))!
        self.pay = aDecoder.decodeObjectForKey("pay") as! String
        self.category = aDecoder.decodeObjectForKey("category") as! String
        self.numberOfPerson = aDecoder.decodeObjectForKey("numberOfPerson") as! Int
        self.photo = aDecoder.decodeObjectForKey("photo") as? UIImage
        self.detail = aDecoder.decodeObjectForKey("detail") as? String
        self.date = aDecoder.decodeObjectForKey("date") as! NSDate
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.price, forKey: "price")
        aCoder.encodeInteger(self.currency.rawValue, forKey: "currency")
        aCoder.encodeObject(self.pay, forKey: "pay")
        aCoder.encodeObject(self.category, forKey: "category")
        aCoder.encodeObject(self.numberOfPerson, forKey: "numberOfPerson")
        aCoder.encodeObject(self.photo, forKey: "photo")
        aCoder.encodeObject(self.detail, forKey: "detail")
        aCoder.encodeObject(self.date, forKey: "date")
        
    }
    
    // 지출 항목을 입력할때의 시간을 년,월,일로 써주는 함수
    
    func ItemDate() -> String{
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        let itemdate:String = formatter.stringFromDate(date)
        
        return itemdate
        
    }
    
    // 각 항목의 가격을 원화로 바꿈 ( 나중에 계산 필요시 쓰기 )
    func CurrencyToWon() -> Double {
        return  price * currency.ratio
    }
}


