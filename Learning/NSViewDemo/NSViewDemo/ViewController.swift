//
//  ViewController.swift
//  NSViewDemo
//
//  Created by 戴植锐 on 2017/12/26.
//  Copyright © 2017年 戴植锐. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        /*
        // 1.创建NSView
        let redView = NSView()
        // 2.创建视图的frame
        redView.frame = NSMakeRect(50, 50, 50, 50)
        // 3.将redView添加到父NSView
        view.addSubview(redView)
        // 4.设置redView的背景色
            // 4.1 启用redView的layer
        redView.wantsLayer = true
            // 4.2 设置redView.layer 的颜色
        redView.layer?.backgroundColor = NSColor.red.cgColor */
        
        
    }
    /*
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }*/

/** NSView的常用属性
     坐标系统的原点位于左下角（与平时的习惯是一样的）。
     1. frame: 该view在父view坐标系中的位置和大小（参照点：父view的坐标系统）
     
     2. bounds: 该view在本地坐标系统的位置和大小（参照点：本view的坐标系统）
     
     3. layer：图层
        与iOS不同，默认的macOS，NSView没有Background这个属性，如何设置呢？
     可以把颜色设置给NSView的layer，详见代码。
     
     (Old messages:
        3.1 backed-layer
            addSubview 在设置 layer 的语句之后。
        3.2 hosting-layer
            addSubview 在设置 layer 的语句之前。
     )
 */

}

