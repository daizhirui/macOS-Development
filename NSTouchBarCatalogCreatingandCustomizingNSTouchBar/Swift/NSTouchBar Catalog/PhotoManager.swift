/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 Singlelton object used to asychronously load all photos from the Desktop Pictures folder.
 */

import Cocoa
import Foundation

final class PhotoManager {
    
    static let ImageNameKey = "name"
    static let ImageKey = "image"
    static let ImageURLKey = "url"
    
    static let shared = PhotoManager()
    
    weak var delegate: PhotoManagerDelegate?
    
    var photos = [Any]()
    var loadComplete = false
    
    private init() {
        let library = FileManager.default.urls(for: .libraryDirectory, in: .localDomainMask)[0]
        let desktopPicturesURL = library.appendingPathComponent("Desktop Pictures", isDirectory: true)
        
        DispatchQueue.global(qos: .background).async {
            let enumerator =
                FileManager.default.enumerator(at: desktopPicturesURL,
                                               includingPropertiesForKeys: nil,
                                               options: .skipsHiddenFiles,
                                               errorHandler: nil)!
            
            for url in enumerator {
                guard let loadURL = url as? URL else { continue }
                
                if let fullImage = NSImage(contentsOf: loadURL) {
                    
                    let imageSize = fullImage.size
                    
                    guard imageSize.width > 0 && imageSize.height > 0 else { continue }
                    
                    let thumbnailHeight: CGFloat = 30
                    let thumbnailSize = NSSize(width: ceil(thumbnailHeight * imageSize.width / imageSize.height), height: thumbnailHeight)
                    
                    DispatchQueue.main.async {
                        let thumbnail = NSImage(size: thumbnailSize)
                        thumbnail.lockFocus()
                        fullImage.draw(in: NSRect(origin: .zero, size: thumbnailSize),
                                       from: NSRect(origin: .zero, size: imageSize),
                                       operation: .sourceOver,
                                       fraction: 1.0)
                        thumbnail.unlockFocus()
                        
                        let imageName = loadURL.lastPathComponent
                        var imageDict = [String: Any]()
                        imageDict = [PhotoManager.ImageKey: thumbnail as Any,
                                     PhotoManager.ImageNameKey: imageName,
                                     PhotoManager.ImageURLKey: loadURL]
                        self.photos.append(imageDict)
                    }
                }
            }
            
            self.loadComplete = true
            DispatchQueue.main.async {
                self.delegate?.didLoadPhotos(photos: self.photos)
            }
        }
    }
}

protocol PhotoManagerDelegate: class {
    func didLoadPhotos(photos: [Any])
}
