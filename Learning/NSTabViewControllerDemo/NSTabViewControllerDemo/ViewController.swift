//
//  ViewController.swift
//  NSTabViewControllerDemo
//
//  Created by 戴植锐 on 2018/3/9.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var tabView: NSTabView!
    let vc1 = FirstViewController()
    let vc2 = SecondViewController()
    override func viewDidLoad() {
        super.viewDidLoad()

        let tabItems = self.tabView.tabViewItems
        let vcs = [self.vc1, self.vc2]
        var index = 0
        for item in tabItems {
            let vc = vcs[index]
            item.view?.addSubview(vc.view)
            vc.view.frame = item.view!.bounds
            index += 1
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateViewFrame(_:)), name: NSWindow.didResizeNotification, object: nil)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    // 更新每个 tab 的视图的 frame
    @objc func updateViewFrame(_ aNotification: Notification) {
        let tabItems = self.tabView.tabViewItems
        vc1.view.frame = tabItems[0].view!.bounds
        vc2.view.frame = tabItems[1].view!.bounds
    }
}

