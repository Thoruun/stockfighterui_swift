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
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.refreshStateIndicatorView), name: NSNotification.Name(rawValue: stockfighterServerStatusChangedNotification), object: nil)

        self.refreshStateIndicatorView()

    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func refreshStateIndicatorView()
    {
        var stateColor : NSColor
        if SFUINetworkManager.sharedInstance.stockFighterServerStatusGood == false
        {
            stateColor = NSColor.red
        }
        else
        {
            stateColor = NSColor.green
        }
        
        DispatchQueue.main.async { [unowned self] in
            self.healthStateIndicatorView.image = NSImage.swatchWithColor(stateColor, size: self.healthStateIndicatorView.frame.size)
        }
    }
}

