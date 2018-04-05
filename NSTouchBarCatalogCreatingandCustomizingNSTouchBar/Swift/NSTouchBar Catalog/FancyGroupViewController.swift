/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 View controller responsible for showing grouped (NSGroupTouchBarItem) NSTouchBarItem instances with a more fancy layout.
 */

import Cocoa

@available(OSX 10.12.2, *)
class FancyGroupViewController: NSViewController {
    // MARK: Action Functions
    
    @IBAction func buttonAction(_ sender: AnyObject) {
        if let button = sender as? NSButton {
            print("\(#function): button with title \"\(button.title)\" is tapped")
        }
    }
    
    @IBAction func sliderChanged(_ sender: AnyObject) {
        if let slider = sender as? NSSlider {
            print("\(#function): \"\(slider.intValue)\"")
        }
    }
    
    @IBAction func principalAction(_ sender: AnyObject) {
        guard let checkBox = sender as? NSButton else { return }
        
        let identifier =
            checkBox.state == NSControl.StateValue.on ? NSTouchBarItem.Identifier("com.TouchBarCatalog.TouchBarItem.fancyGroup") : nil
        touchBar?.principalItemIdentifier = identifier
    }
}

