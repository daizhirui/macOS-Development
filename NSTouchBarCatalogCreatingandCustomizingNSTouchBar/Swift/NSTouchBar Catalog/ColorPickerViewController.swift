/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 View controller responsible for showing different color picker items.
 */

import Cocoa

@available(OSX 10.12.2, *)
fileprivate extension NSTouchBar.CustomizationIdentifier {
    static let colorPickerBar = NSTouchBar.CustomizationIdentifier("com.TouchBarCatalog.colorPickerBar")
}

@available(OSX 10.12.2, *)
fileprivate extension NSTouchBarItem.Identifier {
    static let color = NSTouchBarItem.Identifier("com.TouchBarCatalog.TouchBarItem.color")
    static let text = NSTouchBarItem.Identifier("com.TouchBarCatalog.TouchBarItem.text")
    static let stroke = NSTouchBarItem.Identifier("com.TouchBarCatalog.TouchBarItem.stroke")
}

fileprivate enum PickerTypeButtonTag: Int {
    case color = 1002, text = 1003, stroke = 1004
}

// MARK: -

@available(OSX 10.12.2, *)
class ColorPickerViewController: NSViewController {
    
    @IBOutlet weak var customColors: NSButton!
    
    var selectedItemIdentifier: NSTouchBarItem.Identifier = .color
    
    // MARK: NSTouchBarProvider
    
    override func makeTouchBar() -> NSTouchBar? {
        let touchBar = NSTouchBar()
        touchBar.delegate = self
        touchBar.customizationIdentifier = .colorPickerBar
        touchBar.defaultItemIdentifiers = [selectedItemIdentifier]
        touchBar.customizationAllowedItemIdentifiers = [selectedItemIdentifier]
        touchBar.principalItemIdentifier = selectedItemIdentifier
        
        return touchBar
    }
    
    // MARK: Action Functions
    
    @IBAction func choiceAction(_ sender: AnyObject) {
        guard let button = sender as? NSButton,
            let choice = PickerTypeButtonTag(rawValue:button.tag) else { return }
        
        switch choice {
        case .color:
            selectedItemIdentifier = .color
            
        case .text:
            selectedItemIdentifier = .text
            
        case .stroke:
            selectedItemIdentifier = .stroke
        }
        
        touchBar = nil
    }
    
    @IBAction func customColorsAction(_ sender: AnyObject) {
        touchBar = nil
    }
    
    @objc
    func colorDidPick(_ colorPicker: NSColorPickerTouchBarItem) {
        print("Picked color: \(colorPicker.color)")
    }
}

// MARK: - NSTouchBarDelegate

@available(OSX 10.12.2, *)
extension ColorPickerViewController: NSTouchBarDelegate {
    
    // This gets called while the NSTouchBar is being constructed, for each NSTouchBarItem to be created.
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
        let colorPicker: NSColorPickerTouchBarItem
        
        switch identifier {
        case NSTouchBarItem.Identifier.color:
            colorPicker = NSColorPickerTouchBarItem.colorPicker(withIdentifier: identifier)
            
        case NSTouchBarItem.Identifier.text:
            colorPicker = NSColorPickerTouchBarItem.textColorPicker(withIdentifier: identifier)
            
        case NSTouchBarItem.Identifier.stroke:
            colorPicker = NSColorPickerTouchBarItem.strokeColorPicker(withIdentifier: identifier)
            
        default:
            return nil
        }
        
        colorPicker.customizationLabel = NSLocalizedString("Choose Photo", comment:"")
        colorPicker.target = self
        colorPicker.action = #selector(colorDidPick(_:))
        
        if customColors.state == NSControl.StateValue.on {
            let colorList = ["Red": NSColor.systemRed, "Green": NSColor.systemGreen, "Blue": NSColor.systemBlue]
            colorPicker.colorList = NSColorList()
            
            for (key, color) in colorList {
                colorPicker.colorList.setColor(color, forKey: NSColor.Name(rawValue: key))
            }
        }
        
        return colorPicker
    }
}

