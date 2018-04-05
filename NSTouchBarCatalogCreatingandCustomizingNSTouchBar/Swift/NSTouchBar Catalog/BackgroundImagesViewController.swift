/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 View controller used for the view-based table view of images, using a NSScrubberImageItemView without subclassing.
 */

import Cocoa

@available(OSX 10.12.2, *)
class BackgroundImagesViewController: NSViewController {
    
    static let imageScrubber = NSTouchBarItem.Identifier("com.TouchBarCatalog.TouchBarItem.imageScrubber")

    var selectedItemIdentifier: NSTouchBarItem.Identifier = BackgroundImagesViewController.imageScrubber
    
    @IBOutlet weak var scrollView: NSScrollView!
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var progressIndicator: NSProgressIndicator!
    
    @IBOutlet weak var myContentArray: NSArrayController!
    @objc var tableContents = [Any]()
    
    // MARK: View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Listen for table view selection changes.
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(BackgroundImagesViewController.selectionDidChange(_:)),
                                               name: NSTableView.selectionDidChangeNotification,
                                               object: tableView)
        
        scrollView.wantsLayer = true
        scrollView.layer?.cornerRadius = 6
        
        // Load the pictures for our scrubber and table content.
        fetchPictureResources()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        view.window?.makeFirstResponder(view)
    }
    
    fileprivate func displayPhotos() {
        willChangeValue(forKey: "tableContents")
        tableContents = PhotoManager.shared.photos
        self.didChangeValue(forKey: "tableContents")
        
        self.touchBar = nil    // Force update our NSTouchBar.
        
        self.progressIndicator.stopAnimation(self)
        self.progressIndicator.isHidden = true
        self.scrollView.isHidden = false
    }
    
    fileprivate func fetchPictureResources() {
        if PhotoManager.shared.loadComplete {
            displayPhotos()
        } else {
            // The PhotoManager has not loaded all the photos. This could take a while, show the progress indicator.
            PhotoManager.shared.delegate = self   // So we can be notified when the photos have been loaded.
            progressIndicator.isHidden = false
            scrollView.isHidden = true
            progressIndicator.startAnimation(self)
        }
    }
    
    // MARK: Notifications
    
    fileprivate func chooseImageWithIndex(index: Int) {
        guard let imageDict = tableContents[index] as? [String: Any] else { return }
        
        // Process the chosen image and dismiss us as the popover.
        if let presentingViewController = presenting as? TitleBarAccessoryViewController {
            if let backgroundViewController = presentingViewController.view.window?.contentViewController as? BackgroundViewController {
                if let url = imageDict[PhotoManager.ImageURLKey] as? NSURL {
                    if let fullImage = NSImage(contentsOf: url as URL) {
                        backgroundViewController.imageView.image = fullImage
                        presentingViewController.dismissViewController(self)
                        presentingViewController.openingViewController = nil
                    }
                }
            }
        }
    }
    
    @objc
    func selectionDidChange(_ notification: Notification) {
        // User selected a particular background photo.
        guard 0...tableView.numberOfRows ~= tableView.selectedRow else { return }
        
        chooseImageWithIndex(index: tableView.selectedRow)
    }
    
    static let itemViewIdentifier = "ImageItemViewIdentifier"
    
    // MARK: NSTouchBarProvider
    
    override func makeTouchBar() -> NSTouchBar? {
        let touchBar = NSTouchBar()
        touchBar.delegate = self
        touchBar.customizationIdentifier = NSTouchBar.CustomizationIdentifier("com.TouchBarCatalog.scrubberBar")
        touchBar.defaultItemIdentifiers = [BackgroundImagesViewController.imageScrubber]
        touchBar.customizationAllowedItemIdentifiers = [BackgroundImagesViewController.imageScrubber]
        touchBar.principalItemIdentifier = BackgroundImagesViewController.imageScrubber
        
        return touchBar
    }
}

// MARK: - NSTouchBarDelegate

@available(OSX 10.12.2, *)
extension BackgroundImagesViewController: NSTouchBarDelegate {
    
    // This gets called while the NSTouchBar is being constructed, for each NSTouchBarItem to be created.
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
        let scrubberItem: NSCustomTouchBarItem
        
        scrubberItem = NSCustomTouchBarItem(identifier: identifier)
        scrubberItem.customizationLabel = NSLocalizedString("Choose Photo", comment:"")
        
        let scrubber = NSScrubber()
        scrubber.register(NSScrubberImageItemView.self,
                          forItemIdentifier: NSUserInterfaceItemIdentifier(BackgroundImagesViewController.itemViewIdentifier))
        scrubber.mode = .free
        scrubber.selectionBackgroundStyle = .roundedBackground
        scrubber.delegate = self
        scrubber.dataSource = self
        scrubber.showsAdditionalContentIndicators = true
        scrubber.scrubberLayout = NSScrubberFlowLayout()
        
        scrubberItem.view = scrubber
        
        // Set the scrubber's width to be 400.
        let viewBindings: [String: NSView] = ["scrubber": scrubber]
        let hconstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[scrubber(400)]",
                                                          options: [],
                                                          metrics: nil,
                                                          views: viewBindings)
        NSLayoutConstraint.activate(hconstraints)
        
        return scrubberItem
    }
}

// MARK: - PhotoManagerDelegate

@available(OSX 10.12.2, *)
extension BackgroundImagesViewController: PhotoManagerDelegate {

    // Used to refresh our UI, when all the photos have been loaded.
    func didLoadPhotos(photos: [Any]) {
        displayPhotos()
    }
}

// MARK: - NSScrubberDataSource

@available(OSX 10.12.2, *)
extension BackgroundImagesViewController: NSScrubberDataSource, NSScrubberDelegate {
    
    func numberOfItems(for scrubber: NSScrubber) -> Int {
        if tableContents.isEmpty {
            fetchPictureResources()
        }
        return tableContents.count
    }
    
    // Scrubber is asking for a custom view represention for a particuler item index.
    func scrubber(_ scrubber: NSScrubber, viewForItemAt index: Int) -> NSScrubberItemView {
        var returnItemView = NSScrubberItemView()
        if let itemView =
            scrubber.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: BackgroundImagesViewController.itemViewIdentifier),
                              owner: nil) as? NSScrubberImageItemView {
            if index < tableContents.count {
                if let imageDict = tableContents[index] as? [String: Any] {
                    if let image = imageDict[PhotoManager.ImageKey] as? NSImage {
                        itemView.image = image
                    }
                }
            }
            returnItemView = itemView
        }
        return returnItemView
    }
    
    // Scrubber is asking for the size for a particular item.
    func scrubber(_ scrubber: NSScrubber, layout: NSScrubberFlowLayout, sizeForItemAt itemIndex: Int) -> NSSize {
        return NSSize(width: 50, height: 30)
    }
    
    // User chose a particular image inside the scrubber.
    func scrubber(_ scrubber: NSScrubber, didSelectItemAt index: Int) {
        chooseImageWithIndex(index: index)
    }
}

