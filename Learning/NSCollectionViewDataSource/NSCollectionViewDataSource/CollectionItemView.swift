//
//  CollectionItemView.swift
//  NSCollectionViewDataSource
//
//  Created by 戴植锐 on 2018/3/5.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class CollectionItemView: NSView {
    
    @IBOutlet weak var imageView: NSImageView!
    @IBOutlet weak var label: NSTextField!
    // MARK: Properties
    
    var selected: Bool = false {
        didSet {
            if selected != oldValue {
                needsDisplay = true
            }
        }
    }
    
    var highlightState: NSCollectionViewItem.HighlightState = .none {
        didSet {
            if highlightState != oldValue {
                needsDisplay = true
            }
        }
    }
    
    // MARK: Layer
    
    override var wantsUpdateLayer: Bool {
        return true
    }
    
    override func updateLayer() {
        if selected {
            //self.layer?.cornerRadius = 10
            // 高亮选中项边框
            layer!.borderColor = NSColor.blue.cgColor
            layer!.borderWidth = 2
            // 高亮选中项的背景
            imageView.layer?.cornerRadius = 5
            imageView.layer?.backgroundColor = NSColor.lightGray.cgColor
            label.layer?.cornerRadius = 3
            label.layer?.backgroundColor = NSColor.selectedTextBackgroundColor.cgColor
        } else {
            // 取消边框高亮
            //self.layer?.cornerRadius = 0
            layer!.borderColor = NSColor.white.cgColor
            layer!.borderWidth = 0
            // 取消背景高亮
            imageView.layer?.backgroundColor = NSColor.white.cgColor
            label.layer?.backgroundColor = NSColor.white.cgColor
        }
    }
    
    
    // MARK: Init
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        wantsLayer = true
        layer?.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        wantsLayer = true
        layer?.masksToBounds = true
    }
    
}

