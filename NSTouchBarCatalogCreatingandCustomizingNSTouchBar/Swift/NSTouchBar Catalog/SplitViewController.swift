/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 Main split view controller for this sample (master = table of tests, detail = each view controller test)
 */

import Cocoa

class SplitViewController: NSSplitViewController {
    // MARK: View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        splitView.autosaveName = NSSplitView.AutosaveName(rawValue: "SplitViewAutosSave")
        minimumThicknessForInlineSidebars = 10.0
    }
}

