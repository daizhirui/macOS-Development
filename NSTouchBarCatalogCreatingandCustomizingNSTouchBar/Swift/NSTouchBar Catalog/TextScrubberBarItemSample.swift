/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 Custom NSCustomTouchBarItem class for text content.
 */

import Cocoa

@available(OSX 10.12.2, *)
class TextScrubberBarItemSample: NSCustomTouchBarItem, NSScrubberDelegate, NSScrubberDataSource, NSScrubberFlowLayoutDelegate {
    
    private static let itemViewIdentifier = "TextItemViewIdentifier"
    
    var scrubberItemWidth: Int = 80
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(identifier: NSTouchBarItem.Identifier) {
        super.init(identifier: identifier)
        
        let scrubber = NSScrubber()
        scrubber.scrubberLayout = NSScrubberFlowLayout()
        scrubber.register(NSScrubberTextItemView.self, forItemIdentifier: NSUserInterfaceItemIdentifier(TextScrubberBarItemSample.itemViewIdentifier))
        
        scrubber.mode = .fixed
        scrubber.selectionBackgroundStyle = .roundedBackground
        scrubber.delegate = self
        scrubber.dataSource = self
        
        view = scrubber
    }
    
    func numberOfItems(for scrubber: NSScrubber) -> Int {
        return 20
    }
    
    // Scrubber is asking for a custom view represention for a particuler item index.
    func scrubber(_ scrubber: NSScrubber, viewForItemAt index: Int) -> NSScrubberItemView {
        var returnItemView = NSScrubberItemView()
        if let itemView =
            scrubber.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: type(of: self).itemViewIdentifier),
                              owner: nil) as? NSScrubberTextItemView {
            itemView.textField.stringValue = String(index)
            itemView.textField.backgroundColor = NSColor.systemBlue
            returnItemView = itemView
        }
        return returnItemView
    }
    
    // Scrubber is asking for the size for a particular item.
    func scrubber(_ scrubber: NSScrubber, layout: NSScrubberFlowLayout, sizeForItemAt itemIndex: Int) -> NSSize {
        return NSSize(width: scrubberItemWidth, height: 30)
    }
    
    // User chose a particular image inside the scrubber.
    func scrubber(_ scrubber: NSScrubber, didSelectItemAt index: Int) {
        print("\(#function) at index \(index)")
    }
}

