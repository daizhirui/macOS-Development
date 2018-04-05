/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 View controller used for the view-based table view of images, using a NSScrubberImageItemView without subclassing.
 */

#import "BackgroundImagesViewController.h"
#import "BackgroundViewController.h"
#import "TitleBarAccessoryViewController.h"
#import "ScrubberViewController.h"
#import "PhotoManager.h"

static NSTouchBarCustomizationIdentifier ScrubberCustomizationIdentifier =
    @"com.TouchBarCatalog.backgroudWindowScrubber";
static NSTouchBarItemIdentifier ScrubberItemIdentifier =
    @"com.TouchBarCatalog.backgroudWindowScrubberItem";

@interface BackgroundImagesViewController () <NSTouchBarDelegate, NSScrubberDelegate, NSScrubberDataSource, PhotoManagerDelegate>

@property (nonatomic, weak) IBOutlet NSScrollView *scrollView;
@property (nonatomic, weak) IBOutlet NSTableView *tableView;
@property (nonatomic, weak) IBOutlet NSProgressIndicator *progressIndicator;

@property (nonatomic, strong) IBOutlet NSArrayController *myContentArray;
@property (nonatomic, strong) NSMutableArray *tableContents;

@end


#pragma mark -

@implementation BackgroundImagesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Listen for table view selection changes.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(selectionDidChange:)
                                                 name:NSTableViewSelectionDidChangeNotification
                                               object:self.tableView];
    
    self.scrollView.wantsLayer = TRUE;
    self.scrollView.layer.cornerRadius = 6;
    
    // Load the pictures for our scrubber content.
    [self fetchPictureResources];
}

- (void)viewDidAppear
{
    [super viewDidAppear];
    
    [self.view.window makeFirstResponder:self.view];
}

- (void)displayPhotos {
    [self willChangeValueForKey:@"tableContents"];
    _tableContents = PhotoManager.shared.photos;
    [self didChangeValueForKey:@"tableContents"];
    
    self.touchBar = nil;   // Force update our NSTouchBar.
    
    [self.progressIndicator stopAnimation:self];
    self.progressIndicator.hidden = YES;
    self.scrollView.hidden = NO;
}

// Loads all the Desktop Pictures on this system, to be used for the image-based NSScrubber in the touch bar item, and for table view in the NSPopover.
- (void)fetchPictureResources
{
    if ([PhotoManager shared].loadComplete) {
        [self displayPhotos];
    } else {
        // The PhotoManager has not loaded all the photos. This could take a while, show the progress indicator.
        PhotoManager.shared.delegate = self;  // So we can be notified when the photos have been loaded.
        self.progressIndicator.hidden = false;
        self.scrollView.hidden = true;
        [self.progressIndicator startAnimation:self];
    }
}


#pragma mark NSTouchBarProvider

- (NSTouchBar *)makeTouchBar
{
    NSTouchBar *bar = [[NSTouchBar alloc] init];
    bar.delegate = self;
    
    bar.customizationIdentifier = ScrubberCustomizationIdentifier;
    
    // Set the default ordering of items.
    bar.defaultItemIdentifiers = @[ScrubberItemIdentifier, NSTouchBarItemIdentifierOtherItemsProxy];
    
    bar.customizationAllowedItemIdentifiers = @[ScrubberItemIdentifier];
    
    bar.principalItemIdentifier = ScrubberItemIdentifier;
    
    return bar;
}


#pragma mark - NSScrubberDataSource

static NSString *imageScrubberItemIdentifier = @"thumbnailItem";

- (NSInteger)numberOfItemsForScrubber:(NSScrubber *)scrubber
{
    return self.tableContents.count;
}

// Scrubber is asking for a custom view represention for a particuler item index.
- (NSScrubberItemView *)scrubber:(NSScrubber *)scrubber viewForItemAtIndex:(NSInteger)index
{
    NSScrubberImageItemView *itemView = [scrubber makeItemWithIdentifier:@"thumbnailItem" owner:nil];
    if (index < self.tableContents.count)
    {
        NSDictionary *itemDict = self.tableContents[index];
        itemView.image = [itemDict valueForKey:kImageKey];
    }
    
    itemView.imageView.imageScaling = NSImageScaleProportionallyDown;
    itemView.imageAlignment = NSImageAlignCenter;
    
    return itemView;
}


#pragma mark - NSScrubberFlowLayoutDelegate

// Scrubber is asking for the size for a particular item.
- (NSSize)scrubber:(NSScrubber *)scrubber layout:(NSScrubberFlowLayout *)layout sizeForItemAtIndex:(NSInteger)itemIndex
{
    return NSMakeSize(50, 30);
}


#pragma mark - NSScrubberDelegate

// User selected an image from the NSScrubber touch bar item.
- (void)scrubber:(NSScrubber *)scrubber didSelectItemAtIndex:(NSInteger)selectedIndex
{
    [self chooseImageWithIndex:selectedIndex];
}


#pragma mark NSTouchBarDelegate

// This gets called while the NSTouchBar is being constructed, for each NSTouchBarItem to be created.
- (nullable NSTouchBarItem *)touchBar:(NSTouchBar *)touchBar makeItemForIdentifier:(NSTouchBarItemIdentifier)identifier
{
    if ([identifier isEqualToString:ScrubberItemIdentifier])
    {
        // Create the scrubber touch bar item that uses the Desktop Pictures.
        NSCustomTouchBarItem *scrubberItem = [[NSCustomTouchBarItem alloc] initWithIdentifier:ScrubberItemIdentifier];
        
        NSScrubber *scrubber = [[NSScrubber alloc] initWithFrame:NSMakeRect(0, 0, 320, 30)];
        scrubber.delegate = self;   // This is so we can respond to selection.
        scrubber.dataSource = self; // This is so we can determine the content.
        
        [scrubber registerClass:[NSScrubberImageItemView class] forItemIdentifier:imageScrubberItemIdentifier];
            
        // For the image scrubber, we want the control to draw a fade effect to indicate that there is additional unscrolled content.
        scrubber.showsAdditionalContentIndicators = YES;

        scrubber.selectedIndex = 0; // Always select the first item in the scrubber.
        
        scrubberItem.customizationLabel = NSLocalizedString(@"Choose Photo", @"");
        
        NSScrubberLayout *scrubberLayout = [[NSScrubberFlowLayout alloc] init];
        scrubber.scrubberLayout = scrubberLayout;

        scrubber.mode = NSScrubberModeFree;
        scrubber.selectionBackgroundStyle = nil;
        scrubber.selectionOverlayStyle = nil;
        
        // Set the layout constraints on this scrubber so that it's 400 pixels wide.
        NSDictionary *items = NSDictionaryOfVariableBindings(scrubber);
        NSArray *theConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[scrubber(400)]" options:0 metrics:nil views:items];
        [NSLayoutConstraint activateConstraints:theConstraints];
        
        scrubberItem.view = scrubber;
        
        return scrubberItem;
    }
    
    return nil;
}

- (void)chooseImageWithIndex:(NSInteger)imageIndex
{
    // Process the chosen image and dismiss us as the popover.
    TitleBarAccessoryViewController *presentingViewController = (TitleBarAccessoryViewController *)self.presentingViewController;
    BackgroundViewController *backgroundViewController = (BackgroundViewController *)presentingViewController.view.window.contentViewController;
        
    NSDictionary *itemDict = self.tableContents[imageIndex];
    
    NSURL *fileURL = [itemDict valueForKey:kImageURLKey];
    NSImage *fullImage = [[NSImage alloc] initWithContentsOfURL:fileURL];
    backgroundViewController.imageView.image = fullImage;
    
    [self dismissViewController:self];
    presentingViewController.openingViewController = nil;
}


#pragma mark - Notifications

// -------------------------------------------------------------------------------
//  Listens for changes table view row selection
// -------------------------------------------------------------------------------
- (void)selectionDidChange:(NSNotification *)notification
{
    NSInteger selectedRow = [self.tableView selectedRow];
    if (selectedRow != -1)
    {
        [self chooseImageWithIndex:selectedRow];
    }
}

#pragma mark - PhotoManagerDelegate

- (void)didLoadPhotos:(NSArray *)photos {
    [self displayPhotos];
}

@end
