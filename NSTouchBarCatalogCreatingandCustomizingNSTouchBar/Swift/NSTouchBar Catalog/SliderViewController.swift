/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 View controller responsible for showing NSSliderTouchBarItem.
 */

import Cocoa

@available(OSX 10.12.2, *)
class SliderViewController: NSViewController {
    
    // The default class for a slider item is NSCustomTouchBarItem.
    // Make sure it is changed to NSSliderTouchBarItem if more slider item configuraiton is needed
    @IBOutlet weak var sliderItem: NSSliderTouchBarItem!
    
    @IBOutlet weak var feedbackLabel: NSTextField!
    
    // MARK: View Controller Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        sliderItem.label = NSLocalizedString("Slider", comment:"")
        
        sliderItem.target = self
        sliderItem.action = #selector(sliderValueChanged(_:))
        
        // valueAccessoryWidth should have a .default value
        sliderItem.valueAccessoryWidth = .default
        
        // Set up slider min and max limits
        sliderItem.slider.minValue = 0.0
        sliderItem.slider.maxValue = 100.0
    }
    
    deinit {
        sliderItem.slider.unbind(NSBindingName.value)
    }
    
    // MARK: Action Functions
    
    @IBAction func useSliderAccessoryAction(_ sender: AnyObject) {
        guard let checkBox = sender as? NSButton else { return }
        
        if checkBox.state == NSControl.StateValue.on {
            sliderItem.minimumValueAccessory = NSSliderAccessory(image: NSImage(named: NSImage.Name(rawValue: AssetNames.red))!)
            sliderItem.maximumValueAccessory = NSSliderAccessory(image: NSImage(named: NSImage.Name(rawValue: AssetNames.green))!)
        } else {
            sliderItem.minimumValueAccessory = nil
            sliderItem.maximumValueAccessory = nil
        }
    }
    
    @objc
    func sliderValueChanged(_ sender: Any) {
        if let sliderItem = sender as? NSSliderTouchBarItem {
            feedbackLabel.stringValue = String(format: NSLocalizedString("Slider Value", comment:""), sliderItem.slider.intValue)
        }
    }
    
}

