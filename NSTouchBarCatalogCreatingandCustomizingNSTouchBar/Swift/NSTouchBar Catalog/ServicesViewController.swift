/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 View controller responsible for showing NSSharingServicePickerTouchBarItem in an NTouchBar instance.
 */

import Cocoa

@available(OSX 10.12.2, *)
fileprivate extension NSTouchBar.CustomizationIdentifier {
    static let servicesBar = NSTouchBar.CustomizationIdentifier("com.TouchBarCatalog.servicesBar")
}

@available(OSX 10.12.2, *)
fileprivate extension NSTouchBarItem.Identifier {
    static let services = NSTouchBarItem.Identifier("com.TouchBarCatalog.TouchBarItem.services")
}

// MARK: -

@available(OSX 10.12.2, *)
class ServicesViewController: NSViewController {
    var imageToSend = NSImage(named: NSImage.Name(rawValue: AssetNames.image))!
    
    // MARK: NSTouchBarProvider
    
    override func makeTouchBar() -> NSTouchBar? {
        let touchBar = NSTouchBar()
        touchBar.delegate = self
        touchBar.customizationIdentifier = .servicesBar
        touchBar.defaultItemIdentifiers = [.services]
        touchBar.customizationAllowedItemIdentifiers = [.services]
        touchBar.principalItemIdentifier = .services
        
        return touchBar
    }
}

// MARK: - NSTouchBarDelegate

@available(OSX 10.12.2, *)
extension ServicesViewController: NSTouchBarDelegate {
    
    // This gets called while the NSTouchBar is being constructed, for each NSTouchBarItem to be created.
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
        guard identifier == .services else { return nil }
        
        let services = NSSharingServicePickerTouchBarItem(identifier: identifier)
        services.delegate = self
        
        return services
    }
}

// MARK: - NSSharingServicePickerTouchBarItemDelegate

@available(OSX 10.12.2, *)
extension ServicesViewController: NSSharingServicePickerTouchBarItemDelegate {
    func items(for pickerTouchBarItem: NSSharingServicePickerTouchBarItem) -> [Any] {
        return [imageToSend]
    }
}

// MARK: - NSSharingServiceDelegate

@available(OSX 10.12.2, *)
extension ServicesViewController: NSSharingServiceDelegate {
    
    // MARK: NSSharingServicePickerDelegate
    
    func sharingServicePicker(_ sharingServicePicker: NSSharingServicePicker,
                              delegateFor sharingService: NSSharingService) -> NSSharingServiceDelegate? {
        return self
    }
    
    // MARK: NSSharingServiceDelegate
    
    func sharingService(_ sharingService: NSSharingService, sourceFrameOnScreenForShareItem item: Any) -> NSRect {
        return NSRect(x: 0, y: 0, width: imageToSend.size.width, height: imageToSend.size.height)
    }
    
    func sharingService(_ sharingService: NSSharingService,
                        transitionImageForShareItem item: Any, contentRect: UnsafeMutablePointer<NSRect>) -> NSImage? {
        return imageToSend
    }
    
    public func sharingService(_ sharingService: NSSharingService,
                               sourceWindowForShareItems items: [Any],
                               sharingContentScope: UnsafeMutablePointer<NSSharingService.SharingContentScope>) -> NSWindow? {
        return view.window
    }
    
}

