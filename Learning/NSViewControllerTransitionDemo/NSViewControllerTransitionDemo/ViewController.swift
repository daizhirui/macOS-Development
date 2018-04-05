//
//  ViewController.swift
//  NSViewControllerTransitionDemo
//
//  Created by 戴植锐 on 2018/3/9.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    lazy var presentVC: NSViewController = {
        let sceneIdentifier = NSStoryboard.SceneIdentifier(rawValue: "PresentVC")
        let presentVC = self.storyboard?.instantiateController(withIdentifier: sceneIdentifier) as? NSViewController
        return presentVC!
    }()
    
    lazy var anotherPresentVC: NSViewController = {
        let sceneIdentifier = NSStoryboard.SceneIdentifier(rawValue: "AnotherPresentVC")
        let presentVC = self.storyboard?.instantiateController(withIdentifier: sceneIdentifier) as? NSViewController
        return presentVC!
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addChildViewController(presentVC)
        self.addChildViewController(anotherPresentVC)
        // Do any additional setup after loading the view.
        // 创建手势类
        let gr = NSMagnificationGestureRecognizer(target: self, action: #selector(ViewController.magnify(_:)))
        // 视图增加手势识别
        self.view.addGestureRecognizer(gr)
        gr.delegate = self
        self.view.window?.makeKeyAndOrderFront(self)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func presentAsModalAction(_ sender: NSButton) {
        let sceneIdentifier = NSStoryboard.SceneIdentifier(rawValue: "PresentVC")
        let presentVC = self.storyboard?.instantiateController(withIdentifier: sceneIdentifier) as? NSViewController
        self.presentViewControllerAsModalWindow(presentVC!)
    }
    // sheet transition
    @IBAction func presentAsSheetAction(_ sender: NSButton) {
        let sceneIdentifier = NSStoryboard.SceneIdentifier(rawValue: "PresentVC")
        let presentVC = self.storyboard?.instantiateController(withIdentifier: sceneIdentifier) as? NSViewController
        self.presentViewControllerAsSheet(presentVC!)
    }
    // popover transition
    @IBAction func presentAsPopoverAction(_ sender: NSButton) {
        let sceneIdentifier = NSStoryboard.SceneIdentifier(rawValue: "PresentVC")
        let presentVC = self.storyboard?.instantiateController(withIdentifier: sceneIdentifier) as? NSViewController
        self.presentViewController(presentVC!, asPopoverRelativeTo: sender.frame, of: sender.superview!, preferredEdge: .maxY, behavior: .transient)
    }
    // animator transition 渐变动画切换
    @IBAction func presentAsAnimatorAction(_ sender: NSButton) {
        let sceneIdentifier = NSStoryboard.SceneIdentifier(rawValue: "PresentVC")
        let presentVC = self.storyboard?.instantiateController(withIdentifier: sceneIdentifier) as? NSViewController
        let animator = PresentCustomAnimator()
        self.presentViewController(presentVC!, animator: animator)
    }
    @IBAction func showViewAsWindow(_ sender: NSButton) {
        self.presentViewControllerAsModalWindow(presentVC)
        NSApplication.shared.stopModal()
        
    }
    // 在子视图控制器之间切换
    @IBOutlet weak var subView: NSView!
    var currentSubViewName: String!
    @IBAction func showChildViewControllerViewAction(_ sender: NSButton) {
        // 显示 presentVC 视图
        self.subView.addSubview(self.presentVC.view)
        //autolayout 约束
        let topAnchor = self.presentVC.view.topAnchor.constraint(equalTo: self.subView.topAnchor, constant: 0)
        let bottomAnchor = self.presentVC.view.bottomAnchor.constraint(equalTo: self.subView.bottomAnchor, constant: 0)
        let leadingAnchor = self.presentVC.view.leadingAnchor.constraint(equalTo: self.subView.leadingAnchor, constant: 0)
        let trailingAnchor = self.presentVC.view.trailingAnchor.constraint(equalTo: self.subView.trailingAnchor, constant: 0)
        NSLayoutConstraint.activate([topAnchor, bottomAnchor, leadingAnchor, trailingAnchor])
        self.currentSubViewName = "PresentVC"
    }
    @IBAction func transitionAction(_ sender: NSButton) {
        // 需要判断当前的视图是哪一个
        if self.currentSubViewName == "PresentVC" {
            // 再次显示 presentVC 视图
            self.subView.addSubview(self.presentVC.view)
            //autolayout 约束
            let topAnchor = self.presentVC.view.topAnchor.constraint(equalTo: self.subView.topAnchor, constant: 0)
            let bottomAnchor = self.presentVC.view.bottomAnchor.constraint(equalTo: self.subView.bottomAnchor, constant: 0)
            let leadingAnchor = self.presentVC.view.leadingAnchor.constraint(equalTo: self.subView.leadingAnchor, constant: 0)
            let trailingAnchor = self.presentVC.view.trailingAnchor.constraint(equalTo: self.subView.trailingAnchor, constant: 0)
            NSLayoutConstraint.activate([topAnchor, bottomAnchor, leadingAnchor, trailingAnchor])
            // 从 presentVC 视图切换到另外一个 anotherPresentVC 视图
            self.transition(from: presentVC, to: anotherPresentVC, options: NSViewController.TransitionOptions.crossfade, completionHandler: nil)
            self.currentSubViewName = "AnotherPresentVC"
        }
        else {
            // 再次显示 anotherPresentVC 视图
            self.subView.addSubview(anotherPresentVC.view)
            //autolayout 约束
            let topAnchor = self.anotherPresentVC.view.topAnchor.constraint(equalTo: self.subView.topAnchor, constant: 0)
            let bottomAnchor = self.anotherPresentVC.view.bottomAnchor.constraint(equalTo: self.subView.bottomAnchor, constant: 0)
            let leadingAnchor = self.anotherPresentVC.view.leadingAnchor.constraint(equalTo: self.subView.leadingAnchor, constant: 0)
            let trailingAnchor = self.anotherPresentVC.view.trailingAnchor.constraint(equalTo: self.subView.trailingAnchor, constant: 0)
            NSLayoutConstraint.activate([topAnchor, bottomAnchor, leadingAnchor, trailingAnchor])
            self.transition(from: anotherPresentVC, to: presentVC, options: NSViewController.TransitionOptions.crossfade, completionHandler: nil)
            self.currentSubViewName = "PresentVC"
        }
    }
}

extension ViewController: NSGestureRecognizerDelegate {
    @objc func magnify(_ sender: NSMagnificationGestureRecognizer) {
        switch sender.state {
        case .began: print("ClickGesture began")
        case .changed: print("ClickGesture changed")
        case .ended: print("ClickGesture ended")
        case .cancelled: print("ClickGesture cancelled")
        default: break
        }
    }
}
