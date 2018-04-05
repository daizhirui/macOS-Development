/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 View controller used for the title bar accessory containing the "Set Background" button.
 */

#import <Cocoa/Cocoa.h>

@class BackgroundImagesViewController;

@interface TitleBarAccessoryViewController : NSTitlebarAccessoryViewController

@property (nonatomic, strong) BackgroundImagesViewController *openingViewController;

@end
