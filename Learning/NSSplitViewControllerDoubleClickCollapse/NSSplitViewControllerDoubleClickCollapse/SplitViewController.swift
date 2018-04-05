//
//  SplitViewController.swift
//  NSSplitViewControllerDoubleClickCollapse
//
//  Created by 戴植锐 on 2018/3/10.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class SplitViewController: NSSplitViewController {

    var isLeftCollapsed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置分割条样式
        self.splitView.dividerStyle = .paneSplitter
        NotificationCenter.default.addObserver(self, selector: #selector(self.toggleLeftView(_:)), name: NSNotification.Name.onOpenCloseView, object: nil)
    }
    
    @objc func toggleLeftView(_ aNotification: Notification) {
        /*
        if isLeftCollapsed {
            self.expandLeftView()
            self.isLeftCollapsed = false
        }
        else {
            self.collapsedLeftView()
            self.isLeftCollapsed = true
        }*/
        let isCollapsed = self.splitViewItems.first!.animator().isCollapsed
        self.splitViewItems.first!.animator().isCollapsed = !isCollapsed
    }
    
    func expandLeftView() {
        let leftView = self.splitView.subviews[0]
        let rightView = self.splitView.subviews[1]
        leftView.isHidden = false
        
        let dividerThickness = self.splitView.dividerThickness
        
        let leftFrame = leftView.frame
        var rightFrame = rightView.frame
        
        // 右边视图frame恢复到之前的大小
        rightFrame.size.width = rightFrame.size.width - leftFrame.size.width - dividerThickness
        rightView.frame = rightFrame
        // 重新刷新显示
        self.splitView.display()
    }
    
    func collapsedLeftView() {
        let leftView = self.splitView.subviews[0]
        let rightView = self.splitView.subviews[1]
        leftView.isHidden = true
        
        var frame = rightView.frame
        frame.size = self.splitView.frame.size
        // 右边视图frame占据整个splitView的大小
        rightView.frame = frame
        // 重新刷新显示
        self.splitView.display()
    }
}
