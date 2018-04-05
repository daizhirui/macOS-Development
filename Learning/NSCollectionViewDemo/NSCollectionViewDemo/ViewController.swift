//
//  ViewController.swift
//  NSCollectionViewDemo
//
//  Created by 戴植锐 on 2018/3/4.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var collectionView: NSCollectionView!
    var content = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let itemProtoType = self.storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "collectionViewItem")) as! NSCollectionViewItem
        self.collectionView.itemPrototype = itemProtoType
        self.updateContent()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func updateContent() {
        let item1: NSDictionary = ["title": "computer", "image": NSImage(named: NSImage.Name.computer)!]
        let item2: NSDictionary = ["title": "folder", "image": NSImage(named: NSImage.Name.folder)!]
        let item3: NSDictionary = ["title": "home", "image": NSImage(named: NSImage.Name.homeTemplate)!]
        let item4: NSDictionary = ["title": "list", "image": NSImage(named: NSImage.Name.listViewTemplate)!]
        let item5: NSDictionary = ["title": "network", "image": NSImage(named: NSImage.Name.network)!]
        let item6: NSDictionary = ["title": "share", "image": NSImage(named: NSImage.Name.shareTemplate)!]
        
        self.content.append(item1)
        self.content.append(item2)
        self.content.append(item3)
        self.content.append(item4)
        self.content.append(item5)
        self.content.append(item6)
        
        self.collectionView.content = self.content
    }

}

