//
//  SFUINetworkManager.swift
//  StockfighterUI
//
//  Created by Oleksii BIlous on 12/17/15.
//  Copyright © 2015 Oleksii BIlous. All rights reserved.
//  REBASE TEST

import Foundation

class SFUINetworkManager : NSObject {
    
    static let sharedInstance = SFUINetworkManager();
    
    var stockFighterServerStatusGood = false
    var starFighterServerHealthCheckTimer : Timer?
    let SERVER_HEALTH_CHECK_INTERVAL_SECONDS = 10.0
    
    override init()
    {
        super.init()
        stockFighterServerStatusGood = false
        starFighterServerHealthCheckTimer = Timer.scheduledTimer(timeInterval: SERVER_HEALTH_CHECK_INTERVAL_SECONDS, target: self, selector: #selector(SFUINetworkManager.timerAction), userInfo: nil, repeats: true)
    }
    
    func timerAction()
    {
        self.checkStockfighterAPIHealth()
    }

    func checkStockfighterAPIHealth()
    {

        let url = URL(string: "https://api.stockfighter.io/ob/api/heartbeat")
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!, completionHandler: {data, response, error -> Void in
            //do something
            
            print("Server health task completed at - \(Date())")
            if(error != nil) {
                // If there is an error in the web request, print it to the console
                print(error!.localizedDescription)
            }
//            print(data);
    //        var err : NSError;
            
            
            do {
                let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:AnyObject]
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
        NotificationCenter.default.post(name: Notification.Name(rawValue: stockfighterServerStatusChangedNotification), object: nil)
    }
    
    func getOrderBookForAStock()
    {
        let url = URL(string: "https://api.stockfighter.io/ob/api/venues/RWTBEX/stocks/EFI")
        //https://api.stockfighter.io/ob/api/venues/TESTEX/stocks/FOOBAR
        //let url = NSURL(string: "http://www.google.com")
        let session = URLSession.shared
        let sessionConfig : URLSessionConfiguration = session.configuration;
        
        let xHTTPAdditionalHeaders: [AnyHashable: Any] = ["X-Starfighter-Authorization":"af91a0f130024921ce4a62a2e1baa98a8f7c29ed"];
        sessionConfig.httpAdditionalHeaders = xHTTPAdditionalHeaders;
        let dataTask = session.dataTask(with: url!, completionHandler: {data, response, error -> Void in
            //do something
            
            print("Task completed")
            if(error != nil) {
                // If there is an error in the web request, print it to the console
                print(error!.localizedDescription)
            }
//            print(data);
            
            do {
                let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:AnyObject]
                
                print("jsonResult:\(jsonResult)");
            } catch let error as NSError {
                print("json error: \(error.localizedDescription)")
            }
        })
    
        dataTask.resume();
    }
}
