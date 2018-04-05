/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 View controller responsible for showing NSPopoverTouchBarItem.
 */

import Cocoa

@available(OSX 10.12.2, *)
fileprivate extension NSTouchBar.CustomizationIdentifier {
    static let popoverBar = NSTouchBar.CustomizationIdentifier("com.TouchBarCatalog.popoverBar")
}

@available(OSX 10.12.2, *)
fileprivate extension NSTouchBarItem.Identifier {
    static let popover = NSTouchBarItem.Identifier("com.TouchBarCatalog.TouchBarItem.popover")
}

// MARK: -

@available(OSX 10.12.2, *)
class PopoverViewController: NSViewController {
    
    @IBOutlet weak var useImage: NSButton!
    
    @IBOutlet weak var useLabel: NSButton!
    
    @IBOutlet weak var useCustomClose: NSButton!
    
    @IBOutlet weak var pressAndHold: NSButton!
    
    enum RadioButtonTag: Int {
        case imageLabel = 1014, custom = 1015
    }
    
    var representationType: RadioButtonTag = .imageLabel
    
    // MARK: NSTouchBarProvider
    
    override func makeTouchBar() -> NSTouchBar? {
        let touchBar = NSTouchBar()
        touchBar.delegate = self
        touchBar.customizationIdentifier = .popoverBar
        touchBar.defaultItemIdentifiers = [.popover]
        touchBar.customizationAllowedItemIdentifiers = [.popover]
        touchBar.principalItemIdentifier = .popover
        
        return touchBar
    }
    
    // MARK: Action Functions
    
    @IBAction func representationTypeAction(_ sender: Any) {
        guard let radioButton = sender as? NSButton,
            let choice = RadioButtonTag(rawValue:radioButton.tag) else { return }
        
        representationType = choice
        
        // Image and label options should be disabled for custom style.
        useImage.isEnabled = representationType == .custom ? false : true
        useLabel.isEnabled = representationType == .custom ? false : true
        
        touchBar = nil
    }
    
    @IBAction func customizeAction(_ sender: Any) {
        // Press and Hold or Custom Close checkboxes were clicked.
        touchBar = nil
    }
}

// MARK: - NSTouchBarDelegate

@available(OSX 10.12.2, *)
extension PopoverViewController: NSTouchBarDelegate {
    
    // This gets called while the NSTouchBar is being constructed, for each NSTouchBarItem to be created.
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
        guard identifier == NSTouchBarItem.Identifier.popover else { return nil }
        
        let popoverItem = NSPopoverTouchBarItem(identifier: identifier)
        popoverItem.showsCloseButton = useCustomClose.state == NSControl.StateValue.off
        popoverItem.customizationLabel = NSLocalizedString("Popover", comment:"")
        
        switch representationType {
        case .imageLabel:
            if useImage.state == NSControl.StateValue.on{
                popoverItem.collapsedRepresentationImage = NSImage(named: NSImage.Name.bookmarksTemplate)
            }
            
            if useLabel.state == NSControl.StateValue.on {
                popoverItem.collapsedRepresentationLabel = NSLocalizedString("Open Popover", comment:"")
            }
            
        case .custom:
            let button = NSButton(title: NSLocalizedString("Open Popover", comment:""), target: popoverItem,
                                  action: #selector(NSPopoverTouchBarItem.showPopover(_:)))
            button.bezelColor = NSColor.systemBlue
            
            // Use the built-in gesture recognizer for tap and hold to open our popover's NSTouchBar.
            let gestureRecognizer = popoverItem.makeStandardActivatePopoverGestureRecognizer()
            button.addGestureRecognizer(gestureRecognizer)
            
            popoverItem.collapsedRepresentation = button
        }
        
        // We can setup a different NSTouchBar instance for popoverTouchBar and pressAndHoldTouchBar property
        // However, in that case, the chevron won't be shown. Here we just use the same NSTouchBar instance.
        if pressAndHold.state == NSControl.StateValue.on {
            popoverItem.pressAndHoldTouchBar = PopoverTouchBarSample(presentingItem: popoverItem, forPressAndHold: true)
            popoverItem.popoverTouchBar = popoverItem.pressAndHoldTouchBar!
            popoverItem.showsCloseButton = true
        } else {
            popoverItem.popoverTouchBar = PopoverTouchBarSample(presentingItem: popoverItem)
        }
        
        return popoverItem
    }
}

