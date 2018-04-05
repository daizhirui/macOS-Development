/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 View controller responsible for showing images you can use in an NSTouchBar instance.
 */

#import "TouchBarImagesViewController.h"
#import "CollectionViewItem.h"

@interface TouchBarImagesViewController () <NSCollectionViewDataSource, NSCollectionViewDelegate>

@property (weak) IBOutlet NSCollectionView *theCollectionView;
@property (strong) NSArray *imageNames;

@property (strong) IBOutlet NSTextField *touchBarLabel;
@property (strong) IBOutlet NSButton *touchBarButton;

@end


#pragma mark -

@implementation TouchBarImagesViewController

- (void)viewDidLoad
{
	[super viewDidLoad];

    // No selection yet, so hide our NSTouchBar content.
    self.touchBarButton.hidden = YES;
    self.touchBarLabel.hidden = YES;
    
	self.theCollectionView.dataSource = self;
	self.theCollectionView.delegate = self;
	
	[self.theCollectionView registerClass:[CollectionViewItem class] forItemWithIdentifier:@"imageItem"];
	
	self.imageNames = @[
						NSImageNameTouchBarAddDetailTemplate,
                            // for showing additional detail for an item.
						NSImageNameTouchBarAddTemplate,
                            // for creating a new item.
						NSImageNameTouchBarAlarmTemplate,
                            // for setting or showing an alarm.
						NSImageNameTouchBarAudioInputMuteTemplate,
                            // for muting audio input or denoting that audio input is muted.
						NSImageNameTouchBarAudioInputTemplate,
                            // for denoting audio input.
						NSImageNameTouchBarAudioOutputMuteTemplate,
                            // for muting audio output or for denoting that audio output is muted.
						NSImageNameTouchBarAudioOutputVolumeHighTemplate,
                            // for setting the audio output volume to a high level, or for denoting that it is set to a high level.
						NSImageNameTouchBarAudioOutputVolumeLowTemplate,
                            // for setting the audio output volume to a low level, or for denoting that it is set to a low level.
						NSImageNameTouchBarAudioOutputVolumeMediumTemplate,
                            // for setting the audio output volume to a medium level, or for denoting that it is set to a medium level.
						NSImageNameTouchBarAudioOutputVolumeOffTemplate,
                            // for setting the audio output volume to silent, or for denoting that it is set to silent.
						NSImageNameTouchBarBookmarksTemplate,
                            // for showing app-specific bookmarks.
						NSImageNameTouchBarColorPickerFill,
                            // for showing a color picker so the user can select a fill color.
						NSImageNameTouchBarColorPickerFont,
                            // for showing a color picker so the user can select a text color.
                        NSImageNameTouchBarColorPickerStroke,
                            // for showing a color picker so the user can select a stroke color.
						NSImageNameTouchBarCommunicationAudioTemplate,
                            // for initiating or denoting audio communication.
						NSImageNameTouchBarCommunicationVideoTemplate,
                            // for initiating or denoting video communication.
						NSImageNameTouchBarComposeTemplate,
                            // for opening a new document or view in edit mode.
						NSImageNameTouchBarDeleteTemplate,
                            // for deleting the current or selected item.
						NSImageNameTouchBarDownloadTemplate,
                            // for downloading an item.
						NSImageNameTouchBarEnterFullScreenTemplate,
                            // for entering full screen mode.
						NSImageNameTouchBarExitFullScreenTemplate,
                            // for exiting full screen mode.
						NSImageNameTouchBarFastForwardTemplate,
                            // for moving forward through media playback or slides.
						NSImageNameTouchBarFolderCopyToTemplate,
                            // for copying an item to a destination.
						NSImageNameTouchBarFolderMoveToTemplate,
                            // for moving an item to a destination.
						NSImageNameTouchBarFolderTemplate,
                            // for opening or representing a folder.
						NSImageNameTouchBarGetInfoTemplate,
                            // for showing information about an item.
						NSImageNameTouchBarGoBackTemplate,
                            // for returning to the previous screen or location.
						NSImageNameTouchBarGoDownTemplate,
                            // for moving to the next item in a list.
						NSImageNameTouchBarGoForwardTemplate,
                            // for moving to the next screen or location.
						NSImageNameTouchBarGoUpTemplate,
                            // for moving to the previous item in a list.
						NSImageNameTouchBarHistoryTemplate,
                            // for showing history information, such as recent downloads.
						NSImageNameTouchBarIconViewTemplate,
                            // for showing items in an icon view.
						NSImageNameTouchBarListViewTemplate,
                            // for showing items in a list view.
						NSImageNameTouchBarMailTemplate,
                            // for creating an email message.
						NSImageNameTouchBarNewFolderTemplate,
                            // for creating a new folder.
						NSImageNameTouchBarNewMessageTemplate,
                            // for creating a new message or for denoting the use of messaging.
						NSImageNameTouchBarOpenInBrowserTemplate,
                            // for opening an item in the user’s browser.
						NSImageNameTouchBarPauseTemplate,
                            // for pausing media playback or slides.
						NSImageNameTouchBarPlayheadTemplate,
                            // for the play position for horizontal time-based controls.
						NSImageNameTouchBarPlayPauseTemplate,
                            // for toggling between playing and pausing media or slides.
						NSImageNameTouchBarPlayTemplate,
                            // for starting or resuming playback of media or slides.
						NSImageNameTouchBarQuickLookTemplate,
                            // for opening an item in Quick Look.
						NSImageNameTouchBarRecordStartTemplate,
                            // for starting recording.
						NSImageNameTouchBarRecordStopTemplate,
                            // for stopping recording or stopping playback of media or slides.
						NSImageNameTouchBarRefreshTemplate,
                            // for refreshing displayed data.
						NSImageNameTouchBarRewindTemplate,
                            // for moving backwards through media or slides.
						NSImageNameTouchBarRotateLeftTemplate,
                            // for rotating an item counterclockwise.
						NSImageNameTouchBarRotateRightTemplate,
                            // for rotating an item clockwise.
						NSImageNameTouchBarSearchTemplate,
                            // for showing a search field or for initiating a search.
						NSImageNameTouchBarShareTemplate,
                            // for sharing content with others directly or via social media.
						NSImageNameTouchBarSidebarTemplate,
                            // for showing a sidebar in the current view.
						NSImageNameTouchBarSkipAhead15SecondsTemplate,
                            // for skipping ahead 15 seconds during media playback.
						NSImageNameTouchBarSkipAhead30SecondsTemplate,
                            // for skipping ahead 30 seconds during media playback.
						NSImageNameTouchBarSkipAheadTemplate,
                            // for skipping to the next chapter or location during media playback.
						NSImageNameTouchBarSkipBack15SecondsTemplate,
                            // for skipping back 15 seconds during media playback.
						NSImageNameTouchBarSkipBack30SecondsTemplate,
                            // for skipping back 30 seconds during media playback.
						NSImageNameTouchBarSkipBackTemplate,
                            // for skipping to the previous chapter or location during media playback.
						NSImageNameTouchBarSkipToEndTemplate,
                            // for skipping to the end of media playback.
                        NSImageNameTouchBarSkipToStartTemplate,
                            // for skipping to the start of media playback.
						NSImageNameTouchBarSlideshowTemplate,
                            // for starting a slideshow.
						NSImageNameTouchBarTagIconTemplate,
                            // for applying a tag to an item.
						NSImageNameTouchBarTextBoldTemplate,
                            // for making selected text bold.
						NSImageNameTouchBarTextBoxTemplate,
                            // for inserting a text box.
						NSImageNameTouchBarTextCenterAlignTemplate,
                            // for centering text.
						NSImageNameTouchBarTextItalicTemplate,
                            // for making selected text italic.
						NSImageNameTouchBarTextJustifiedAlignTemplate,
                            // for fully justifying text.
						NSImageNameTouchBarTextLeftAlignTemplate,
                            // for aligning text to the left.
						NSImageNameTouchBarTextListTemplate,
                            // for inserting a list or converting text to list form.
						NSImageNameTouchBarTextRightAlignTemplate,
                            // for aligning text to the right.
						NSImageNameTouchBarTextStrikethroughTemplate,
                            // for striking through text.
						NSImageNameTouchBarTextUnderlineTemplate,
                            // for underlining text.
						NSImageNameTouchBarUserAddTemplate,
                            // for creating a new user account.
						NSImageNameTouchBarUserGroupTemplate,
                            // for showing or representing a group of users.
						NSImageNameTouchBarUserTemplate
                            // for showing or representing user information.
                        ];
}

- (void)collectionView:(NSCollectionView *)collectionView didSelectItemsAtIndexPaths:(NSSet<NSIndexPath *> *)indexPaths
{
    NSIndexPath *selectedItem = [indexPaths allObjects][0];
    
    // Change the button and label in the NSTouchBar instance as feedback.
    self.touchBarLabel.stringValue = self.imageNames[selectedItem.item];
    self.touchBarLabel.hidden = NO;
    
    NSImage	*itemImage = [NSImage imageNamed:self.imageNames[selectedItem.item]];
    self.touchBarButton.image = itemImage;
    self.touchBarButton.hidden = NO;
    
    // Draw the selected collection view item.
    CollectionViewItem *item = (CollectionViewItem *)[collectionView itemAtIndexPath:selectedItem];
    item.view.layer.backgroundColor = [[NSColor controlHighlightColor] CGColor];
}

- (void)collectionView:(NSCollectionView *)collectionView didDeselectItemsAtIndexPaths:(NSSet<NSIndexPath *> *)indexPaths
{
    // Draw the unselected collection view item.
    NSIndexPath *selectedItem = [indexPaths allObjects][0];
    CollectionViewItem *item = (CollectionViewItem *)[collectionView itemAtIndexPath:selectedItem];
    item.view.layer.backgroundColor = [[NSColor clearColor] CGColor];
    
    self.touchBarButton.image = nil;
    self.touchBarButton.hidden = YES;
    self.touchBarLabel.stringValue = @"";
    self.touchBarLabel.hidden = YES;
}

- (NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return self.imageNames.count;
}

- (NSCollectionViewItem *)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath
{
	CollectionViewItem *item = [collectionView makeItemWithIdentifier:@"imageItem" forIndexPath:indexPath];
	NSImage	*itemImage = [NSImage imageNamed:self.imageNames[indexPath.item]];
	item.theImageView.image = itemImage;

	return item;
}

@end
