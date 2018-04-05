//
//  PackageDocument.swift
//  PersonProfileDocDemo
//
//  Created by 戴植锐 on 2018/3/11.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa
let ImageFileName = "Image.png"
let TextFieldName = "Text.txt"
class PackageDocument: NSDocument {

    @objc dynamic var profile: PersonProfile?
    
    override init() {
        super.init()
        self.profile = PersonProfile()
        // 默认图片
        self.profile?.image = NSImage(named: NSImage.Name.user)
    }

    override func makeWindowControllers() {
        // Return the Storyboard that contains your Document window
        let storyboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil)
        let windowController = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("Document Window Controller")) as! NSWindowController
        self.addWindowController(windowController)
        
        let document = windowController.document as! Document
        let viewController = windowController.contentViewController as! ViewController
        // viewController 跟 document 之间 profile 属性数据绑定
        viewController.bind(NSBindingName(rawValue: "profile"), to: document, withKeyPath: "profile", options: nil)
    }
    
    override func windowControllerDidLoadNib(_ aController: NSWindowController) {
        super.windowControllerDidLoadNib(aController)
        // Add any code here that needs to be executed once the windowController has loaded the document's window.
    }

    override func fileWrapper(ofType typeName: String) throws -> FileWrapper {
        let fileWrappers = FileWrapper(directoryWithFileWrappers: [:])
        if self.profile?.image != nil {
            let imageRepresentations = self.profile?.image?.representations
            if let imageData = NSBitmapImageRep.representationOfImageReps(in: imageRepresentations!, using: .png, properties: [:]) {
                let imageFileWrapper = FileWrapper(regularFileWithContents: imageData)
                imageFileWrapper.preferredFilename = ImageFileName
                fileWrappers.addFileWrapper(imageFileWrapper)
            }
        }
        let textData = self.profile?.jsonData()
        if textData != nil {
            let textFileWrapper = FileWrapper(regularFileWithContents: textData!)
            textFileWrapper.preferredFilename = TextFieldName
            fileWrappers.addFileWrapper(textFileWrapper)
        }
        return fileWrappers
    }
    
    override func read(from fileWrapper: FileWrapper, ofType typeName: String) throws {
        let fileWrappers = fileWrapper.fileWrappers
        let imageWrapper = fileWrappers?[ImageFileName]
        
        if imageWrapper != nil {
            let imageData = imageWrapper?.regularFileContents
            let image = NSImage(data: imageData!)
            self.profile?.image = image
        }
        
        let textFileWrapper = fileWrappers?[TextFieldName]
        if textFileWrapper != nil {
            let textData = textFileWrapper?.regularFileContents
            self.profile?.updata(with: textData)
        }
    }
}
