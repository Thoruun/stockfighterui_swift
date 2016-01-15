//
//  ViewController.swift
//  StockfighterUI
//
//  Created by Oleksii BIlous on 12/17/15.
//  Copyright © 2015 Oleksii BIlous. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var healthStateIndicatorView: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.healthStateIndicatorView.wantsLayer = true
//        addObserver(self, selector: "turnOnMemoryTimer", name: "turnOnMemoryArc", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshStateIndicatorView", name: stockfighterServerStatusChangedNotification, object: nil)

        self.refreshStateIndicatorView()

    }
    
    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func refreshStateIndicatorView()
    {
        var stateColor : NSColor
        if SFUINetworkManager.sharedInstance.stockFighterServerStatusGood == false
        {
            stateColor = NSColor.redColor()
        }
        else
        {
            stateColor = NSColor.greenColor()
        }
        
        dispatch_async(dispatch_get_main_queue()) { [unowned self] in
            self.healthStateIndicatorView.image = NSImage.swatchWithColor(stateColor, size: self.healthStateIndicatorView.frame.size)
        }
    }
}

