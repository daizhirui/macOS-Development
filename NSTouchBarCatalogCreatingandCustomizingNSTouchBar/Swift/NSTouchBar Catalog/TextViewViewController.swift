/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 View controller responsible for NSTouchBarItem instances used with an NSTextView.
 */

import Cocoa

@available(OSX 10.12.2, *)
fileprivate extension NSTouchBar.CustomizationIdentifier {
    static let textViewBar = NSTouchBar.CustomizationIdentifier("com.TouchBarCatalog.textViewBar")
}

@available(OSX 10.12.2, *)
fileprivate extension NSTouchBarItem.Identifier {
    static let toggleBold = NSTouchBarItem.Identifier("com.TouchBarCatalog.TouchBarItem.toggleBold")
}

enum ButtonTitles {
    static let normal = NSLocalizedString("Normal", comment: "")
    static let bold = NSLocalizedString("Bold", comment: "")
}

// MARK: -

@available(OSX 10.12.2, *)
class TextViewViewController: NSViewController {
    @IBOutlet weak var textView: NSTextView!
    
    @IBOutlet weak var customTouchBarCheckbox: NSButton!
    
    var isBold = false
    
    // MARK: NSTouchBarProvider
    
    override func makeTouchBar() -> NSTouchBar? {
        let touchBar = NSTouchBar()
        touchBar.delegate = self
        touchBar.customizationIdentifier = .textViewBar
        touchBar.defaultItemIdentifiers = [.toggleBold, .otherItemsProxy]
        touchBar.customizationAllowedItemIdentifiers = [.toggleBold]
        touchBar.principalItemIdentifier = .toggleBold
        
        return touchBar
    }
    
    // MARK: Action Functions
    
    @objc
    func toggleBoldButtonAction(_ sender: Any) {
        guard let button = sender as? NSButton else { return }
        
        isBold = !isBold
        button.title = isBold ? ButtonTitles.normal : ButtonTitles.bold
        
        if let textStorage = textView.textStorage {
            let face = isBold ? NSFontTraitMask.boldFontMask : NSFontTraitMask.unboldFontMask
            textStorage.applyFontTraits(face, range: NSRange(location: 0, length: textStorage.length))
        }
    }
    
    @IBAction func customTouchBarAction(_ sender: AnyObject) {
        textView.isAutomaticTextCompletionEnabled = customTouchBarCheckbox.state != NSControl.StateValue.on
        touchBar = nil
    }
}

// MARK: - NSTouchBarDelegate

@available(OSX 10.12.2, *)
extension TextViewViewController: NSTouchBarDelegate {
    
    // This gets called while the NSTouchBar is being constructed, for each NSTouchBarItem to be created.
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
        guard identifier == NSTouchBarItem.Identifier.toggleBold else { return nil }
        
        let custom = NSCustomTouchBarItem(identifier: identifier)
        custom.customizationLabel = NSLocalizedString("Bold Button", comment:"")
        let title = isBold ? ButtonTitles.normal : ButtonTitles.bold
        custom.view = NSButton(title: title, target: self, action: #selector(toggleBoldButtonAction(_:)))
        
        return custom
    }
}

// MARK: - NSTextViewDelegate

@available(OSX 10.12.2, *)
extension TextViewViewController: NSTextViewDelegate {
    func textView(_ textView: NSTextView,
                  shouldUpdateTouchBarItemIdentifiers identifiers: [NSTouchBarItem.Identifier]) -> [NSTouchBarItem.Identifier] {
        return customTouchBarCheckbox.state == NSControl.StateValue.on ? [] : identifiers
    }
}

