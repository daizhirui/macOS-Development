//
//  AppDelegate.swift
//  Label
//
//  Created by 戴植锐 on 2018/3/3.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSTextFieldDelegate {

    @IBOutlet weak var window: NSWindow!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        self.addLabel()
        self.addRichableLabel()
        //self.addRichableLabel2()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func addLabel() {
        let frame = CGRect(x: 10, y: 10, width: 80, height: 24)
        let label = NSTextField(frame: frame)
        label.isEditable = false
        label.isBezeled = false
        label.drawsBackground = false
        label.stringValue = "Name Label"
        self.window.contentView?.addSubview(label)
    }
    
    func addRichableLabel() {
        let text = NSString(string: "please visit http://www.apple.com/")
        let attributedString = NSMutableAttributedString(string: text as String)
        let linkURLText = "http://www.apple.com/"
        let linkURL = NSURL(string: linkURLText)
        // search string selected range
        let selectedRange = text.range(of: linkURLText)
        
        attributedString.beginEditing()
        // set the link
        attributedString.addAttribute(NSAttributedStringKey.link, value: linkURL!, range: selectedRange)
        // set the font color
        attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: NSColor.blue, range: selectedRange)
        // set the underline
        attributedString.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: selectedRange)
        // show the pointing hand when the cursor is close to the link
        attributedString.addAttribute(NSAttributedStringKey.cursor, value: NSCursor.pointingHand, range: selectedRange)
        attributedString.endEditing()
        
        let frame = CGRect(x: 50, y: 50, width: 280, height: 80)
        let richTextLabel = NSTextView(frame: frame)    // 修改 NSTextField 为 NSTextView
        richTextLabel.isEditable = false
        //richTextLabel.isBezeled = false                           // for NSTextField
        richTextLabel.drawsBackground = false
        //richTextLabel.attributedStringValue = attributedString    // for NSTextField
        richTextLabel.textStorage?.setAttributedString(attributedString)
        //richTextLabel.target = self
        //richTextLabel.action = #selector(openLinkAction(_:))
        
        self.window.contentView?.addSubview(richTextLabel)
        
    }
    
}

