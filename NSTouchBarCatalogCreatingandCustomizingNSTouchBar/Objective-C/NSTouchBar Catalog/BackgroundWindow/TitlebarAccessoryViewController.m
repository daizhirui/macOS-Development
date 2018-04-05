/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information

 */

#import "TitleBarAccessoryViewController.h"
#import "BackgroundImagesViewController.h"
#import "PhotoManager.h"

@implementation TitleBarAccessoryViewController

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return (self.openingViewController == nil); // Don't open the popover if it's already open.
}

- (void)prepareForSegue:(NSStoryboardSegue *)segue sender:(nullable id)sender
{
    _openingViewController = segue.destinationController;   // Remember our popover's view controller.
}

@end
