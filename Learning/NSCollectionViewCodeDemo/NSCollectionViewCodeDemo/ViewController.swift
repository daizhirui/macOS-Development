//
//  ViewController.swift
//  NSCollectionViewCodeDemo
//
//  Created by 戴植锐 on 2018/3/5.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

extension NSUserInterfaceItemIdentifier {
    static let collectionViewItem = NSUserInterfaceItemIdentifier("CollectionViewItem")
}

class ViewController: NSViewController {
    
    var content = [NSDictionary]()

    lazy var scrollView: NSScrollView = {
        let scrollView = NSScrollView()
        scrollView.focusRingType = .none
        scrollView.autohidesScrollers = true
        scrollView.borderType = .noBorder
        scrollView.documentView = self.collectionView
        return scrollView
    }()
    
    lazy var collectionView: NSCollectionView = {
        let view = NSCollectionView()
        view.isSelectable = true
        view.delegate = self
        view.dataSource = self
        view.collectionViewLayout = self.flowLayout // Layout
        view.register(CollectionViewItem.self, forItemWithIdentifier: .collectionViewItem)
        //view.backgroundColors[0] = NSColor.red
        return view
    }()
    
    var sectionInset: NSEdgeInsets = NSEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    lazy var flowLayout: NSCollectionViewFlowLayout = {
        let layout = NSCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = NSSize(width: 40, height: 40)
        layout.sectionInset = self.sectionInset
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        return layout
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.scrollView.frame = self.view.bounds
        self.view.addSubview(scrollView)
        self.updateContent()
        
        //let dd = NSCollectionViewGridLayout()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    //let gridLayout = NSCollectionViewGridLayout()
    
    func updateContent(){
        
        let item1: NSDictionary = ["title" : "computer","image" : NSImage(named: NSImage.Name.computer)!]
        let item2: NSDictionary = ["title" : "folder","image" : NSImage(named: NSImage.Name.folder)!]
        let item3: NSDictionary = ["title" : "home","image" : NSImage(named: NSImage.Name.homeTemplate)!]
        let item4: NSDictionary = ["title" : "list","image" : NSImage(named: NSImage.Name.listViewTemplate)!]
        let item5: NSDictionary = ["title" : "network","image" : NSImage(named: NSImage.Name.network)!]
        let item6: NSDictionary = ["title" : "share","image" : NSImage(named: NSImage.Name.shareTemplate)!]
        
        content.append(item1)
        content.append(item2)
        content.append(item3)
        content.append(item4)
        content.append(item5)
        content.append(item6)
        
        self.collectionView.reloadData()
    }
}

extension ViewController: NSCollectionViewDataSource {
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return content.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        //let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "CollectionViewItem"), for: indexPath)
        
        let item = collectionView.makeItem(withIdentifier: .collectionViewItem, for: indexPath)
        
        let itemIndex = (indexPath as NSIndexPath).item
        item.representedObject = content[itemIndex]
        return item
    }
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
}

extension ViewController: NSCollectionViewDelegate {
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        
        print(indexPaths)
        // 设置选中项的背景
        let indexPath = indexPaths.first!
        let item = collectionView.item(at: indexPath)! as! CollectionViewItem
        item.collImageView.layer?.cornerRadius = 10
        item.collImageView.layer?.backgroundColor = NSColor.selectedTextBackgroundColor.cgColor
        item.titleField.layer?.cornerRadius = 5
        item.titleField.layer?.backgroundColor = NSColor.selectedTextBackgroundColor.cgColor
    }
    
    func collectionView(_ collectionView: NSCollectionView, didDeselectItemsAt indexPaths: Set<IndexPath>) {
        // 取消选中项的背景色
        let indexPath = indexPaths.first!
        let item = collectionView.item(at: indexPath)! as! CollectionViewItem
        item.collImageView.layer?.backgroundColor = NSColor.white.cgColor
        item.titleField.layer?.backgroundColor = NSColor.white.cgColor
    }
}

extension ViewController: NSCollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        return NSSize(width: 100, height: 100)
    }
}
