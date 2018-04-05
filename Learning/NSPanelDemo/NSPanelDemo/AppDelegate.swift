//
//  AppDelegate.swift
//  NSPanelDemo
//
//  Created by 戴植锐 on 2018/3/6.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var loginPanel: NSPanel!
    @IBOutlet var textView: NSTextView!
    @IBOutlet weak var userNameField: NSTextField!
    @IBOutlet weak var passwordField: NSSecureTextField!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @IBAction func colorButtonAction(_ sender: NSButton) {
        let colorPanel = NSColorPanel.shared
        // 设置选择颜色后的触发函数
        colorPanel.setAction(#selector(changeTextColor(_:)))
        colorPanel.setTarget(self)
        // 显示面板
        colorPanel.orderFront(nil)
    }
    
    @objc func changeTextColor(_ sender: NSColorPanel) {
        let color = sender.color
        self.textView.textColor = color
    }
    
    lazy var font = NSFont()
    @IBAction func fontButtonAction(_ sender: NSButton) {
        let fontManager = NSFontManager.shared
        fontManager.target = self
        // 设置选择字体后触发的函数
        fontManager.action = #selector(changeTextFont(_:))
        // 显示面板
        fontManager.orderFrontFontPanel(self)
    }
    
    @objc func changeTextFont(_ sender: NSFontManager) {
        self.font = sender.convert(self.font)
        self.textView.font = self.font
    }

    @IBAction func loginButtonAction(_ sender: NSButton) {
        self.window.beginSheet(self.loginPanel, completionHandler: {[weak self] returnCode in
            let userName = self?.userNameField.stringValue
            let password = self?.passwordField.stringValue
            print("returnCode \(returnCode)")
            print("user name = \(String(describing: userName))")
            print("password = \(String(describing: password))")
        })
    }
    
    @IBAction func okButtonAction(_ sender: NSButton) {
        self.window.endSheet(self.loginPanel)
    }
    
    /***************************************************
     菜单项动作
    ****************************************************/
    // 打开文件面板
    @IBAction func openFilePanel(_ sender: NSMenuItem) {
        let openFileDlg = NSOpenPanel()
        // 显示提示文字在顶部，但是会导致顶部原有的一些工具栏消失
        //openFileDlg.message = "Open a text File"
        openFileDlg.canChooseFiles = true
        openFileDlg.canChooseDirectories = false
        openFileDlg.allowsMultipleSelection = false
        openFileDlg.allowedFileTypes = ["txt"]
        
        openFileDlg.begin(completionHandler: {[weak self] result in
            if (result.rawValue == NSApplication.ModalResponse.OK.rawValue) {
                let fileURLs = openFileDlg.urls
                for url: URL in fileURLs {
                    guard let text = try? NSString.init(contentsOf: url, encoding: String.Encoding.utf8.rawValue)
                        else {
                            return
                    }
                    self?.textView.string = text as String
                }
            }
        })
    }
    // 保存文件面板
    @IBAction func saveFilePanel(_ sender: AnyObject) {
        
        let text = self.textView.string
        
        let saveFileDlg = NSSavePanel()
        saveFileDlg.title = "Save File"
        // 显示提示文字在顶部
        // saveFileDlg.message = "Save a text File"
        saveFileDlg.allowedFileTypes = ["txt"]
        // 默认的文件名
        saveFileDlg.nameFieldStringValue = "MyUntitled"
        
        saveFileDlg.begin(completionHandler: { [weak self] result in
            if result.rawValue == NSApplication.ModalResponse.OK.rawValue {
                let url = saveFileDlg.url
                _ = try? text.write(to: url!, atomically: true, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            }
        })
    }
    
    // 关闭最后一个窗口时退出
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}

