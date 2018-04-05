/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 Special NSTouchBar for the PopoverViewController.
 */

import Cocoa

@available(OSX 10.12.2, *)
fileprivate extension NSTouchBarItem.Identifier {
    static let button = NSTouchBarItem.Identifier("com.TouchBarCatalog.TouchBarItem.button")
    static let dismissButton = NSTouchBarItem.Identifier("com.TouchBarCatalog.TouchBarItem.dismissButton")
    static let slider = NSTouchBarItem.Identifier("com.TouchBarCatalog.TouchBarItem.slider")
}

// MARK: -

@available(OSX 10.12.2, *)
class PopoverTouchBarSample: NSTouchBar {
    
    var presentingItem: NSPopoverTouchBarItem?
    
    @objc
    func dismiss(_ sender: Any?) {
        guard let popover = presentingItem else { return }
        popover.dismissPopover(sender)
    }
    
    override init() {
        super.init()
        
        delegate = self
        defaultItemIdentifiers = [.button, .slider]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(presentingItem: NSPopoverTouchBarItem? = nil, forPressAndHold: Bool = false) {
        self.init()
        self.presentingItem = presentingItem
        
        // Sliders only work well with press & hold behavior when they are the only item in the popover
        // and you use the slider popover item.
        if forPressAndHold {
            defaultItemIdentifiers = [.slider]
            return
        }
        
        if let showsCloseButton = presentingItem?.showsCloseButton, showsCloseButton == false {
            defaultItemIdentifiers = [.dismissButton, .button, .slider]
        }
    }
    
    @objc
    func actionHandler(_ sender: Any?) {
        print("\(#function) is called")
    }
    
    @objc
    func sliderValueChanged(_ sender: Any) {
        if let sliderItem = sender as? NSSliderTouchBarItem {
            print("Slider value: \(sliderItem.slider.intValue)")
        }
    }
}

// MARK: - NSTouchBarDelegate

@available(OSX 10.12.2, *)
extension PopoverTouchBarSample: NSTouchBarDelegate {
    
    // This gets called while the NSTouchBar is being constructed, for each NSTouchBarItem to be created.
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
        switch identifier {
        case NSTouchBarItem.Identifier.button:
            let custom = NSCustomTouchBarItem(identifier: identifier)
            custom.customizationLabel = NSLocalizedString("Button", comment:"")
            custom.view = NSButton(title: NSLocalizedString("Button", comment:""), target: self, action: #selector(actionHandler(_:)))
            return custom
            
        case NSTouchBarItem.Identifier.dismissButton:
            let custom = NSCustomTouchBarItem(identifier: identifier)
            custom.customizationLabel = NSLocalizedString("Button Button", comment:"")
            custom.view = NSButton(title: NSLocalizedString("Close", comment:""),
                                   target: self,
                                   action: #selector(PopoverTouchBarSample.dismiss(_:)))
            return custom
            
        case NSTouchBarItem.Identifier.slider:
            let sliderItem = NSSliderTouchBarItem(identifier: identifier)
            let slider = sliderItem.slider
            slider.minValue = 0.0
            slider.maxValue = 100.0
            sliderItem.label = NSLocalizedString("Slider", comment:"")
            
            sliderItem.customizationLabel = NSLocalizedString("Slider", comment:"")
            sliderItem.target = self
            sliderItem.action = #selector(sliderValueChanged(_:))
            
            let viewBindings: [String: NSView] = ["slider": slider]
            let constraints = NSLayoutConstraint.constraints(withVisualFormat: "[slider(300)]",
                                                             options: [],
                                                             metrics: nil,
                                                             views: viewBindings)
            NSLayoutConstraint.activate(constraints)
            return sliderItem
            
        default:
            return nil
        }
    }
}

