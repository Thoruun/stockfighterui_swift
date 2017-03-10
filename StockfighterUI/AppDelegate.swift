//
//  AppDelegate.swift
//  StockfighterUI
//
//  Created by Oleksii BIlous on 12/17/15.
//  Copyright © 2015 Oleksii BIlous. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        SFUINetworkManager.sharedInstance.checkStockfighterAPIHealth();
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

