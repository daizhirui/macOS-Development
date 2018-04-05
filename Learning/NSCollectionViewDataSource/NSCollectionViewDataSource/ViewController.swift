//
//  ViewController.swift
//  NSCollectionViewDataSource
//
//  Created by 戴植锐 on 2018/3/4.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

extension NSUserInterfaceItemIdentifier {
    static let collectionViewItem = NSUserInterfaceItemIdentifier("CollectionViewItem")
    static let headerViewItem = NSUserInterfaceItemIdentifier("HeaderView")
    static let footerViewItem = NSUserInterfaceItemIdentifier("FooterView")
}

class ViewController: NSViewController {
    
    @IBOutlet weak var collectionView: NSCollectionView!
    
    var content = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.collectionView.collectionViewLayout = NSCollectionViewFlowLayout()
        
        self.collectionView.register(CollectionViewItem.self, forItemWithIdentifier: .collectionViewItem)
        self.collectionView.register(HeaderView.self, forItemWithIdentifier: .headerViewItem)
        self.collectionView.register(FooterView.self, forItemWithIdentifier: .footerViewItem)
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.updateData()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func updateData() {
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
        
        self.collectionView.reloadData()
    }
}
// 实现 dataSource 的协议方法
extension ViewController: NSCollectionViewDataSource {
    // 返回每个 section 的单元格数
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return content.count
    }
    // 创建 CollectionViewItem 实例，配置数据模型到 representedObject
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        let item = collectionView.makeItem(withIdentifier: .collectionViewItem, for: indexPath)
        let itemIndex = (indexPath as NSIndexPath).item
        item.representedObject = content[itemIndex]
        return item
    }
    // 返回 section 的个数
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 2
    }
    // 设置 Collection View 的 Header 和 Footer
    func collectionView(_ collectionView: NSCollectionView, viewForSupplementaryElementOfKind kind: NSCollectionView.SupplementaryElementKind, at indexPath: IndexPath) -> NSView {
        
        if kind == NSCollectionView.SupplementaryElementKind.sectionHeader {
            let view = self.collectionView.makeSupplementaryView(ofKind: NSCollectionView.SupplementaryElementKind.sectionHeader, withIdentifier: .headerViewItem, for: indexPath)
            return view
        }
        
        if kind == NSCollectionView.SupplementaryElementKind.sectionFooter {
            let view = self.collectionView.makeSupplementaryView(ofKind: NSCollectionView.SupplementaryElementKind.sectionFooter, withIdentifier: .footerViewItem, for: indexPath)
            return view
        }
        
        return NSView()
    }
}

extension ViewController: NSCollectionViewDelegate {
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        print(indexPaths)
    }
}

// NSCollectionViewDelegateFlowLayout 继承自 NSCollectionViewDelegate，下面方法配置了每个单元格的大小 Size
extension ViewController: NSCollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        return NSSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> NSSize {
        return NSSize(width: self.collectionView.frame.size.width, height: 30)
    }
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, referenceSizeForFooterInSection section: Int) -> NSSize {
        return NSSize(width: self.collectionView.frame.size.width, height: 60)
    }
}
