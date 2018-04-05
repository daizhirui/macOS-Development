/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 Custom background view for NSScrubber.
 */

import Cocoa

class CustomBackgroundView: NSView {
    override var wantsUpdateLayer: Bool {
        return true
    }
    
    override var isOpaque: Bool {
        return true
    }
    
    override func updateLayer () {
        layer?.backgroundColor = NSColor.systemPurple.cgColor
    }
}
