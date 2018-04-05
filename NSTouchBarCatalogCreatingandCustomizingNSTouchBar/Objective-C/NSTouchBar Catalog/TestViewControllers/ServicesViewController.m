/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 View controller responsible for showing NSSharingServicePickerTouchBarItem in an NSTouchBar instance.
 */

#import "ServicesViewController.h"

static NSTouchBarCustomizationIdentifier SharingCustomizationIdentifier = @"com.TouchBarCatalog.sharingViewController";
static NSTouchBarItemIdentifier ServicesItemIdentifier = @"com.TouchBarCatalog.sharing";

@interface ServicesViewController () <NSTouchBarDelegate, NSSharingServicePickerTouchBarItemDelegate, NSSharingServiceDelegate>

@property (strong) NSSharingServicePickerTouchBarItem *servicesTouchBarItem;
@property (strong) NSImage *imageToSend;

@end


#pragma mark -

@implementation ServicesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _imageToSend = [NSImage imageNamed:@"Sunset_2"];
}

#pragma mark NSTouchBarProvider

- (NSTouchBar *)makeTouchBar
{
    NSTouchBar *bar = [[NSTouchBar alloc] init];
    bar.delegate = self;
    
    bar.customizationIdentifier = SharingCustomizationIdentifier;
    
    // Set the default ordering of items.
    bar.defaultItemIdentifiers =
        @[ServicesItemIdentifier, NSTouchBarItemIdentifierOtherItemsProxy];
    
    bar.customizationAllowedItemIdentifiers = @[ServicesItemIdentifier];
    
    bar.principalItemIdentifier = ServicesItemIdentifier;
    
    return bar;
}

#pragma mark NSTouchBarDelegate

// This gets called while the NSTouchBar is being constructed, for each NSTouchBarItem to be created.
- (nullable NSTouchBarItem *)touchBar:(NSTouchBar *)touchBar makeItemForIdentifier:(NSTouchBarItemIdentifier)identifier
{
    if ([identifier isEqualToString:ServicesItemIdentifier])
    {
        if (self.servicesTouchBarItem == nil)
        {
            _servicesTouchBarItem = [[NSSharingServicePickerTouchBarItem alloc] initWithIdentifier:identifier];
            self.servicesTouchBarItem.delegate = self;
        }
        return self.servicesTouchBarItem;
    }
    
    return nil;
}


#pragma mark - NSSharingServicePickerTouchBarItemDelegate

- (NSArray *)itemsForSharingServicePickerTouchBarItem:(NSSharingServicePickerTouchBarItem *)pickerTouchBarItem
{
    return @[self.imageToSend];
}


#pragma mark - NSSharingServiceDelegate

- (id<NSSharingServiceDelegate>)sharingServicePicker:(NSSharingServicePicker *)sharingServicePicker delegateForSharingService:(NSSharingService *)sharingService
{
    return self;
}

- (NSRect)sharingService:(NSSharingService *)sharingService sourceFrameOnScreenForShareItem:(id)item
{
    return NSMakeRect(0, 0, self.imageToSend.size.width, self.imageToSend.size.height);
}

- (NSWindow *)sharingService:(NSSharingService *)sharingService sourceWindowForShareItems:(NSArray *)items sharingContentScope:(NSSharingContentScope *)sharingContentScope
{
    return [self.view window];
}

- (NSImage *)sharingService:(NSSharingService *)sharingService transitionImageForShareItem:(id)item contentRect:(NSRect *)contentRect
{
    return (NSImage *)item;
}

@end
