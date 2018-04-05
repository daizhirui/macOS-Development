//
//  ViewController.swift
//  NSUndoManagerDemo
//
//  Created by 戴植锐 on 2018/3/10.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var colorView: NSView!
    var fillColor: NSColor = NSColor.red
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.colorView.wantsLayer = true
        self.colorView.layer?.backgroundColor = NSColor.red.cgColor
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func fillColorView(with color: NSColor) {
        if color == self.fillColor {
            return
        }
        let currentColor = self.fillColor
        self.undoManager?.registerUndo(withTarget: self){ target in
            target.fillColorView(with: currentColor)
        }
        if color == NSColor.red {
            self.undoManager?.setActionName("Fill with red")
        }else{
            self.undoManager?.setActionName("Fill with black")
        }
        self.colorView.layer?.backgroundColor = color.cgColor
        self.fillColor = color
    }
    
    @IBAction func fillRedAction(_ sender: NSButton) {
        self.fillColorView(with: NSColor.red)
    }
    
    @IBAction func fillBlackAction(_ sender: NSButton) {
        self.fillColorView(with: NSColor.black)
    }
    
    @IBAction func undoAction(_ sender: NSButton) {
        self.undoManager?.undo()
    }
    
    @IBAction func redoAction(_ sender: NSButton) {
        self.undoManager?.redo()
    }
}

