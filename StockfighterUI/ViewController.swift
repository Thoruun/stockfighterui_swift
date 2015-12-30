//
//  ViewController.swift
//  StockfighterUI
//
//  Created by Oleksii BIlous on 12/17/15.
//  Copyright © 2015 Oleksii BIlous. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var healthStateIndicatorView: NSView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.healthStateIndicatorView.wantsLayer = true
        if SFUINetworkManager.sharedInstance.stockFighterServerStatusGood == false
        {
//            healthStateIndicatorView.b
            
            self.healthStateIndicatorView.layer?.backgroundColor = NSColor.redColor().CGColor;
        } else {
            self.healthStateIndicatorView.layer?.backgroundColor = NSColor.greenColor().CGColor;
        }
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

