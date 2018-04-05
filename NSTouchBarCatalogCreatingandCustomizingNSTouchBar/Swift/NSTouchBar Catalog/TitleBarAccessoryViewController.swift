/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 View controller for the title bar accessory containing the "Set Background" button.
 */

import Cocoa

// MARK: -

@available(OSX 10.12.2, *)
class TitleBarAccessoryViewController: NSTitlebarAccessoryViewController {
    var openingViewController: BackgroundImagesViewController!
    var photoManager: PhotoManager!
    
	override func shouldPerformSegue(withIdentifier identifier: NSStoryboardSegue.Identifier, sender: Any?) -> Bool {
        if photoManager == nil {
            // Allocate and initialize our photo manager singleton only once when we really need it.
            photoManager = PhotoManager.shared
        }
        // Don't open the popover if it's already open.
        return openingViewController == nil
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        // Remember our popover's view controller.
        if openingViewController == nil {
            if let destinationController = segue.destinationController as? BackgroundImagesViewController {
                openingViewController = destinationController
            }
        }
    }
    
}

