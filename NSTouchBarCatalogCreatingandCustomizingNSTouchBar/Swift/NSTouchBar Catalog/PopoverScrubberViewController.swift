/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 View controller responsible for showing NSScrubber with a NSPopoverTouchBarItem.
 */

import Cocoa

@available(OSX 10.12.2, *)
fileprivate extension NSTouchBar.CustomizationIdentifier {
    static let popoverBar = NSTouchBar.CustomizationIdentifier("com.TouchBarCatalog.popoverBar")
}

@available(OSX 10.12.2, *)
fileprivate extension NSTouchBarItem.Identifier {
    static let scrubberPopover = NSTouchBarItem.Identifier("com.TouchBarCatalog.TouchBarItem.scrubberPopover")
}

// MARK: -

@available(OSX 10.12.2, *)
class PopoverScrubber: NSScrubber {
    var presentingItem: NSPopoverTouchBarItem?
}

// MARK: -

@available(OSX 10.12.2, *)
class PopoverScrubberViewController: NSViewController {
    // MARK: NSTouchBarProvider
    
    override func makeTouchBar() -> NSTouchBar? {
        let touchBar = NSTouchBar()
        touchBar.delegate = self
        touchBar.customizationIdentifier = .popoverBar
        touchBar.defaultItemIdentifiers = [.scrubberPopover]
        touchBar.customizationAllowedItemIdentifiers = [.scrubberPopover]
        
        return touchBar
    }
}

// MARK: - NSTouchBarDelegate

@available(OSX 10.12.2, *)
extension PopoverScrubberViewController: NSTouchBarDelegate {
    
    // This gets called while the NSTouchBar is being constructed, for each NSTouchBarItem to be created.
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
        guard identifier == NSTouchBarItem.Identifier.scrubberPopover else { return nil }
        
        let popoverItem = NSPopoverTouchBarItem(identifier: identifier)
        popoverItem.collapsedRepresentationLabel = NSLocalizedString("Scrubber Popover", comment:"")
        popoverItem.customizationLabel = NSLocalizedString("Scrubber Popover", comment:"")
        
        let scrubber = PopoverScrubber()
        scrubber.register(NSScrubberTextItemView.self, forItemIdentifier: NSUserInterfaceItemIdentifier("TextScrubberItemIdentifier"))
        
        scrubber.mode = .free
        scrubber.selectionBackgroundStyle = .roundedBackground
        scrubber.delegate = self
        scrubber.dataSource = self
        scrubber.presentingItem = popoverItem
        
        popoverItem.collapsedRepresentation = scrubber
        
        popoverItem.popoverTouchBar = PopoverTouchBarSample(presentingItem: popoverItem)
        
        return popoverItem
    }
}

// MARK: - NSScrubber Data Source and delegate

@available(OSX 10.12.2, *)
extension PopoverScrubberViewController: NSScrubberDataSource, NSScrubberDelegate {
    
    func numberOfItems(for scrubber: NSScrubber) -> Int {
        return 10
    }
    
    // Scrubber is asking for a custom view represention for a particuler item index.
    func scrubber(_ scrubber: NSScrubber, viewForItemAt index: Int) -> NSScrubberItemView {
        var returnItemView = NSScrubberItemView()
        if let itemView =
            scrubber.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "TextScrubberItemIdentifier"),
                              owner: nil) as? NSScrubberTextItemView {
            itemView.textField.stringValue = String(index)
            returnItemView = itemView
        }
        return returnItemView
    }
    
    // User chose a particular image inside the scrubber.
    func scrubber(_ scrubber: NSScrubber, didSelectItemAt index: Int) {
        print("\(#function) at index \(index)")
        
        if let popoverScrubber = scrubber as? PopoverScrubber,
            let popoverItem = popoverScrubber.presentingItem {
            popoverItem.showPopover(nil)
        }
    }
}

