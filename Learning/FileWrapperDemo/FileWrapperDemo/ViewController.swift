//
//  ViewController.swift
//  FileWrapperDemo
//
//  Created by 戴植锐 on 2018/3/10.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var imageView: NSImageView!
    @IBOutlet weak var textField: NSTextField!
    // 使用 dynamic 关键字，方便后面使用 bind 技术而增加
    @objc dynamic var image: NSImage?
    @objc dynamic var text: String?
    
    var textColor: NSColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupClickGesture()
        // Do any additional setup after loading the view.
    }
    
    deinit {
        print("ViewController deinit")
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func setupClickGesture() {
        // 创建手势类
        let gr = NSClickGestureRecognizer(target: self, action: #selector(ViewController.magnify(_:)))
        // 视图增加手势识别
        self.imageView.addGestureRecognizer(gr)
        gr.delegate = self
    }
    // 打开文件选择面板，选择图片
    func openFilePanel() {
        let openDlg = NSOpenPanel()
        openDlg.canChooseFiles = true
        openDlg.canChooseDirectories = false
        openDlg.allowsMultipleSelection = false
        openDlg.allowedFileTypes = ["png"]
        openDlg.begin(completionHandler: { [weak self] result in
            if (result.rawValue == NSApplication.ModalResponse.OK.rawValue) {
                let fileURLs = openDlg.urls
                for url:URL in fileURLs {
                    let image = NSImage(contentsOf: url)
                    // 更新 imageView
                    self?.imageView.image = image
                    // 存储选择的图像到 image
                    self?.image = image
                }
            }
        })
    }
    
    func updateTextColor(_ color: NSColor) {
        if let target = self.undoManager?.prepare(withInvocationTarget: self) as? ViewController {
            target.updateTextColor(self.textColor!)
        }
        self.textColor = color
        self.textField.textColor = color
    }
    
    @IBAction func changeColorAction(_ sender: NSButton) {
        let colorPanel = NSColorPanel.shared
        // 设置选择颜色后的触发函数
        colorPanel.setAction(#selector(self.changeTextColor(_:)))
        colorPanel.setTarget(self)
        // 显示面板
        colorPanel.orderFront(nil)
    }
    
    @objc func changeTextColor(_ sender: NSColorPanel) {
        let color = sender.color
        self.updateTextColor(color)
    }
}

extension ViewController: NSGestureRecognizerDelegate {
    @objc func magnify(_ sender: NSClickGestureRecognizer) {
        self.openFilePanel()
    }
}

extension ViewController: NSTextFieldDelegate {
    override func controlTextDidChange(_ obj: Notification) {
        if let textField = obj.object as? NSTextField {
            let text = textField.stringValue
            self.text = text
        }
    }
}
