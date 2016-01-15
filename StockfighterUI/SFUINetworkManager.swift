//
//  SFUINetworkManager.swift
//  StockfighterUI
//
//  Created by Oleksii BIlous on 12/17/15.
//  Copyright © 2015 Oleksii BIlous. All rights reserved.
//

import Foundation

class SFUINetworkManager {
    
    static let sharedInstance = SFUINetworkManager();
    
    var stockFighterServerStatusGood = false;
    
    init()
    {
        stockFighterServerStatusGood = false;
    }
    

    func checkStockfighterAPIHealth()
    {

        let url = NSURL(string: "https://api.stockfighter.io/ob/api/heartbeat")
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
            //do something
            
            print("Task completed")
            if(error != nil) {
                // If there is an error in the web request, print it to the console
                print(error!.localizedDescription)
            }
            print(data);
    //        var err : NSError;
            
            
            do {
                let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! [String:AnyObject]
                if(jsonResult["error"] == nil) {
                    if (self.stockFighterServerStatusGood == true)
                    {
                        self.stockFighterServerStatusGood = false;
                        self.postServerStatusChangeNotification()
                    }
                } else {
                    if (self.stockFighterServerStatusGood == false)
                    {
                        self.stockFighterServerStatusGood = true;
                        self.postServerStatusChangeNotification()
                    }
                }
                
                print("jsonResult:\(jsonResult)");
            } catch let error as NSError {
                print("json error: \(error.localizedDescription)")
            }

        })
        
        dataTask.resume();

    }
    
    func postServerStatusChangeNotification()
    {
        NSNotificationCenter.defaultCenter().postNotificationName(stockfighterServerStatusChangedNotification, object: nil)
    }
    
    func getOrderBookForAStock()
    {
        let url = NSURL(string: "https://api.stockfighter.io/ob/api/venues/RWTBEX/stocks/EFI")
        //https://api.stockfighter.io/ob/api/venues/TESTEX/stocks/FOOBAR
        //let url = NSURL(string: "http://www.google.com")
        let session = NSURLSession.sharedSession()
        let sessionConfig : NSURLSessionConfiguration = session.configuration;
        
        let xHTTPAdditionalHeaders: [NSObject : AnyObject] = ["X-Starfighter-Authorization":"af91a0f130024921ce4a62a2e1baa98a8f7c29ed"];
        sessionConfig.HTTPAdditionalHeaders = xHTTPAdditionalHeaders;
        let dataTask = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
            //do something
            
            print("Task completed")
            if(error != nil) {
                // If there is an error in the web request, print it to the console
                print(error!.localizedDescription)
            }
            print(data);
            
            do {
                let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! [String:AnyObject]
                
                print("jsonResult:\(jsonResult)");
            } catch let error as NSError {
                print("json error: \(error.localizedDescription)")
            }
        })
    
        dataTask.resume();
    }
}