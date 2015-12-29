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



    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        SFNetworkManager.sharedInstance.checkStockfighterAPIHealth();
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

