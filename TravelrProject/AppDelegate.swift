//
//  AppDelegate.swift
//  TravelrProject
//
//  Created by 이우재 on 2016. 8. 17..
//  Copyright © 2016년 LEE. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let usdUrl = NSURL(string: "http://api.fixer.io/latest?base=USD")
        let jpyUrl = NSURL(string: "http://api.fixer.io/latest?base=JPY")
        let eurUrl = NSURL(string: "http://api.fixer.io/latest?base=EUR")
        let gbpUrl = NSURL(string: "http://api.fixer.io/latest?base=GBP")
        let cnyUrl = NSURL(string: "http://api.fixer.io/latest?base=CNY")
        
        
        do {
            let usdJsonData =  NSData(contentsOfURL: usdUrl!)
            let jpyJsonData =  NSData(contentsOfURL: jpyUrl!)
            let eurJsonData =  NSData(contentsOfURL: eurUrl!)
            let gbpJsonData =  NSData(contentsOfURL: gbpUrl!)
            let cnyJsonData =  NSData(contentsOfURL: cnyUrl!)
            
            //print(jsonString)
            let usdJsonDictionary:NSDictionary = try NSJSONSerialization.JSONObjectWithData(usdJsonData!, options: .MutableContainers) as! Dictionary<String, AnyObject>
            let jpyJsonDictionary:NSDictionary = try NSJSONSerialization.JSONObjectWithData(jpyJsonData!, options: .MutableContainers) as! Dictionary<String, AnyObject>
            let eurJsonDictionary:NSDictionary = try NSJSONSerialization.JSONObjectWithData(eurJsonData!, options: .MutableContainers) as! Dictionary<String, AnyObject>
            let gbpJsonDictionary:NSDictionary = try NSJSONSerialization.JSONObjectWithData(gbpJsonData!, options: .MutableContainers) as! Dictionary<String, AnyObject>
            let cnyJsonDictionary:NSDictionary = try NSJSONSerialization.JSONObjectWithData(cnyJsonData!, options: .MutableContainers) as! Dictionary<String, AnyObject>
            
            let usd = usdJsonDictionary["rates"]!["KRW"]!
            let jpy = jpyJsonDictionary["rates"]!["KRW"]!
            let eur = eurJsonDictionary["rates"]!["KRW"]!
            let gbp = gbpJsonDictionary["rates"]!["KRW"]!
            let cny = cnyJsonDictionary["rates"]!["KRW"]!

            
            
            print(usd!,jpy!,eur!,gbp!,cny!)
            
            currencyArray = [Double(usd! as! NSNumber),Double(jpy! as! NSNumber),Double(eur! as! NSNumber),Double(gbp! as! NSNumber),Double(cny! as! NSNumber)]
            
        } catch {
            
        }

    
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        dataCenter.save()
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        dataCenter.save()
        
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        dataCenter.save()
    }
    


}

