/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 View controller used for the background of the Background Window test.
 */

#import "BackgroundViewController.h"

@interface BackgroundViewController ()

// Accessory view controller to hold the "Set Background" button as part of the window's titlebar.
@property (nonatomic, strong) NSTitlebarAccessoryViewController *titlebarAccessoryViewController;

@end


#pragma mark -

@implementation BackgroundViewController

- (void)viewWillAppear
{
    [super viewWillAppear];
    
    // Set the window's titlebar accessory view controller that holds our "Set Background" button.
    _titlebarAccessoryViewController = [self.storyboard instantiateControllerWithIdentifier:@"ChangeBackground"];
    self.titlebarAccessoryViewController.layoutAttribute = NSLayoutAttributeBottom;
    [self.view.window addTitlebarAccessoryViewController:self.titlebarAccessoryViewController];
}

@end
