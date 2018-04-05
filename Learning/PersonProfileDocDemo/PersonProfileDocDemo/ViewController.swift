//
//  ViewController.swift
//  PersonProfileDocDemo
//
//  Created by 戴植锐 on 2018/3/11.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var imageView: NSImageView!
    
    @objc dynamic var profile: PersonProfile?

    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    func openFilePanel() {
        let openDlg = NSOpenPanel()
        openDlg.canChooseFiles = true
        openDlg.canChooseDirectories = false
        openDlg.allowsMultipleSelection = false
        openDlg.allowedFileTypes = ["png"]
        openDlg.begin(completionHandler: { [weak self] result in
            if result.rawValue == NSApplication.ModalResponse.OK.rawValue {
                let fileURLs = openDlg.urls
                for url: URL in fileURLs {
                    let image = NSImage(contentsOf: url)
                    self?.imageView.image = image
                    self?.profile?.image = image
                }
            }
        })
    }
}

extension ViewController: NSGestureRecognizerDelegate {
    @objc func magnify(_ sender: NSClickGestureRecognizer) {
        self.openFilePanel()
    }
}
