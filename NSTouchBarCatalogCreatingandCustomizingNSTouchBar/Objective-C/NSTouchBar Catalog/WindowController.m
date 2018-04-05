/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 Main window controller for this sample.
 */

#import "WindowController.h"

static NSTouchBarItemIdentifier WindowControllerLabelIdentifier = @"com.TouchBarCatalog.windowController.label";
static NSString *backgroundWindowIdentifier = @"BackgroundWindow";

@interface WindowController () <NSTouchBarDelegate>

// Background Window used to test the TouchBar in the context of an NSPopover.
@property (nonatomic, strong) NSWindowController *backgroundWindowController;

@end


#pragma mark -

@implementation WindowController

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    self.window.frameAutosaveName = @"WindowAutosave";

    // Load the Background Window from it's separate storyboard.
    NSStoryboard *storyboard = [NSStoryboard storyboardWithName:backgroundWindowIdentifier bundle: nil];
    _backgroundWindowController = [storyboard instantiateControllerWithIdentifier:backgroundWindowIdentifier];
    self.backgroundWindowController.window.frameAutosaveName = backgroundWindowIdentifier;
    [self.backgroundWindowController showWindow:nil];
}

#pragma mark NSTouchBarProvider

// This window controller will have only one NSTouchBarItem instance, which is a simple label,
// so to show that view controller bar can reside along side its window controller.
//
- (NSTouchBar *)makeTouchBar
{
    NSTouchBar *bar = [[NSTouchBar alloc] init];
    bar.delegate = self;
        
    // Set the default ordering of items.
    bar.defaultItemIdentifiers =
        @[WindowControllerLabelIdentifier, NSTouchBarItemIdentifierOtherItemsProxy];
    
    return bar;
}

#pragma mark NSTouchBarDelegate

// This gets called while the NSTouchBar is being constructed, for each NSTouchBarItem to be created.
- (nullable NSTouchBarItem *)touchBar:(NSTouchBar *)touchBar makeItemForIdentifier:(NSTouchBarItemIdentifier)identifier
{
    if ([identifier isEqualToString:WindowControllerLabelIdentifier])
    {
        NSTextField *theLabel = [NSTextField labelWithString:NSLocalizedString(@"Catalog", @"")];
        
        NSCustomTouchBarItem *customItemForLabel =
            [[NSCustomTouchBarItem alloc] initWithIdentifier:WindowControllerLabelIdentifier];
        customItemForLabel.view = theLabel;
        
        // We want this label to always be visible no matter how many items are in the NSTouchBar instance.
        customItemForLabel.visibilityPriority = NSTouchBarItemPriorityHigh;
        
        return customItemForLabel;
    }
    
    return nil;
}

@end
