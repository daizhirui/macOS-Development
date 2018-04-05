/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 View controller responsible for showing custom view touch items.
 */

import Cocoa

@available(OSX 10.12.2, *)
fileprivate extension NSTouchBar.CustomizationIdentifier {
    static let customViewBar = NSTouchBar.CustomizationIdentifier("com.TouchBarCatalog.customViewBar")
}

@available(OSX 10.12.2, *)
fileprivate extension NSTouchBarItem.Identifier {
    static let touchEvent = NSTouchBarItem.Identifier("com.TouchBarCatalog.TouchBarItem.touchEvent")
    static let panGR = NSTouchBarItem.Identifier("com.TouchBarCatalog.TouchBarItem.panGR")
}

fileprivate enum InteractionTypeButtonTag: Int {
    case touchEvent = 1000, panGR = 1001
}

// MARK: -

@available(OSX 10.12.2, *)
class CustomViewViewController: NSViewController {
    
    @IBOutlet weak var feedbackLabel: NSTextField!
    
    var selectedItemIdentifier: NSTouchBarItem.Identifier = .touchEvent
    
    // MARK: NSTouchBarProvider
    
    override func makeTouchBar() -> NSTouchBar? {
        let touchBar = NSTouchBar()
        touchBar.delegate = self
        touchBar.customizationIdentifier = .customViewBar
        touchBar.defaultItemIdentifiers = [selectedItemIdentifier]
        touchBar.customizationAllowedItemIdentifiers = [selectedItemIdentifier]
        
        return touchBar
    }
    
    // MARK: Action Functions
    
    @IBAction func choiceAction(_ sender: AnyObject) {
        guard let button = sender as? NSButton,
            let choice = InteractionTypeButtonTag(rawValue:button.tag) else { return }
        
        switch choice {
        case .touchEvent:
            selectedItemIdentifier = .touchEvent
            
        case .panGR:
            selectedItemIdentifier = .panGR
        }
        
        feedbackLabel.stringValue = ""
        
        touchBar = nil
    }
    
    // MARK: Gesture Recognizer
    
    @objc
    func panGestureHandler(_ sender: NSGestureRecognizer?) {
        guard let currentItem = touchBar?.item(forIdentifier: selectedItemIdentifier),
            let itemView = currentItem.view, let panGR = sender else { return }
        
        var feedbackStr = NSLocalizedString("Pan Gesture", comment: "")
        let state = sender!.state
        
        switch state {
        case .began:
            feedbackStr += NSLocalizedString("Began", comment: "")
            
        case .changed:
            feedbackStr += NSLocalizedString("Changed", comment: "")
            
        case .ended:
            feedbackStr += NSLocalizedString("Ended", comment: "")
            
        default:
            break
        }
        
        let location = panGR.location(in: itemView)
        feedbackStr += String(format: NSLocalizedString("Gesture Format", comment: ""), location.x)
        
        feedbackLabel.stringValue = feedbackStr
    }
    
    deinit {
        feedbackLabel.unbind(NSBindingName.value)
    }
}

// MARK: - NSTouchBarDelegate

@available(OSX 10.12.2, *)
extension CustomViewViewController: NSTouchBarDelegate {
    
    // This gets called while the NSTouchBar is being constructed, for each NSTouchBarItem to be created.
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
        switch identifier {
        case NSTouchBarItem.Identifier.touchEvent:
            let canvasView = CanvasView()
            canvasView.wantsLayer = true
            canvasView.layer?.backgroundColor = NSColor.systemBlue.cgColor
            canvasView.allowedTouchTypes = .direct
            
            feedbackLabel.unbind(NSBindingName.value)
            feedbackLabel.bind(NSBindingName.value, to: canvasView, withKeyPath: #keyPath(CanvasView.trackingLocationString))
            
            let custom = NSCustomTouchBarItem(identifier: identifier)
            custom.view = canvasView
            
            return custom
            
        case NSTouchBarItem.Identifier.panGR:
            let view = NSView()
            view.wantsLayer = true
            view.layer?.backgroundColor = NSColor.systemGray.cgColor
            
            let panGestureRecognizer = NSPanGestureRecognizer()
            panGestureRecognizer.target = self
            panGestureRecognizer.action = #selector(CustomViewViewController.panGestureHandler(_:))
            panGestureRecognizer.allowedTouchTypes = .direct
            view.addGestureRecognizer(panGestureRecognizer)
            
            let custom = NSCustomTouchBarItem(identifier: identifier)
            custom.view = view
            return custom
            
        default:
            return nil
        }
    }
}

