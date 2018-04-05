//
//  Document.swift
//  FileWrapperDemo
//
//  Created by 戴植锐 on 2018/3/10.
//  Copyright © 2018年 戴植锐. All rights reserved.
//
// 创建⼀个⽬录型 NSFileWrapper，内部包括⼀个⽂本和⼀个图⽚⽂件。

import Cocoa
// 1. 定义图片和文本文件名称如下
let imageFileName = "Image.png"
let textFileName = "Text.txt"

class Document: NSDocument {
    // 定义存储 FileWrapper 中的图片和文字的数据变量
    @objc dynamic var image: NSImage?
    @objc dynamic var text: String?
    // Document 析构时打印 log
    deinit {
        NSLog("Document deinit")
    }

    override func makeWindowControllers() {
        // Returns the Storyboard that contains your Document window.
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        let windowController = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("Document Window Controller")) as! NSWindowController
        self.addWindowController(windowController)
        // 建立双向绑定关系
        self.setupDataBindings(windowController)
        self.undoManager?.setActionName("Change Color")
    }

    // 设置数据绑定
    func setupDataBindings(_ windowController: NSWindowController) {
        let document = windowController.document as! Document
        let viewController = windowController.contentViewController as! ViewController
        // document的image变化后更新ViewController的image属性
        viewController.bind(NSBindingName(rawValue: "image"), to: document, withKeyPath: "image", options: nil)
        // viewController的image变化后更新document的image属性
        document.bind(NSBindingName(rawValue: "image"), to: viewController, withKeyPath: "image", options: nil)
        // document的text变化后更新viewController的text属性
        viewController.bind(NSBindingName(rawValue: "text"), to: document, withKeyPath: "text", options: nil)
        // viewController的text变化后更新document的text属性
        document.bind(NSBindingName(rawValue: "text"), to: viewController, withKeyPath: "text", options: nil)
    }
    
    // 一、创建 FileWrapper 管理文件
    override func fileWrapper(ofType typeName: String) throws -> FileWrapper {
        // 2. 创建一个目录类型的 fileWrapper 做为根节点，读取图片内容到 imageData 变量
        let fileWrappers = FileWrapper(directoryWithFileWrappers: [:])
        // 3. self.image 非空时，读取图片内容到 imageData变量
        if self.image != nil {
            let imageRepresentations = self.image?.representations
            let imageData = NSBitmapImageRep.representationOfImageReps(in: imageRepresentations!, using: .png, properties: [:])
            // 4. 创建一个存储图片内容的文件型 FileWrapper 名为 imageFileWrapper
            let imageFileWrapper = FileWrapper(regularFileWithContents: imageData!)
            imageFileWrapper.preferredFilename = imageFileName
            // 5. 添加 imageFileWrapper 到父 fileWrapper
            fileWrappers.addFileWrapper(imageFileWrapper)
        }
        // 6. 创建一个文本类型的 FileWrapper 名为 textFileWrapper，并将其增加到根节点 fileWrapper
        if self.text != nil {
            let textData = self.text?.data(using: String.Encoding.utf8)
            let textFileWrapper = FileWrapper(regularFileWithContents: textData!)
            textFileWrapper.preferredFilename = textFileName
            fileWrappers.addFileWrapper(textFileWrapper)
        }
        return fileWrappers
    }
    // 二、从 NSFileWrapper 实例读取内容
    // 获取 NSFileWrapper 中所有的子节点，根据 key 获取不同类型的子 Wrapper，并解析其内容
    override func read(from fileWrapper: FileWrapper, ofType typeName: String) throws {
        let fileWrappers = fileWrapper.fileWrappers
        // 获取 imageWrapper
        let imageWrapper = fileWrappers?[imageFileName]
        // 解析图片
        if imageWrapper != nil {
            let imageData = imageWrapper?.regularFileContents
            let image = NSImage(data: imageData!)
            self.image = image
        }
        // 获取 textWrapper
        let textFileWrapper = fileWrappers?[textFileName]
        // 解析文本文件
        if textFileWrapper != nil {
            let textData = textFileWrapper?.regularFileContents
            let textString = String(data: textData!, encoding: String.Encoding.utf8)
            self.text = textString
        }
    }


}

