//
//  ViewController.swift
//  BundleDemo
//
//  Created by 戴植锐 on 2018/3/12.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var textField: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let mainBundle = Bundle.main
        let mainBundlePath = mainBundle.bundlePath
        NSLog("\(mainBundlePath)")
        self.textField.stringValue = "\(mainBundlePath)"
        let text_url = URL(fileURLWithPath: "/Users/daizhirui/hello.txt")
        let image_url = URL(fileURLWithPath: "/Users/daizhirui/robot.jpeg")
        //NSWorkspace.shared.open(text_url)
        //NSWorkspace.shared.open(image_url)
        //NSWorkspace.shared.openFile("/Users/daizhirui/robot.jpeg")
        print(FileManager.default.currentDirectoryPath)
        print(NSHomeDirectory())
        print(NSOpenStepRootDirectory())
        print(NSUserName())
        print(NSFullUserName())
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

