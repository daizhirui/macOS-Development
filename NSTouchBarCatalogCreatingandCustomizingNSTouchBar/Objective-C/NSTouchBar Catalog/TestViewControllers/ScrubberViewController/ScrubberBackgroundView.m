/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 Custom NSView for the NSScrubber's background.
 */

#import "ScrubberBackgroundView.h"

@implementation ScrubberBackgroundView

- (BOOL)wantsUpdateLayer
{
    return YES;
}

- (void)updateLayer
{
    self.layer.backgroundColor = NSColor.systemPurpleColor.CGColor;
}

- (BOOL)isOpaque
{
    return YES;
}

@end



