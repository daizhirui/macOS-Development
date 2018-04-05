//
//  PresentCustomAnimator.swift
//  NSViewControllerTransitionDemo
//
//  Created by 戴植锐 on 2018/3/9.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class PresentCustomAnimator: NSObject, NSViewControllerPresentationAnimator {
    func animatePresentation(of viewController: NSViewController, from fromViewController: NSViewController) {
        // 原来的视图的控制器
        let bottomVC = fromViewController
        // 新的视图的控制器
        let topVC = viewController
        // 设置新图层
        topVC.view.wantsLayer = true
        topVC.view.alphaValue = 0
        // 显示新视图
        bottomVC.view.addSubview(topVC.view)
        // 设置图层颜色
        topVC.view.layer?.backgroundColor = NSColor.gray.cgColor
        // 执行渐变动画
        NSAnimationContext.runAnimationGroup({context in
            context.duration = 0.5
            topVC.view.animator().alphaValue = 1
        }, completionHandler: nil)
    }
    
    func animateDismissal(of viewController: NSViewController, from fromViewController: NSViewController) {
        // 需要去除的视图的控制器
        let topVC = viewController
        // 执行渐变动画
        NSAnimationContext.runAnimationGroup({context in
            context.duration = 0.5
            topVC.view.animator().alphaValue = 0
        }, completionHandler: { topVC.view.removeFromSuperview() })
    }
}
