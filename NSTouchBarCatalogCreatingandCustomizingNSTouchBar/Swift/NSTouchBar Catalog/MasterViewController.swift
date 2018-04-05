/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 The master view controller giving access to all test cases in this sample.
 */

import Cocoa

class MasterViewController: NSViewController, NSTableViewDelegate {
    struct TestCaseKey {
        static let root = "tests"
        static let name = "testName"
        static let kind = "testKind"
    }
    
    @IBOutlet weak var contentArray: NSArrayController!
    @IBOutlet weak var tableView: NSTableView!
    
    // MARK: View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(OSX 10.12.1, *) {
            // Load the tests from our plist database, add them to our array controller.
            guard let fileURL = Bundle.main.url(forResource: "Tests", withExtension: "plist"),
                let plistContent = NSDictionary(contentsOf: fileURL),
                let testData = plistContent[TestCaseKey.root] as? [[String: String]] else { return }
            
            tableView.delegate = self
            contentArray.add(contentsOf: testData)
        }
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(MasterViewController.selectionDidChange(_:)),
                                               name: NSTableView.selectionDidChangeNotification,
                                               object: tableView)
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        // Start by showing the first button example.
        contentArray.setSelectionIndex(0)
    }
    
    @objc
    func selectionDidChange(_ notification: Notification) {
        if let splitViewController = view.window!.contentViewController as? NSSplitViewController {
            var viewController = NSViewController()
            var splitViewItem = NSSplitViewItem()
            
            if tableView.selectedRow == -1 {
                // No selection, so provide an empty detail view controller.
                let storyboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil)
                viewController =
                    (storyboard.instantiateController(withIdentifier:
                        NSStoryboard.SceneIdentifier(rawValue: "DetailViewController")) as? NSViewController)!
                splitViewItem = NSSplitViewItem(viewController: viewController)
            } else {
                // We have a valid selection, load the right storyboard for the detail view controller.
                guard let arrangedObjects = contentArray.arrangedObjects as? [AnyObject],
                    let testCase = arrangedObjects[tableView.selectedRow] as? [String: String],
                    let storyboardName = testCase[TestCaseKey.kind]
                    else { return }
                
                viewController = (NSStoryboard(name: NSStoryboard.Name(rawValue: storyboardName),
                                               bundle: nil).instantiateInitialController() as? NSViewController)!
                splitViewItem = NSSplitViewItem(viewController: viewController)
            }
            
            splitViewController.splitViewItems[1] = splitViewItem
            
            // Bind the NSTouchBar instance of master view controller to the one of the detal view controller
            // so that the bar always shows up whoever the first responder is.
            //
            unbind(NSBindingName(rawValue: #keyPath(touchBar))) // unbind first
            bind(NSBindingName(rawValue: #keyPath(touchBar)), to: viewController, withKeyPath: #keyPath(touchBar), options: nil)
        }
    }

    deinit {
        unbind(NSBindingName(rawValue: #keyPath(touchBar)))
    }
}

