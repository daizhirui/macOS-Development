/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 View controller responsible for showing custom view NSTouchBarItem instances.
 */

#import "CustomViewViewController.h"
#import "CustomView.h"

static NSTouchBarItemIdentifier CustomViewIdentifier = @"com.TouchBarCatalog.customView";
static NSTouchBarCustomizationIdentifier CustomViewCustomizationIdentifier = @"com.TouchBarCatalog.customViewViewController";

@interface CustomViewViewController () <NSTouchBarDelegate>

@property (strong) NSCustomTouchBarItem *customViewItem;
@property NSInteger customViewType;
@property (strong) IBOutlet NSTextField *feedbackLabel;

@end

enum customViewType
{
    viewTypeTouches = 1000,
    viewTypeGestures = 1001
};

#pragma mark -

@implementation CustomViewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _customViewType = viewTypeTouches;
}

- (IBAction)choiceAction:(id)sender
{
    // We need to set the first responder status when one of our radio knobs was clicked.
    [self.view.window makeFirstResponder:self.view];
    
    _customViewType = ((NSButton *)sender).tag;
    
    _feedbackLabel.stringValue = @"";
    
    // Set to nil so makeTouchBar can be called again to re-create our NSTouchBarItem instances.
    self.touchBar = nil;
}

#pragma mark NSTouchBarProvider

- (NSTouchBar *)makeTouchBar
{
    NSTouchBar *bar = [[NSTouchBar alloc] init];
    bar.delegate = self;
    
    bar.customizationIdentifier = CustomViewCustomizationIdentifier;
    
    // Set the default ordering of items.
    bar.defaultItemIdentifiers =
        @[CustomViewIdentifier, NSTouchBarItemIdentifierOtherItemsProxy];
    
    bar.customizationAllowedItemIdentifiers = @[CustomViewIdentifier];
    
    return bar;
}

#pragma mark NSTouchBarDelegate

// This gets called while the NSTouchBar is being constructed, for each NSTouchBarItem to be created.
- (nullable NSTouchBarItem *)touchBar:(NSTouchBar *)touchBar makeItemForIdentifier:(NSTouchBarItemIdentifier)identifier
{
    if ([identifier isEqualToString:CustomViewIdentifier])
    {
        NSView *customView = nil;
        
        if (self.customViewType == viewTypeTouches)
        {
            // Create the custom view that analyzes touch events.
            customView = [[CustomView alloc] initWithFrame:NSZeroRect];
            
            customView.wantsLayer = YES;
            customView.layer.backgroundColor = [NSColor systemBlueColor].CGColor;
            
            customView.allowedTouchTypes = NSTouchTypeMaskDirect;
            
            // This is so we can report back the view's touch location to our feedback label.
            [self.feedbackLabel unbind:NSValueBinding];
            [self.feedbackLabel bind:NSValueBinding toObject:customView withKeyPath:@"trackingLocationString" options:nil];
        }
        else if (self.customViewType == viewTypeGestures)
        {
            // Create the custom view that uses gesture recognizers.
            customView = [[NSView alloc] initWithFrame:NSZeroRect];
            
            customView.wantsLayer = YES;
            customView.layer.backgroundColor = [NSColor systemGrayColor].CGColor;
            
            // This is for pan gesture recognizer to work.
            customView.allowedTouchTypes = NSTouchTypeMaskDirect;
            
            NSPanGestureRecognizer *panGesture = [[NSPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
            panGesture.allowedTouchTypes = NSTouchTypeMaskDirect;
            [customView addGestureRecognizer:panGesture];
        }
        
        _customViewItem = [[NSCustomTouchBarItem alloc] initWithIdentifier:CustomViewIdentifier];
        self.customViewItem.view = customView;
        self.customViewItem.customizationLabel = NSLocalizedString(@"Custom View", @"");
        
        return self.customViewItem;
    }
    
    return nil;
}


#pragma mark - Pan Gesture

- (void)panAction:(NSGestureRecognizer *)sender
{
    // This action method was called from our pan gesture recognizer.
    NSGestureRecognizer *gesture = sender;
    NSPoint location = [gesture locationInView:self.customViewItem.view];
    
    NSMutableString *feedbackStr = [NSLocalizedString(@"Pan Gesture Prefix", @"") mutableCopy];
    switch (gesture.state)
    {
        case NSGestureRecognizerStateBegan:
            [feedbackStr appendString:NSLocalizedString(@"Began", @"")];
            break;
        case NSGestureRecognizerStateChanged:
            [feedbackStr appendString:NSLocalizedString(@"Changed", @"")];
            break;
        case NSGestureRecognizerStateEnded:
            [feedbackStr appendString:NSLocalizedString(@"Ended", @"")];
            break;
            
        default:
            break;
    }
    
    [feedbackStr appendString:[NSString stringWithFormat:NSLocalizedString(@"Gesture Format", @""), location.x]];
    self.feedbackLabel.stringValue = feedbackStr;
}

@end
