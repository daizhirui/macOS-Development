//
//  ViewController.swift
//  NSDatePickerDemo
//
//  Created by 戴植锐 on 2018/3/4.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSDatePickerCellDelegate {
    
    @IBOutlet weak var textualDateTimePicker: NSDatePicker!
    @IBOutlet weak var textualDatePicker: NSDatePicker!
    @IBOutlet weak var graphicalDatePicker: NSDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.graphicalDatePicker.dateValue = self.getSystemTime()
        
        print(Date())   // 格林尼治时间
        print(NSDate()) // 格林尼治时间
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func getSystemTime() -> Date {
        // 获取当前系统时间
        let date = Date()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        timeFormatter.timeZone = TimeZone(identifier: "America/Los_Angeles")
        let strNowTime = timeFormatter.string(from: date) as String
        print(strNowTime)   // DateFormatter 负责将时间转换为本地时间
        return date
    }

    @IBAction func graphicalDatePicker(_ sender: NSDatePicker) {
        let date = sender.dateValue
        print("date = \(date)")
        self.textualDatePicker.dateValue = date
        self.textualDateTimePicker.dateValue = date
    }
    
    func datePickerCell(_ datePickerCell: NSDatePickerCell, validateProposedDateValue proposedDateValue: AutoreleasingUnsafeMutablePointer<NSDate>, timeInterval proposedTimeInterval: UnsafeMutablePointer<TimeInterval>?) {
        let timeInterval = proposedTimeInterval?.pointee
        self.textualDateTimePicker.timeInterval = timeInterval!
    }
    
    
}

