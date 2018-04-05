/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 View controller responsible for NSTouchBarItem instances used with an NSTextView.
 */

#import "TextViewController.h"

static NSTouchBarCustomizationIdentifier TextViewCustomizationIdentifier = @"com.TouchBarCatalog.textViewController";
static NSTouchBarItemIdentifier TextViewItemIdentifier = @"com.TouchBarCatalog.textViewItem";

@interface TextViewController () <NSTouchBarDelegate, NSTextViewDelegate>

@property (strong) NSCustomTouchBarItem *touchBarItem;
@property (strong) IBOutlet NSTextView *textView;
@property (weak) IBOutlet NSButton *customTouchBarCheckbox;
@property BOOL useBoldText;

@end

#pragma mark -

@implementation TextViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _useBoldText = NO;
    
    // Note: If you ever want to show the NSTouchBar instance within this view controller do this:
    // [self.view.window makeFirstResponder:self.view];
}

- (IBAction)customTouchBarAction:(id)sender
{
    self.textView.automaticTextCompletionEnabled = !self.customTouchBarCheckbox.state;
    
    // Set to nil so makeTouchBar can be called again to re-create our NSTouchBarItem instances.
    self.touchBar = nil;
}

#pragma mark NSTouchBarProvider

- (NSTouchBar *)makeTouchBar
{
    NSTouchBar *bar = [[NSTouchBar alloc] init];
    bar.delegate = self;
    
    bar.customizationIdentifier = TextViewCustomizationIdentifier;
    
    // Set the default ordering of items.
    bar.defaultItemIdentifiers = @[TextViewItemIdentifier, NSTouchBarItemIdentifierOtherItemsProxy];
    
    bar.customizationAllowedItemIdentifiers = @[TextViewItemIdentifier];
    
    bar.principalItemIdentifier = TextViewItemIdentifier;
    
    return bar;
}

#pragma mark NSTouchBarDelegate

// This gets called while the NSTouchBar is being constructed, for each NSTouchBarItem to be created.
- (nullable NSTouchBarItem *)touchBar:(NSTouchBar *)touchBar makeItemForIdentifier:(NSTouchBarItemIdentifier)identifier
{
    if ([identifier isEqualToString:TextViewItemIdentifier])
    {
        NSButton *button = [NSButton buttonWithTitle:NSLocalizedString(@"Bold", @"") target:self action:@selector(textViewAction:)];
        
        _touchBarItem = [[NSCustomTouchBarItem alloc] initWithIdentifier:TextViewItemIdentifier];
        self.touchBarItem.view = button;
        self.touchBarItem.customizationLabel = NSLocalizedString(@"Bold Button", @"");
        
        return self.touchBarItem;
    }
    
    return nil;
}

- (void)toggleTextFace:(BOOL)bold
{
    // Change the text view's font to bold style.
    NSMutableAttributedString *text = [self.textView textStorage];
    NSUInteger face = bold ? NSBoldFontMask : NSUnboldFontMask;
    [text applyFontTraits:face range:NSMakeRange(0, text.length)];
}

- (void)textViewAction:(id)sender
{
    _useBoldText = !self.useBoldText;
    [self toggleTextFace:self.useBoldText];
    
    NSButton *buttonToChange = (NSButton *)self.touchBarItem.view;
    
    buttonToChange.title = self.useBoldText ? @"Normal" : @"Bold";
}


#pragma mark - NSTextViewDelegate

- (NSArray<NSTouchBarItemIdentifier> *)textView:(NSTextView *)textView shouldUpdateTouchBarItemIdentifiers:(NSArray<NSTouchBarItemIdentifier> *)identifiers
{
    if (self.customTouchBarCheckbox.state == NSOnState)
    {
        return [NSArray array];
    }
    else
    {
        return identifiers;
    }
}

@end
