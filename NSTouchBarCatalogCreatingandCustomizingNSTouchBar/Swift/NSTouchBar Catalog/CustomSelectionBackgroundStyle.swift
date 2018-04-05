/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 Custom selection background view for NSScrubber.
 */

import Cocoa

@available(OSX 10.12.2, *)
fileprivate class CustomSelectionBackgroundView: NSScrubberSelectionView {
    override func draw(_ dirtyRect: NSRect) {
        NSColor.systemBlue.set()
        NSBezierPath(roundedRect: dirtyRect, xRadius: 6, yRadius: 6).fill()
    }
}

// MARK: -

@available(OSX 10.12.2, *)
class CustomSelectionBackgroundStyle: NSScrubberSelectionStyle {
    override func makeSelectionView () -> NSScrubberSelectionView? {
        return CustomSelectionBackgroundView()
    }
}

