//
//  Document.swift
//  PersonProfileDocDemo
//
//  Created by 戴植锐 on 2018/3/11.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class Document: NSDocument {
    
    @objc dynamic var profile: PersonProfile?

    override init() {
        super.init()
        profile = PersonProfile()
        // 默认图片
        self.profile?.image = NSImage(named: NSImage.Name.user)
    }

    override class var autosavesInPlace: Bool {
        return true
    }
    // 创建窗口控制器
    override func makeWindowControllers() {
        // Returns the Storyboard that contains your Document window.
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        let windowController = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("Document Window Controller")) as! NSWindowController
        self.addWindowController(windowController)
        
        let document = windowController.document as! Document
        let viewController = windowController.contentViewController as! ViewController
        // viewController 跟 document 之间 profile 属性数据绑定
        viewController.bind(NSBindingName(rawValue: "profile"), to: document, withKeyPath: "profile", options: nil)
    }
    // 保存文档数据方法
    override func data(ofType typeName: String) throws -> Data {
        if let data = self.profile?.docData() {
            return data
        }
        else {
            throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
        }
    }
    // 读取文档数据方法
    override func read(from data: Data, ofType typeName: String) throws {
        self.profile = PersonProfile.profileFrom(data)
    }
    // 实际根据文件路径和文件格式写入文件
    override func write(to url: URL, ofType typeName: String) throws {
        if typeName == "com.daizhirui.pdata" {
            // 文档数据普通输出
            return try! super.write(to: url, ofType: typeName)
        }
        if typeName == "com.daizhirui.pxdata" {
            // 文档数据 Wrapper 方式存储
            let pdoc = PackageDocument()
            pdoc.setValue(self.profile, forKey: "profile")
            return try! pdoc.write(to: url, ofType: typeName)
        }
    }
}

