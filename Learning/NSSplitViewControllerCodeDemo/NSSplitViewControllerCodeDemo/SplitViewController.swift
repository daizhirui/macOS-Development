//
//  SplitViewController.swift
//  NSSplitViewControllerCodeDemo
//
//  Created by 戴植锐 on 2018/3/9.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class SplitViewController: NSSplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let item1 = NSSplitViewItem()
        item1.viewController = SubViewController()
        item1.canCollapse = true
        item1.holdingPriority = NSLayoutConstraint.Priority(rawValue: 250)
        
        let item2 = NSSplitViewItem()
        item2.viewController = SubViewController()
        item2.canCollapse = true
        item2.holdingPriority = NSLayoutConstraint.Priority(rawValue: 270)
        // ⽔平⽅向
        self.splitView.isVertical = true
        // 增加NSSplitViewItem
        self.addSplitViewItem(item1)
        self.addSplitViewItem(item2)
        // 左边视图宽度>200,<300
        let item1WidthGreaterThanOrEqualAnchor = item1.viewController.view.widthAnchor.constraint(greaterThanOrEqualToConstant: 200)
        let item1WidthLessThanOrEqualAnchor = item1.viewController.view.widthAnchor.constraint(lessThanOrEqualToConstant: 300)
        // 右边视图宽度>100,<800
        let item2WidthGreaterThanOrEqualAnchor = item2.viewController.view.widthAnchor.constraint(greaterThanOrEqualToConstant: 100)
        let item2WidthLessThanOrEqualAnchor = item2.viewController.view.widthAnchor.constraint(lessThanOrEqualToConstant: 800)
        // 激活约束条件
        NSLayoutConstraint.activate([item1WidthGreaterThanOrEqualAnchor, item1WidthLessThanOrEqualAnchor, item2WidthGreaterThanOrEqualAnchor, item2WidthLessThanOrEqualAnchor])
    }
}
