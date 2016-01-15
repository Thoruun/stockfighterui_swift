//
//  NSImage+Extensions.swift
//  StockfighterUI
//
//  Created by Oleksii Bilous on 1/15/16.
//  Copyright © 2016 Oleksii BIlous. All rights reserved.
//

import Foundation
import Cocoa

extension NSImage {
    class func swatchWithColor(color: NSColor, size: NSSize) -> NSImage {
        let image = NSImage(size: size)
        image.lockFocus()
        color.drawSwatchInRect(NSMakeRect(0, 0, size.width, size.height))
        image.unlockFocus()
        return image
    }
}