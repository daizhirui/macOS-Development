//
//  ViewController.swift
//  CalculatorWithUndoManagerDemo
//
//  Created by 戴植锐 on 2018/3/10.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var firstAddParaTextField: NSTextField!
    @IBOutlet weak var secondAddParaTextField: NSTextField!
    @IBOutlet weak var sumTextField: NSTextField!
    var para1: NSInteger = 0
    var para2: NSInteger = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.compute(add: [1,2])
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func computeAction(_ sender: NSButton) {
        let para1 = self.firstAddParaTextField.integerValue
        let para2 = self.secondAddParaTextField.integerValue
        self.compute(add: [para1, para2])
    }
    
    
    @IBAction func undoAction(_ sender: NSButton) {
        self.undoManager?.undo()
        
    }
    
    @IBAction func redoAction(_ sender: NSButton) {
        self.undoManager?.redo()
    }
    
    @objc func compute(add parameters: [NSInteger]) {
        // 解包元组
        let firstPara = parameters[0]
        let secondPara = parameters[1]
        // 两个加数没变化
        if self.para1 == firstPara && self.para2 == secondPara {
            return
        }
        // 注册 Undo Action
        // 如果检测到 isRedoing，会自动将注册的 Undo Action 放入 Redo 栈内
        self.undoManager?.registerUndo(withTarget: self, selector: #selector(self.compute(add:)), object: [self.para1, self.para2])
        // 命名：Undo 即将进行的操作
        self.undoManager?.setActionName("\(firstPara) + \(secondPara)")
        self.para1 = parameters[0]
        self.para2 = parameters[1]
        let sum = parameters[0] + parameters[1]
        // 显示
        self.firstAddParaTextField.integerValue = self.para1
        self.secondAddParaTextField.integerValue = self.para2
        self.sumTextField.integerValue = sum
    }
}

