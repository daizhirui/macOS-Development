/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 Main window controller for this sample.
 */

import Cocoa

struct AssetNames {
    static let image = "Sunset_2"
    static let red = "Red"
    static let green = "Green"
}

// MARK: -

@available(OSX 10.12.2, *)
fileprivate extension NSTouchBarItem.Identifier {
    static let label = NSTouchBarItem.Identifier("com.TouchBarCatalog.TouchBarItem.label")
}

// MARK: -

class WindowController: NSWindowController {
    
    let backgroundWindowIdentifier = "BackgroundWindow"
    var backgroundWindowController: NSWindowController!
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        window?.setFrameAutosaveName(NSWindow.FrameAutosaveName(rawValue: "WindowAutosave"))
        
        // Load the Background Window from it's separate storyboard.
        let storyboard = NSStoryboard(name:NSStoryboard.Name(rawValue: backgroundWindowIdentifier), bundle: nil)
        if let windowController =
            storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: backgroundWindowIdentifier))
                as? NSWindowController {
            backgroundWindowController = windowController
            backgroundWindowController.window?.setFrameAutosaveName(NSWindow.FrameAutosaveName(rawValue: backgroundWindowIdentifier))
            backgroundWindowController.showWindow(nil)
        }
    }
    
    // MARK: NSTouchBarProvider
    
    @available(OSX 10.12.2, *)
    override func makeTouchBar() -> NSTouchBar? {
        let touchBar = NSTouchBar()
        touchBar.delegate = self
        touchBar.customizationIdentifier = NSTouchBar.CustomizationIdentifier("com.TouchBarCatalog.windowTouchBar")
        touchBar.defaultItemIdentifiers = [.label, .fixedSpaceLarge, .otherItemsProxy]
        
        return touchBar
    }
    
}

// MARK: - NSTouchBarDelegate

@available(OSX 10.12.2, *)
extension WindowController: NSTouchBarDelegate {
    
    // This gets called while the NSTouchBar is being constructed, for each NSTouchBarItem to be created.
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
        switch identifier {
        case NSTouchBarItem.Identifier.label:
            let custom = NSCustomTouchBarItem(identifier: identifier)
            let label = NSTextField(labelWithString: NSLocalizedString("Catalog", comment: ""))
            custom.view = label
            
            return custom
            
        default:
            return nil
        }
    }
}

