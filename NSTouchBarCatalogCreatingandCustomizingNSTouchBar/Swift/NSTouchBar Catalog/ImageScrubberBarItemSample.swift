/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 Custom NSCustomTouchBarItem class for images.
 */

import Cocoa

@available(OSX 10.12.2, *)
class ImageScrubberBarItemSample: NSCustomTouchBarItem, NSScrubberDelegate, NSScrubberDataSource, NSScrubberFlowLayoutDelegate {
    
    private static let itemViewIdentifier = "ImageItemViewIdentifier"
    
    var scrubberItemWidth: Int = 50
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(identifier: NSTouchBarItem.Identifier) {
        super.init(identifier: identifier)
        
        let scrubber = NSScrubber()
        scrubber.register(ThumbnailItemView.self, forItemIdentifier: NSUserInterfaceItemIdentifier(ImageScrubberBarItemSample.itemViewIdentifier))
        scrubber.mode = .free
        scrubber.selectionBackgroundStyle = .roundedBackground
        scrubber.delegate = self
        scrubber.dataSource = self
        
        view = scrubber
    }
    
    private var pictures = [URL]()
    
    private func fetchPictureResources() {
        let library = FileManager.default.urls(for: .libraryDirectory, in: .localDomainMask)[0]
        let desktopPicturesURL = library.appendingPathComponent("Desktop Pictures", isDirectory: true)
        
        let enumerator =
            FileManager.default.enumerator(at: desktopPicturesURL,
                                           includingPropertiesForKeys: nil,
                                           options: .skipsHiddenFiles,
                                           errorHandler: nil)!
        
        for url in enumerator {
            guard let url = url as? URL else { continue }
            pictures.append(url)
        }
    }
    
    func numberOfItems(for scrubber: NSScrubber) -> Int {
        if pictures.isEmpty {
            fetchPictureResources()
        }
        return pictures.count
    }
    
    // Scrubber is asking for a custom view represention for a particuler item index.
    func scrubber(_ scrubber: NSScrubber, viewForItemAt index: Int) -> NSScrubberItemView {
        var returnItemView = NSScrubberItemView()
        if let itemView =
            scrubber.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: ImageScrubberBarItemSample.itemViewIdentifier),
                              owner: nil) as? ThumbnailItemView {
            if index < pictures.count {
                itemView.imageURL = pictures[index]
            }
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

