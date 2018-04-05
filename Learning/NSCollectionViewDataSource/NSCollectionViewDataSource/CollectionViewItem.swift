//
//  CollectionViewItem.swift
//  NSCollectionViewDataSource
//
//  Created by 戴植锐 on 2018/3/5.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class CollectionViewItem: NSCollectionViewItem {
    
    @IBOutlet weak var collImageView: NSImageView!
    @IBOutlet weak var titleField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var isSelected: Bool {
        didSet {
            (self.view as! CollectionItemView).selected = isSelected
        }
    }
    
    override var highlightState: NSCollectionViewItem.HighlightState {
        didSet {
            (self.view as! CollectionItemView).highlightState = highlightState
        }
    }
    
    
    override var representedObject: Any? {
        didSet {
            
            let data = self.representedObject as! NSDictionary
            
            if let image = data["image"] as? NSImage {
                self.collImageView.image    = image
            }
            if let title = (data["title"] as? String) {
                self.titleField.stringValue = title
            }
        }
    }
    
}

