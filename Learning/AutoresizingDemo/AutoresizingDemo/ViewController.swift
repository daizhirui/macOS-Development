//
//  ViewController.swift
//  AutoresizingDemo
//
//  Created by 戴植锐 on 2017/12/21.
//  Copyright © 2017年 戴植锐. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var BlueBox: NSBox!  // BlueBox
    @IBOutlet weak var RedBox: NSBox!   // RedBox
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1. 关闭autosizing的约束
        BlueBox.translatesAutoresizingMaskIntoConstraints=false
        // 2.设置BlueBox的约束条件
        // 使用NSLayoutAnchor
        let  BlueBoxCons = [
            // BlueBox 距离父视图的顶部20个单位
            BlueBox.topAnchor.constraint(equalTo: view.topAnchor,constant:20),
            // BlueBox 距离父视图的左部20个单位
            BlueBox.leftAnchor.constraint(equalTo: view.leftAnchor,constant:20),
            // 设置BlueBox的高度
            BlueBox.heightAnchor.constraint(equalToConstant:60),
            // 设置BlueBox的右边
            BlueBox.rightAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        RedBox.translatesAutoresizingMaskIntoConstraints=false
        let RedBoxCons = [
            RedBox.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            RedBox.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            RedBox.heightAnchor.constraint(equalToConstant: 100),
            RedBox.widthAnchor.constraint(equalToConstant: 100),
            RedBox.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor,constant:100),
        ]
        // 3.激活约束
        NSLayoutConstraint.activate(BlueBoxCons)
        NSLayoutConstraint.activate(RedBoxCons)
        
        // Do any additional setup after loading the view.
    }
    
    // Autolayout 小结
    /**
     1. autosizing:
        用来处理子视图和父视图直接的位置和尺寸关系
        处理子视图与子视图的位置和尺寸显得无能为力
     2. autolayout：
        用来处理子视图和父视图，以及子视图与其他子视图直接的尺寸和位置关系
     3. NSLayoutAnchor：
        用来简化代码编写autolayout约束的类
     4. 使用NSLayoutAnchor的时候不必考虑iOS中视图约束的添加位置
     
    */

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

