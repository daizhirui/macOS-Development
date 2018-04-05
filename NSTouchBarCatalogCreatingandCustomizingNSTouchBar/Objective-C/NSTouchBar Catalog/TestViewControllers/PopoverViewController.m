/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 View controller responsible for showing NSPopoverTouchBarItem in an NSTouchBar instance
 */

#import "PopoverViewController.h"

static NSTouchBarCustomizationIdentifier PopoverCustomizationIdentifier = @"com.TouchBarCatalog.popoverViewController";

static NSTouchBarItemIdentifier PopoverItemIdentifier = @"com.TouchBarCatalog.popover";
static NSTouchBarItemIdentifier SimpleSliderItemIdentifier = @"com.TouchBarCatalog.simpleSlider";
static NSTouchBarItemIdentifier SimpleLabelItemIdentifier = @"com.TouchBarCatalog.simpleLabel";
static NSTouchBarItemIdentifier CloseButtonItemIdentifier = @"com.TouchBarCatalog.customCloseButton";


typedef NS_ENUM(NSInteger, RepresentationTypes) {
    ScrubberTypeImageLabel = 1014,
    RepresentationTypeCustom = 1015
};

@interface PopoverViewController () <NSTouchBarDelegate>

@property RepresentationTypes representationType;

@property (weak) IBOutlet NSButton *useImage;
@property (weak) IBOutlet NSButton *useLabel;

@property (weak) IBOutlet NSButton *pressAndHold;
@property (weak) IBOutlet NSButton *useCustomClose;

@property (strong) NSPopoverTouchBarItem *popoverTouchBarItem;

@end


#pragma mark -

@implementation PopoverViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _representationType = ScrubberTypeImageLabel;
    
    // Note: If you ever want to show the NSTouchBar instance within this view controller do this:
    // [self.view.window makeFirstResponder:self.view];
}

- (void)invalidateTouchBar
{
    // We need to set the first responder status when one of our radio knobs was clicked.
    [self.view.window makeFirstResponder:self.view];
    
    // Set to nil so makeTouchBar can be called again to re-create our NSTouchBarItem instances.
    self.touchBar = nil;
}

- (IBAction)representationTypeAction:(id)sender
{
    _representationType = ((NSButton *)sender).tag;
    
    // Image and label options should be disabled for custom style.
    self.useImage.enabled = self.representationType == RepresentationTypeCustom ? NO : YES;
    self.useLabel.enabled = self.representationType == RepresentationTypeCustom ? NO : YES;
    
    [self invalidateTouchBar];
}

- (IBAction)customizeAction:(id)sender
{
    // Press and Hold or Custom Close checkboxes were clicked.
    [self invalidateTouchBar];
}

#pragma mark NSTouchBarProvider

- (NSTouchBar *)makeTouchBar
{
    NSTouchBar *bar = [[NSTouchBar alloc] init];
    bar.delegate = self;
    
    bar.customizationIdentifier = PopoverCustomizationIdentifier;
    
    // Set the default ordering of items.
    bar.defaultItemIdentifiers = @[PopoverItemIdentifier, NSTouchBarItemIdentifierOtherItemsProxy];
    
    bar.customizationAllowedItemIdentifiers = @[PopoverItemIdentifier];
    
    bar.principalItemIdentifier = PopoverItemIdentifier;
    
    return bar;
}

#pragma mark NSTouchBarDelegate

// This gets called while the NSTouchBar is being constructed, for each NSTouchBarItem to be created.
- (nullable NSTouchBarItem *)touchBar:(NSTouchBar *)touchBar makeItemForIdentifier:(NSTouchBarItemIdentifier)identifier
{
    if ([identifier isEqualToString:PopoverItemIdentifier])
    {
        _popoverTouchBarItem = [[NSPopoverTouchBarItem alloc] initWithIdentifier:PopoverItemIdentifier];
        self.popoverTouchBarItem.customizationLabel = NSLocalizedString(@"Popover", @"");
        
        self.popoverTouchBarItem.showsCloseButton = (self.useCustomClose.state == NSOffState);
        
        if (self.representationType == ScrubberTypeImageLabel)
        {
            // We want an image and/or label to represent the collapsed state of this popover.
            if (self.useImage.state == NSOnState)
            {
                self.popoverTouchBarItem.collapsedRepresentationImage = [NSImage imageNamed:NSImageNameBookmarksTemplate];
            }
            if (self.useLabel.state == NSOnState)
            {
                self.popoverTouchBarItem.collapsedRepresentationLabel = NSLocalizedString(@"Open Popover", @"");
            }
        }
        else
        {
            // We want a custom view (NSButton) to represent the collapsed state of this popover.
            // To make this work, we create a custom NSButton whose target is this popover item, whose action is showPopover:
            //
            NSButton *button =
            [NSButton buttonWithTitle:NSLocalizedString(@"Open Popover", @"")
                               target:self.popoverTouchBarItem
                               action:@selector(showPopover:)];
            button.bezelColor = [NSColor systemBlueColor];
            
            // Use the built-in gesture recognizer for tap and hold to open our popover's NSTouchBar.
            NSGestureRecognizer *gestureRecognizer = self.popoverTouchBarItem.makeStandardActivatePopoverGestureRecognizer;
            [button addGestureRecognizer:gestureRecognizer];
            self.popoverTouchBarItem.collapsedRepresentation = button;
        }
        
        NSTouchBar *secondaryTouchBar = [[NSTouchBar alloc] init];
        secondaryTouchBar.delegate = self;  // Set as the delegate so "makeItemForIdentifier" can be called for this secondary NSTouchBar.
        
        if (self.pressAndHold.state == NSOnState)
        {
            // Assign this popover item its press and hold NSTouchBar instance.
            secondaryTouchBar.defaultItemIdentifiers = @[SimpleSliderItemIdentifier,
                                                         NSTouchBarItemIdentifierFixedSpaceSmall,
                                                         SimpleLabelItemIdentifier];
            self.popoverTouchBarItem.pressAndHoldTouchBar = secondaryTouchBar;
        }
        else if (self.useCustomClose.state == NSOnState)
        {
            // Assign this popover item its NSTouchBar instance with a custom close button to the left.
            secondaryTouchBar.defaultItemIdentifiers = @[CloseButtonItemIdentifier,
                                                         SimpleSliderItemIdentifier,
                                                         NSTouchBarItemIdentifierFixedSpaceSmall,
                                                         SimpleLabelItemIdentifier];
        }
        
        self.popoverTouchBarItem.popoverTouchBar = secondaryTouchBar;
        
        return self.popoverTouchBarItem;
    }
    else if ([identifier isEqualToString:SimpleSliderItemIdentifier])
    {
        NSSliderTouchBarItem *sliderTouchBarItem =
        [[NSSliderTouchBarItem alloc] initWithIdentifier:SimpleSliderItemIdentifier];
        
        sliderTouchBarItem.slider.minValue = 0.0f;
        sliderTouchBarItem.slider.maxValue = 10.0f;
        sliderTouchBarItem.slider.doubleValue = 0.0f;
        sliderTouchBarItem.target = self;
        sliderTouchBarItem.action = @selector(sliderChanged:);
        sliderTouchBarItem.label = NSLocalizedString(@"Slider", @"");
        sliderTouchBarItem.customizationLabel = NSLocalizedString(@"Slider", @"");
        
        return sliderTouchBarItem;
    }
    else if ([identifier isEqualToString:SimpleLabelItemIdentifier])
    {
        NSCustomTouchBarItem *customItemForLabel =
        [[NSCustomTouchBarItem alloc] initWithIdentifier:SimpleLabelItemIdentifier];
        
        NSTextField *theLabel = [NSTextField labelWithString:NSLocalizedString(@"The Label", @"")];
        customItemForLabel.view = theLabel;
        
        return customItemForLabel;
    }
    else if ([identifier isEqualToString:CloseButtonItemIdentifier])
    {
        NSCustomTouchBarItem *touchBarItem =
        [[NSCustomTouchBarItem alloc] initWithIdentifier:CloseButtonItemIdentifier];
        NSButton *button = [NSButton buttonWithTitle:NSLocalizedString(@"Close", @"")
                                              target:self
                                              action:@selector(closeAction:)];
        touchBarItem.view = button;
        touchBarItem.customizationLabel = NSLocalizedString(@"Close", @"");
        
        return touchBarItem;
    }
    
    return nil;
}

- (void)closeAction:(NSSliderTouchBarItem *)sender
{
    [self.popoverTouchBarItem dismissPopover:sender];
}

- (void)sliderChanged:(NSSliderTouchBarItem *)sender
{
    //NSLog(@"slider changed");
}

@end
