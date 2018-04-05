/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 The master view controller giving access to all test cases in this sample.
 */

#import "MasterViewController.h"

@interface MasterViewController ()

@property (weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet NSArrayController *contentArray;

@end


#pragma mark -

// Key to the main dictionary containing all the test dictionaries.
static NSString *TestsKey = @"tests";

// Keys to the NSDictionary for each test item.
static NSString *TestNameKey = @"testName";
static NSString *TestKindKey = @"testKind";


@implementation MasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Load the tests only if the NSTouchBar class exists.
    if (NSClassFromString(@"NSTouchBar"))
    {
        // Load the tests from our plist database, add them to our array controller.
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"Tests" withExtension:@"plist"];
        NSDictionary *testDatabase = [[NSDictionary alloc] initWithContentsOfURL:url];
        NSArray *tests = testDatabase[TestsKey];
        for (NSDictionary *test in tests)
        {
            [self.contentArray addObject:test];
        }
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(selectionDidChange:)
                                                 name:NSTableViewSelectionDidChangeNotification
                                               object:self.tableView];
}

- (void)viewWillAppear
{
    [super viewWillAppear];
    
    // Start by showing the first button example.
    self.contentArray.selectionIndex = 0;
}

// Used when a table view selection has changed, to swap in a new detail view controller.
- (void)selectionDidChange:(NSNotification *)notification
{
    NSTableView *tableView = [notification object];
    NSInteger selectedItem = tableView.selectedRow;
    
    NSViewController *newDetailViewController = nil;
    NSSplitViewItem *newDetailSplitViewItem = nil;
    
    NSSplitViewController *splitViewController = (NSSplitViewController *)self.view.window.contentViewController;
    NSSplitViewItem *splitViewItem = splitViewController.splitViewItems[1];
    [splitViewController removeSplitViewItem:splitViewItem];
    
    // Remove us as the observer to the associated detail view controller's NSTouchBar instance.
    @try {
        NSViewController *vcToRemove = splitViewItem.viewController;
        [vcToRemove removeObserver:self forKeyPath:@"touchBar" context:@"touchBar"];
    } @catch(id anException) {
        // Do nothing, obviously it wasn't attached because an exception was thrown.
    }
    
    if (selectedItem == -1)
    {
        // We don't have a valid selection, so use the generic detail view controller.
        NSStoryboard *storyboard = [NSStoryboard storyboardWithName:@"Main" bundle: nil];
        newDetailViewController = [storyboard instantiateControllerWithIdentifier:@"DetailViewController"];
    }
    else
    {
        // We have a valid selection, so load the corresponding storyboard.
        NSDictionary *selectedTest = [self.contentArray.arrangedObjects objectAtIndex:selectedItem];
        NSString *whichViewControllerIdentifierID = selectedTest[TestKindKey];
        
        NSStoryboard *storyboard =
            [NSStoryboard storyboardWithName:whichViewControllerIdentifierID bundle:[NSBundle mainBundle]];
        newDetailViewController = [storyboard instantiateInitialController];
    }
    
    newDetailSplitViewItem =
        [NSSplitViewItem splitViewItemWithViewController:newDetailViewController];
    [splitViewController insertSplitViewItem:newDetailSplitViewItem atIndex:1];
    
    // Here we want to bind or sync our own NSTouchBar instance with the detail view controller.
    [self unbind:@"touchBar"];
    [self bind:@"touchBar" toObject:newDetailViewController withKeyPath:@"touchBar" options:nil];
}

@end
