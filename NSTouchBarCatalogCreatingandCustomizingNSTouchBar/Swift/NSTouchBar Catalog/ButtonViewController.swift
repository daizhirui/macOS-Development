/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 View controller responsible for showing NSButtons in an NSTouchBar instance.
 */

import Cocoa

@available(OSX 10.12.2, *)
class ButtonViewController: NSViewController {
    
    @IBOutlet weak var sizeConstraint: NSButton!
    
    @IBOutlet weak var useCustomColor: NSButton!
    
    @IBOutlet weak var button3: NSButton!
    
    lazy var button3Constraints: [NSLayoutConstraint] = {
        return NSLayoutConstraint.constraints(withVisualFormat: "H:[button3(200)]",
                                              options: [],
                                              metrics: nil,
                                              views: ["button3": self.button3!])
    }()
    
    // MARK: - Action Functions
    
    @IBAction func customize(_ sender: AnyObject) {
        guard let touchBar = touchBar else { return }
        
        for itemIdentifier in touchBar.itemIdentifiers {
            
            guard let item = touchBar.item(forIdentifier: itemIdentifier) as? NSCustomTouchBarItem,
                let button = item.view as? NSButton else { continue }
            
            let textRange = NSRange(location: 0, length: button.title.count)
            let titleColor = useCustomColor.state == NSControl.StateValue.on ? NSColor.black : NSColor.white
            let newTitle = NSMutableAttributedString(string: button.title)
            newTitle.addAttribute(NSAttributedStringKey.foregroundColor, value: titleColor, range: textRange)
            newTitle.addAttribute(NSAttributedStringKey.font, value: button.font!, range: textRange)
            newTitle.setAlignment(.center, range: textRange)
            button.attributedTitle = newTitle
            
            button.bezelColor = useCustomColor.state == NSControl.StateValue.on ? NSColor.systemYellow : nil
        }
        
        if sizeConstraint.state == NSControl.StateValue.on {
            NSLayoutConstraint.activate(button3Constraints)
        } else {
            NSLayoutConstraint.deactivate(button3Constraints)
        }
    }
    
    @IBAction func buttonAction(_ sender: AnyObject) {
        if let button = sender as? NSButton {
            print("\(#function): button with title \"\(button.title)\" is tapped")
        }
    }
}

