/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 View controller responsible for showing NSCustomTouchBarItem with an NSScrubber, using a custom subclass of NSScrubberImageItemView.
 */

import Cocoa

@available(OSX 10.12.2, *)
fileprivate extension NSTouchBar.CustomizationIdentifier {
    static let scrubberBar = NSTouchBar.CustomizationIdentifier("com.TouchBarCatalog.scrubberBar")
}

@available(OSX 10.12.2, *)
fileprivate extension NSTouchBarItem.Identifier {
    static let imageScrubber = NSTouchBarItem.Identifier("com.TouchBarCatalog.TouchBarItem.imageScrubber")
    static let textScrubber = NSTouchBarItem.Identifier("com.TouchBarCatalog.TouchBarItem.textScrubber")
    static let iconTextScrubber = NSTouchBarItem.Identifier("com.TouchBarCatalog.TouchBarItem.customScrubber")
}

// Button Tag enums. The values have to be the same as the button tags in the storyboard.
fileprivate enum KindButtonTag: Int {
    case imageScrubber = 2000, textScrubber = 2001, iconTextScrubber = 2014
}

fileprivate enum ModeButtonTag: Int {
    case free = 2002, fixed = 2003
}

fileprivate enum SelectionBackgroundStyleButtonTag: Int {
    case none = 2004, boldOutline = 2005, solidBackground = 2006, custom = 2007
}

enum SelectionOverlayStyleButtonTag: Int {
    case none = 2008, boldOutline = 2009, solidBackground = 2010, custom = 2011
}

enum LayoutTypeButtonTag: Int {
    case flow = 2012, proportional = 2013
}

// MARK: -

@available(OSX 10.12.2, *)
class ScrubberViewController: NSViewController {
    
    var selectedItemIdentifier: NSTouchBarItem.Identifier = .imageScrubber
    
    var selectedMode: NSScrubber.Mode = .free
    
    var selectedSelectionBackgroundStyle: NSScrubberSelectionStyle?
    
    var selectedSelectionOverlayStyle: NSScrubberSelectionStyle?
    
    var selectedLayout: NSScrubberLayout = NSScrubberFlowLayout()
    
    @IBOutlet weak var spacingSlider: NSSlider!
    
    @IBOutlet weak var showsArrows: NSButton!
    
    @IBOutlet weak var useBackgroundColor: NSButton!
    
    @IBOutlet weak var useBackgroundView: NSButton!
    
    @IBOutlet weak var backgroundColorWell: NSColorWell!
    
    // MARK: Action Functions
    
    @IBAction func customizeAction(_ sender: AnyObject) {
        // This will cause makeTouchBar to be called.
		touchBar = nil
    }
    
    @IBAction func useBackgroundColorAction(_ sender: AnyObject) {
        backgroundColorWell.isEnabled = (sender.state == NSControl.StateValue.on)
        // This will cause makeTouchBar to be called.
        touchBar = nil
    }
    
    @IBAction func kindAction(_ sender: AnyObject) {
        guard let button = sender as? NSButton, let choice = KindButtonTag(rawValue: button.tag) else { return }
        
        switch choice {
        case .imageScrubber:
            selectedItemIdentifier = .imageScrubber
            
        case .textScrubber:
            selectedItemIdentifier = .textScrubber
            
        case .iconTextScrubber:
            selectedItemIdentifier = .iconTextScrubber
        }
        
        // This will cause makeTouchBar to be called.
        touchBar = nil
    }
    
    @IBAction func modeAction(_ sender: AnyObject) {
        guard let button = sender as? NSButton, let choice = ModeButtonTag(rawValue: button.tag) else { return }
        
        switch choice {
        case .free:
            selectedMode = .free
            
        case .fixed:
            selectedMode = .fixed
        }
        
        // This will cause makeTouchBar to be called.
        touchBar = nil
    }
    
    @IBAction func selectionAction(_ sender: AnyObject) {
        guard let button = sender as? NSButton, let choice = SelectionBackgroundStyleButtonTag(rawValue: button.tag) else { return }
        
        switch choice {
        case .none:
            selectedSelectionBackgroundStyle = nil
            
        case .boldOutline:
            selectedSelectionBackgroundStyle = .outlineOverlay
            
        case .solidBackground:
            selectedSelectionBackgroundStyle = .roundedBackground
            
        case .custom:
            selectedSelectionBackgroundStyle = CustomSelectionBackgroundStyle()
        }
        
        // This will cause makeTouchBar to be called.
        touchBar = nil
    }
    
    @IBAction func overlayAction(_ sender: AnyObject) {
        guard let button = sender as? NSButton, let choice = SelectionOverlayStyleButtonTag(rawValue: button.tag) else { return }
        
        switch choice {
        case .none:
            selectedSelectionOverlayStyle = nil
            
        case .boldOutline:
            selectedSelectionOverlayStyle = .outlineOverlay
            
        case .solidBackground:
            selectedSelectionOverlayStyle = .roundedBackground
            
        case .custom:
            selectedSelectionOverlayStyle = CustomSelectionOverlayStyle()
        }
        
        // This will cause makeTouchBar to be called.
        touchBar = nil
    }
    
    @IBAction func flowAction(_ sender: AnyObject) {
		guard let button = sender as? NSButton, let choice = LayoutTypeButtonTag(rawValue: button.tag) else { return }
		
        switch choice {
        case .flow:
			selectedLayout = NSScrubberFlowLayout()
            
        case .proportional:
			selectedLayout = NSScrubberProportionalLayout()
        }
        
        // This will cause makeTouchBar to be called.
		touchBar = nil
    }
    
    @IBAction func spacingSliderAction(_ sender: AnyObject) {
        // This will cause makeTouchBar to be called.
        touchBar = nil
    }
    
    // MARK: NSTouchBarProvider
    
    override func makeTouchBar() -> NSTouchBar? {
        let touchBar = NSTouchBar()
		touchBar.delegate = self
		
        touchBar.customizationIdentifier = .scrubberBar
        touchBar.defaultItemIdentifiers = [selectedItemIdentifier]
        touchBar.customizationAllowedItemIdentifiers = [selectedItemIdentifier]
        touchBar.principalItemIdentifier = selectedItemIdentifier

		return touchBar
    }
}

// MARK: - NSTouchBarDelegate

@available(OSX 10.12.2, *)
extension ScrubberViewController: NSTouchBarDelegate {
    
    // This gets called while the NSTouchBar is being constructed, for each NSTouchBarItem to be created.
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
		let scrubberItem: NSCustomTouchBarItem
        
        switch identifier {
        case NSTouchBarItem.Identifier.textScrubber:
            scrubberItem = TextScrubberBarItemSample(identifier: identifier)
            scrubberItem.customizationLabel = NSLocalizedString("Text Scrubber", comment:"")
            (scrubberItem as? TextScrubberBarItemSample)?.scrubberItemWidth = spacingSlider.integerValue
            
        case NSTouchBarItem.Identifier.imageScrubber:
            scrubberItem = ImageScrubberBarItemSample(identifier: identifier)
            scrubberItem.customizationLabel = NSLocalizedString("Image Scrubber", comment:"")
            (scrubberItem as? ImageScrubberBarItemSample)?.scrubberItemWidth = spacingSlider.integerValue
            
        case NSTouchBarItem.Identifier.iconTextScrubber:
            scrubberItem = IconTextScrubberBarItemSample(identifier: identifier)
            scrubberItem.customizationLabel = NSLocalizedString("IconText Scrubber", comment:"")
            
        default:
            return nil
        }
        
		guard let scrubber = scrubberItem.view as? NSScrubber else { return nil }
        
        scrubber.mode = selectedMode
        scrubber.showsArrowButtons = showsArrows.state == NSControl.StateValue.on
		scrubber.selectionBackgroundStyle = selectedSelectionBackgroundStyle
        scrubber.selectionOverlayStyle = selectedSelectionOverlayStyle
        scrubber.scrubberLayout = selectedLayout
        if useBackgroundColor.state == NSControl.StateValue.on {
            scrubber.backgroundColor = backgroundColorWell.color
        }
        
        if useBackgroundView.state == NSControl.StateValue.on {
            scrubber.backgroundView = CustomBackgroundView()
        }
        
        // Set the scrubber's width to be 400.
        let viewBindings: [String: NSView] = ["scrubber": scrubber]
        let hconstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[scrubber(400)]",
                                                          options: [],
                                                          metrics: nil,
                                                          views: viewBindings)
        NSLayoutConstraint.activate(hconstraints)
        
        return scrubberItem
    }
}

