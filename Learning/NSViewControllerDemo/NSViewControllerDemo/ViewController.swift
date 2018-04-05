//
//  ViewController.swift
//  NSViewControllerDemo
//
//  Created by 戴植锐 on 2018/3/9.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var mainView: NSView!
    
    var currentController: NSViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initiateControllers()
        self.changeViewController(0)
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    // 初始化并添加子视图控制器
    func initiateControllers() {
        let vc1 = self.storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "FirstVC")) as! NSViewController
        let vc2 = self.storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "SecondVC")) as! NSViewController
        self.addChildViewController(vc1)
        self.addChildViewController(vc2)
    }
    
    func changeViewController(_ index: NSInteger) {
        if self.currentController != nil {
            // 移除当前视图
            self.currentController?.view.removeFromSuperview()
        }
        // 数组越界保护
        guard index >= 0 && index <= self.childViewControllers.count - 1 else {
            return
        }
        // 获取并添加子视图
        self.currentController = self.childViewControllers[index]
        self.mainView.addSubview((self.currentController?.view)!)
        // autoLayout 约束
        let topAnchor = self.currentController?.view.topAnchor.constraint(equalTo: self.mainView.topAnchor, constant: 0)
        let bottomAnchor = self.currentController?.view.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor, constant: 0)
        let leadingAnchor = self.currentController?.view.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor, constant: 0)
        let trailingAnchor = self.currentController?.view.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor, constant: 0)
        NSLayoutConstraint.activate([topAnchor!, bottomAnchor!, leadingAnchor!, trailingAnchor!])
    }

    @IBAction func selectonChangedAction(_ sender: NSSegmentedControl) {
        let selectedIndex = sender.selectedSegment
        print(selectedIndex)
        self.changeViewController(selectedIndex)
    }
    
}

