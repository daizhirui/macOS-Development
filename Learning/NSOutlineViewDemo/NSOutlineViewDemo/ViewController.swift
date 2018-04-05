//
//  ViewController.swift
//  NSOutlineViewDemo
//
//  Created by 戴植锐 on 2018/3/7.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var treeView: NSOutlineView!
    var treeModel: TreeNodeModel = TreeNodeModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerWindowNotification()
        // 加载 outlineView 的数据
        self.configData()
        // Do any additional setup after loading the view.
        self.selectFirstTableNode()
        self.treeView.menu = self.outlineViewMenu
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func registerWindowNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.onActiveWindow(_:)), name: NSWindow.didBecomeKeyNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.onActiveWindow(_:)), name: NSWindow.didBecomeMainNotification, object: nil)
    }
    
    @objc func onActiveWindow(_ notification: Notification) {
        // 使 treeView 成为第一响应者
        let window = notification.object as! NSWindow
        if window == self.view.window {
            self.view.window?.makeFirstResponder(self.treeView)
            print("Become the first responder!")
        }
    }
    // 默认选中第二行
    func selectFirstTableNode() {
        let targetTableNode = self.treeView.item(atRow: 1)
        if targetTableNode == nil {
            return
        }
        let indexSet:IndexSet = [1]
        self.treeView.selectRowIndexes(indexSet, byExtendingSelection: false)
    }
    // 设置大纲视图的数据
    func configData() {
        
        let rootNode = TreeNodeModel()
        rootNode.name = "网易"
        
        let rootNode2 = TreeNodeModel()
        rootNode2.name = "腾讯"
        
        self.treeModel.childNodes.append(rootNode)
        self.treeModel.childNodes.append(rootNode2)
        
        let level11Node = TreeNodeModel()
        level11Node.name = "电商"
        
        let level12Node = TreeNodeModel()
        level12Node.name = "游戏"
        
        let level13Node = TreeNodeModel()
        level13Node.name = "音乐"
        
        rootNode.childNodes.append(level11Node)
        rootNode.childNodes.append(level12Node)
        rootNode.childNodes.append(level13Node)
        
        rootNode2.childNodes.append(level13Node)
        
        let level21Node = TreeNodeModel()
        level21Node.name = "研发"
        
        let level22Node = TreeNodeModel()
        level22Node.name = "营运"
        
        level11Node.childNodes.append(level21Node)
        level11Node.childNodes.append(level22Node)
        
        self.treeView.reloadData()
    }

    @IBOutlet weak var nodeNameTextField: NSTextField!
    // 增加节点操作
    @IBAction func addNodeAction(_ sender: AnyObject) {
        let nodeName = self.nodeNameTextField.stringValue
        // 没有输入节点名，返回
        if nodeName.count <= 0 {
            return
        }
        // 获取父节点
        let fatherNode: TreeNodeModel?
        let row = self.treeView.selectedRow
        // 没有节点被选中时，默认增加到根节点
        if row < 0 {
            fatherNode = self.treeModel
        }
        else {
            // 节点被选中，获取该节点对应的数据对象
            fatherNode = self.treeView.item(atRow: row) as? TreeNodeModel
        }
        // 创建子节点
        let childNode = TreeNodeModel()
        childNode.name = nodeName
        fatherNode?.childNodes.append(childNode)
        // 重新加载数据
        self.treeView.reloadData()
        // 增加节点操作完成，清空节点名称文本框
        self.nodeNameTextField.stringValue = ""
    }
    // 删除节点操作
    @IBAction func removeNodeAction(_ sender: AnyObject) {
        let row = self.treeView.selectedRow
        // 如果没有节点选中，返回
        if row < 0 {
            return
        }
        // 选中节点
        let node = self.treeView.item(atRow: row)
        // 选中节点的父节点
        let fatherNode = self.treeView.parent(forItem: node)
        // nil 表示为根节点，删除整个树
        if fatherNode == nil {
            self.treeModel = TreeNodeModel()
        }
        else {
            let model = node as! TreeNodeModel
            let fatherModel = fatherNode as! TreeNodeModel
            var index = 0
            for itemModel in fatherModel.childNodes {
                if itemModel.name == model.name {
                    fatherModel.childNodes.remove(at: index)
                    break
                }
                index += 1
            }
        }
        self.treeView.reloadData()
        // 删除节点操作完成，清空节点名称文本框
        self.nodeNameTextField.stringValue = ""
    }
    // 展开所有节点操作
    @IBAction func expandAllAction(_ sender: NSButton) {
        self.treeView.expandItem(nil, expandChildren: true)
    }
    // 收缩所有节点操作
    @IBAction func collapseAllAction(_ sender: NSButton) {
        self.treeView.collapseItem(nil, collapseChildren: true)
    }
    @IBOutlet var outlineViewMenu: NSMenu!
}

extension ViewController: NSOutlineViewDataSource {
    // 每个节点的子节点数
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        let node: TreeNodeModel
        if item != nil {
            node = item as! TreeNodeModel
        }
        else {
            node = self.treeModel
            NSLog(
                """
                WARNNING: item in NSOutlineViewDataSource.outlineView(_:numberOfChildrenofItem:) is nil !
                The name of the node is \(String(describing: node.name)).
                The name of the first childnode is \(String(describing: node.childNodes.count > 0 ? node.childNodes[0].name : "NONE")).
                """
            )
        }
        return node.childNodes.count
    }
    // 返回节点的子节点代表的数据对象
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        let node: TreeNodeModel
        if item != nil {
            node = item as! TreeNodeModel
        }
        else {
            node = self.treeModel
            NSLog(
                """
                WARNNING: item in NSOutlineViewDataSource.outlineView(_:numberOfChildrenofItem:) is nil !
                The name of the node is \(String(describing: node.name)).
                The name of the first childnode is \(String(describing: node.childNodes[0].name)).
                """
            )
        }
        return node.childNodes[index]
    }
    // 节点是否可以展开
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        let node: TreeNodeModel = item as! TreeNodeModel
        return node.childNodes.count > 0
    }
    
}

extension ViewController: NSOutlineViewDelegate {
    // 根据节点数据构造返回节点视图
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        // 获取节点对应的 OutlineView
        let view = outlineView.makeView(withIdentifier: (tableColumn?.identifier)!, owner: self)
        // 获取节点的 OutlineView 的子 View 的数组：图标，文字标签等
        let subviews = view?.subviews
        // 获取项目的图标
        let imageView = subviews?[0] as! NSImageView
        // 获取项目的文字标签
        let field = subviews?[1] as! NSTextField
        // 获取本节点对应的节点模型数据对象
        let model = item as! TreeNodeModel
        // 对项目的文字标签赋值
        field.stringValue = model.name!
        // 对项目的图标赋值
        if model.childNodes.count > 0 {
            // 存在子节点，图标设置为 folder
            imageView.image = NSImage(named: NSImage.Name.folder)
        }
        else {
            // 没有子节点，图标设置为 list
            imageView.image = NSImage(named: NSImage.Name.listViewTemplate)
        }
        return view
    }
    // 返回⼤纲控件中每⾏的⾼度
    func outlineView(_ outlineView: NSOutlineView, heightOfRowByItem item: Any) -> CGFloat {
        return 40
    }
    // 获取到选择节点后的通知
    func outlineViewSelectionDidChange(_ notification: Notification) {
        let treeView = notification.object as! NSOutlineView
        let row = treeView.selectedRow
        let model = treeView.item(atRow: row) as! TreeNodeModel
        print("model: " + (model.name)!)
    }
}
