//
//  WindowController.swift
//  NSToolbarCodeDemo
//
//  Created by 戴植锐 on 2018/3/7.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

extension NSToolbar.Identifier {
    public static let AppToolbar: NSToolbar.Identifier = NSToolbar.Identifier("AppToolbar")
}

extension NSToolbarItem.Identifier {
    public static let FontSetting: NSToolbarItem.Identifier = NSToolbarItem.Identifier("FontSetting")
    public static let Save: NSToolbarItem.Identifier = NSToolbarItem.Identifier("Save")
}

extension NSImage.Name {
    public static let FontSetting: NSImage.Name = NSImage.Name("FontSetting")
    public static let Save: NSImage.Name = NSImage.Name("Save")
}

class WindowController: NSWindowController {
    
    @IBOutlet weak var toolBar: NSToolbar!
    
    override func windowDidLoad() {
        super.windowDidLoad()
        self.setUpToolbar()
        // 使 Window 和 Toolbar 融合
        self.window?.titleVisibility = .hidden
        // 设置窗口样式
        self.window?.styleMask = [.unifiedTitleAndToolbar, .closable, .resizable, .miniaturizable, .titled]
    }
    
    func setUpToolbar() {
        let toolbar = NSToolbar(identifier: NSToolbar.Identifier.AppToolbar)
        toolbar.allowsUserCustomization = false
        toolbar.autosavesConfiguration = false
        toolbar.displayMode = .iconAndLabel
        toolbar.delegate = self
        self.window?.toolbar = toolbar
    }
    
}

extension WindowController: NSToolbarDelegate {
    // 实际显示的 item 标识
    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [NSToolbarItem.Identifier.FontSetting, NSToolbarItem.Identifier.Save]
    }
    // 所有的 item 标识，在编辑模式下会显示出所有的 item
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [NSToolbarItem.Identifier.FontSetting, NSToolbarItem.Identifier.Save]
    }
    // 根据 item 标识，返回每个具体的 NSToolbarItem 对象实例
    func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        let toolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
        if itemIdentifier == NSToolbarItem.Identifier.FontSetting {
            toolbarItem.label = "Font"
            toolbarItem.paletteLabel = "Font"
            toolbarItem.toolTip = "Font Setting"
            toolbarItem.image = NSImage.init(named: NSImage.Name.FontSetting)
            toolbarItem.tag = 1
        }
        if itemIdentifier == NSToolbarItem.Identifier.Save {
            toolbarItem.label = "Save"
            toolbarItem.paletteLabel = "Save"
            toolbarItem.toolTip = "Save File"
            toolbarItem.image = NSImage.init(named: NSImage.Name.Save)
            toolbarItem.tag = 2
        }
        
        toolbarItem.minSize = NSSize(width: 25, height: 25)
        toolbarItem.maxSize = NSSize(width: 100, height: 100)
        toolbarItem.target = self
        toolbarItem.action = #selector(WindowController.toolbarItemClicked(_:))
        return toolbarItem
    }
    @objc func toolbarItemClicked(_ sender: NSToolbarItem) {
        let tag = sender.tag
        print(tag)
    }
}
