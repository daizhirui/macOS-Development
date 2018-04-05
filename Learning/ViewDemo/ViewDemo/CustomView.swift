//
//  CustomView.swift
//  ViewDemo
//
//  Created by 戴植锐 on 2018/2/28.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Foundation
import AppKit

final class CustomView: NSView {
    
    override var isFlipped: Bool {
        get {
            return false
        }
    }
    
    override func mouseDown(with event: NSEvent) {
        let point = self.convert(event.locationInWindow, to: nil)
        // replace "print" with "Swift.print" if needed
        print("window point: \(event.locationInWindow)")
        print("view point: \(point)")
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        NSColor.blue.setFill()
        let frame = self.bounds
        let path = NSBezierPath()
        path.appendRoundedRect(frame, xRadius: 10, yRadius: 10)
        path.fill()
    }
    
    func drawViewShape() {
        // 必须先停用 layer
        self.wantsLayer = false
        self.lockFocus()
        let text: NSString = "RoundedRect"
        let font = NSFont(name: "Palatino-Roman", size: 12)
        let attrs = [NSAttributedStringKey.font :font!,
                     NSAttributedStringKey.foregroundColor: NSColor.blue,
                     NSAttributedStringKey.backgroundColor: NSColor.red]
        let loaction = NSPoint(x: 50, y: 50)
        text.draw(at: loaction, withAttributes: attrs)
        self.unlockFocus()
    }
    
    func saveSelfAsImage() {
        self.lockFocus()
        let image = NSImage(data: self.dataWithPDF(inside: self.bounds))
        self.unlockFocus()
        let imageData = image!.tiffRepresentation
        
        let fileManager = FileManager.default
        // 写死的文件路径
        let path = "/Users/daizhirui/Downloads/myCapture.png"
        fileManager.createFile(atPath: path, contents: imageData, attributes: nil)
        // 定位文件路径
        let fileURL = URL(fileURLWithPath: path)
        NSWorkspace.shared.activateFileViewerSelecting([fileURL])
    }
    
    func saveScrollViewAsImage() {
        let pdfData = self.dataWithPDF(inside: self.bounds)
        let imageRep = NSPDFImageRep(data: pdfData)!
        let count = imageRep.pageCount
        for i in 0..<count {
            imageRep.currentPage = i
            let tempImage = NSImage()
            tempImage.addRepresentation(imageRep)
            let rep = NSBitmapImageRep(data: tempImage.tiffRepresentation!)
            let imageData = rep?.representation(using: .png, properties: [:])
            
            let fileManager = FileManager.default
            // 写死的文件路径
            let path = "/Users/daizhirui/Downloads/myCapture.png"
            fileManager.createFile(atPath: path, contents: imageData, attributes: nil)
            // 定位文件路径
            let fileURL = URL(fileURLWithPath: path)
            NSWorkspace.shared.activateFileViewerSelecting([fileURL])
        }
    }
}
