//
//  ViewController.swift
//  NSSplitViewDemo
//
//  Created by 戴植锐 on 2018/3/4.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    var vSplitView: NSSplitView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createVSplitView()
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func createVSplitView() {
        let frame = CGRect(x: 20, y: 50, width: 300, height: 200)
        vSplitView = NSSplitView(frame: frame)
        vSplitView.isVertical = true
        vSplitView.delegate = self
        vSplitView.dividerStyle = .thick
        
        let lframe = CGRect(x: 0, y: 0, width: 30, height: 200)
        let leftView = NSView(frame: lframe)
        leftView.wantsLayer = true
        leftView.layer?.backgroundColor = NSColor.green.cgColor
        
        let rframe = CGRect(x: 0, y: 0, width: 300, height: 200)
        let rightView = NSView(frame: rframe)
        rightView.wantsLayer = true
        rightView.layer?.backgroundColor = NSColor.red.cgColor
        
        vSplitView.addSubview(leftView)
        vSplitView.addSubview(rightView)
        
        self.view.addSubview(vSplitView)
        
        vSplitView.setPosition(60, ofDividerAt: 0)
    }

    var leftViewWidth: CGFloat = 0
    @IBAction func togglePanel(_ sender: NSButton) {
        let splitViewItem = vSplitView.arrangedSubviews
        // 获取左边子视图
        let leftView = splitViewItem[0]
        // 判断左边子视图是否已经隐藏
        if vSplitView.isSubviewCollapsed(leftView) {
            // 分栏左视图已经被隐藏，还原
            self.vSplitView.setPosition(self.leftViewWidth, ofDividerAt: 0)
            leftView.isHidden = false
        } else {
            // 分栏左视图未被隐藏，隐藏
            self.leftViewWidth = leftView.frame.size.width
            self.vSplitView.setPosition(0, ofDividerAt: 0)
            leftView.isHidden = true
        }
        self.vSplitView.adjustSubviews()
    }
}

extension ViewController: NSSplitViewDelegate {
    
    func splitView(_ splitView: NSSplitView, canCollapseSubview subview: NSView) -> Bool {
        if subview == vSplitView.subviews[0] {
            return true
        }
        return false
    }
    
    func splitView(_ splitView: NSSplitView, constrainMinCoordinate proposedMinimumPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
        return 30
    }
    
    func splitView(_ splitView: NSSplitView, constrainMaxCoordinate proposedMaximumPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
        return 100
    }
    
    func splitView(_ splitView: NSSplitView, shouldAdjustSizeOfSubview view: NSView) -> Bool {
        return true
    }
    
    func splitView(_ splitView: NSSplitView, shouldHideDividerAt dividerIndex: Int) -> Bool {
        return true
    }
}

