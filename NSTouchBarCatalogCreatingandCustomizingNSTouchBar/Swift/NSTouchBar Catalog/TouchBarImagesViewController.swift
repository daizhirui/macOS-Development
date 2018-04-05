/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 View controller responsible for showing images you can use in a NSTouchBar.
 */

import Cocoa

@available(OSX 10.12.2, *)
class TouchBarImagesViewController: NSViewController {
    
    @IBOutlet weak var theCollectionView: NSCollectionView!
    
    @IBOutlet weak var touchBarLabel: NSTextField!
    @IBOutlet weak var touchBarButton: NSButton!
    
    let imageNames = [
        NSImage.Name.touchBarAddDetailTemplate,
            // for showing additional detail for an item.
        NSImage.Name.touchBarAddTemplate,
            // for creating a new item.
        NSImage.Name.touchBarAlarmTemplate,
            // for setting or showing an alarm.
        NSImage.Name.touchBarAudioInputMuteTemplate,
            // for muting audio input or denoting that audio input is muted.
        NSImage.Name.touchBarAudioInputTemplate,
            // for denoting audio input.
        NSImage.Name.touchBarAudioOutputMuteTemplate,
            // for muting audio output or for denoting that audio output is muted.
        NSImage.Name.touchBarAudioOutputVolumeHighTemplate,
            // for setting the audio output volume to a high level, or for denoting that it is set to a high level.
        NSImage.Name.touchBarAudioOutputVolumeLowTemplate,
            // for setting the audio output volume to a low level, or for denoting that it is set to a low level.
        NSImage.Name.touchBarAudioOutputVolumeMediumTemplate,
            // for setting the audio output volume to a medium level, or for denoting that it is set to a medium level.
        NSImage.Name.touchBarAudioOutputVolumeOffTemplate,
            // for setting the audio output volume to silent, or for denoting that it is set to silent.
        NSImage.Name.touchBarBookmarksTemplate,
            // for showing app-specific bookmarks.
        NSImage.Name.touchBarColorPickerFill,
            // for showing a color picker so the user can select a fill color.
        NSImage.Name.touchBarColorPickerFont,
            // for showing a color picker so the user can select a text color.
        NSImage.Name.touchBarColorPickerStroke,
            // for showing a color picker so the user can select a stroke color.
        NSImage.Name.touchBarCommunicationAudioTemplate,
            // for initiating or denoting audio communication.
        NSImage.Name.touchBarCommunicationVideoTemplate,
            // for initiating or denoting video communication.
        NSImage.Name.touchBarComposeTemplate,
            // for opening a new document or view in edit mode.
        NSImage.Name.touchBarDeleteTemplate,
            // for deleting the current or selected item.
        NSImage.Name.touchBarDownloadTemplate,
            // for downloading an item.
        NSImage.Name.touchBarEnterFullScreenTemplate,
            // for entering full screen mode.
        NSImage.Name.touchBarExitFullScreenTemplate,
            // for exiting full screen mode.
        NSImage.Name.touchBarFastForwardTemplate,
            // for moving forward through media playback or slides.
        NSImage.Name.touchBarFolderCopyToTemplate,
            // for copying an item to a destination.
        NSImage.Name.touchBarFolderMoveToTemplate,
            // for moving an item to a destination.
        NSImage.Name.touchBarFolderTemplate,
            // for opening or representing a folder.
        NSImage.Name.touchBarGetInfoTemplate,
            // for showing information about an item.
        NSImage.Name.touchBarGoBackTemplate,
            // for returning to the previous screen or location.
        NSImage.Name.touchBarGoDownTemplate,
            // for moving to the next item in a list.
        NSImage.Name.touchBarGoForwardTemplate,
            // for moving to the next screen or location.
        NSImage.Name.touchBarGoUpTemplate,
            // for moving to the previous item in a list.
        NSImage.Name.touchBarHistoryTemplate,
            // for showing history information, such as recent downloads.
        NSImage.Name.touchBarIconViewTemplate,
            // for showing items in an icon view.
        NSImage.Name.touchBarListViewTemplate,
            // for showing items in a list view.
        NSImage.Name.touchBarMailTemplate,
            // for creating an email message.
        NSImage.Name.touchBarNewFolderTemplate,
            // for creating a new folder.
        NSImage.Name.touchBarNewMessageTemplate,
            // for creating a new message or for denoting the use of messaging.
        NSImage.Name.touchBarOpenInBrowserTemplate,
            // for opening an item in the user’s browser.
        NSImage.Name.touchBarPauseTemplate,
            // for pausing media playback or slides.
        NSImage.Name.touchBarPlayheadTemplate,
            // for the play position for horizontal time-based controls.
        NSImage.Name.touchBarPlayPauseTemplate,
            // for toggling between playing and pausing media or slides.
        NSImage.Name.touchBarPlayTemplate,
            // for starting or resuming playback of media or slides.
        NSImage.Name.touchBarQuickLookTemplate,
            // for opening an item in Quick Look.
        NSImage.Name.touchBarRecordStartTemplate,
            // for starting recording.
        NSImage.Name.touchBarRecordStopTemplate,
            // for stopping recording or stopping playback of media or slides.
        NSImage.Name.touchBarRefreshTemplate,
            // for refreshing displayed data.
        NSImage.Name.touchBarRewindTemplate,
            // for moving backwards through media or slides.
        NSImage.Name.touchBarRotateLeftTemplate,
            // for rotating an item counterclockwise.
        NSImage.Name.touchBarRotateRightTemplate,
            // for rotating an item clockwise.
        NSImage.Name.touchBarSearchTemplate,
            // for showing a search field or for initiating a search.
        NSImage.Name.touchBarShareTemplate,
            // for sharing content with others directly or via social media.
        NSImage.Name.touchBarSidebarTemplate,
            // for showing a sidebar in the current view.
        NSImage.Name.touchBarSkipAhead15SecondsTemplate,
            // for skipping ahead 15 seconds during media playback.
        NSImage.Name.touchBarSkipAhead30SecondsTemplate,
            // for skipping ahead 30 seconds during media playback.
        NSImage.Name.touchBarSkipAheadTemplate,
            // for skipping to the next chapter or location during media playback.
        NSImage.Name.touchBarSkipBack15SecondsTemplate,
            // for skipping back 15 seconds during media playback.
        NSImage.Name.touchBarSkipBack30SecondsTemplate,
            // for skipping back 30 seconds during media playback.
        NSImage.Name.touchBarSkipBackTemplate,
            // for skipping to the previous chapter or location during media playback.
        NSImage.Name.touchBarSkipToEndTemplate,
            // for skipping to the end of media playback.
        NSImage.Name.touchBarSkipToStartTemplate,
            // for skipping to the start of media playback.
        NSImage.Name.touchBarSlideshowTemplate,
            // for starting a slideshow.
        NSImage.Name.touchBarTagIconTemplate,
            // for applying a tag to an item.
        NSImage.Name.touchBarTextBoldTemplate,
            // for making selected text bold.
        NSImage.Name.touchBarTextBoxTemplate,
            // for inserting a text box.
        NSImage.Name.touchBarTextCenterAlignTemplate,
            // for centering text.
        NSImage.Name.touchBarTextItalicTemplate,
            // for making selected text italic.
        NSImage.Name.touchBarTextJustifiedAlignTemplate,
            // for fully justifying text.
        NSImage.Name.touchBarTextLeftAlignTemplate,
            // for aligning text to the left.
        NSImage.Name.touchBarTextListTemplate,
            // for inserting a list or converting text to list form.
        NSImage.Name.touchBarTextRightAlignTemplate,
            // for aligning text to the right.
        NSImage.Name.touchBarTextStrikethroughTemplate,
            // for striking through text.
        NSImage.Name.touchBarTextUnderlineTemplate,
            // for underlining text.
        NSImage.Name.touchBarUserAddTemplate,
            // for creating a new user account.
        NSImage.Name.touchBarUserGroupTemplate,
            // for showing or representing a group of users.
        NSImage.Name.touchBarUserTemplate
            // for showing or representing user information.
    ]
    
    // MARK: View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        touchBarLabel.isHidden = true
        touchBarButton.isHidden = true
        
        theCollectionView.dataSource = self
        theCollectionView.delegate = self
        
        theCollectionView.register(CollectionViewItem.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier("imageItem"))
    }
}

// MARK: - NSCollectionView

@available(OSX 10.12.2, *)
extension TouchBarImagesViewController:  NSCollectionViewDataSource, NSCollectionViewDelegate {
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
    }
    
    func collectionView(_ collectionView: NSCollectionView,
                        itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        var returnCollectionViewItem = NSCollectionViewItem()
        if let item =
            collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "imageItem"),
                                    for: indexPath) as? CollectionViewItem {
            item.theImageView.image = NSImage(named: imageNames[indexPath.item])
            returnCollectionViewItem = item
        }
        return returnCollectionViewItem
    }
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        let indexPathArray = Array(indexPaths)
        let selectedItem = indexPathArray[0]
        
        // Change the button and label in the NSTouchBar as feedback.
        touchBarLabel.stringValue = imageNames[selectedItem.item].rawValue
        touchBarLabel.isHidden = false
        
        touchBarButton.image = NSImage(named: imageNames[selectedItem.item])
        touchBarButton.isHidden = false
        
        // Draw the selected collection view item.
        if let item = collectionView.item(at: selectedItem) as? CollectionViewItem {
            item.view.layer?.backgroundColor = NSColor.controlHighlightColor.cgColor
        }
    }
    
    func collectionView(_ collectionView: NSCollectionView, didDeselectItemsAt indexPaths: Set<IndexPath>) {
        // Draw the unselected collection view item.
        let indexPathArray = Array(indexPaths)
        let selectedItem = indexPathArray[0]
        
        if let item = collectionView.item(at: selectedItem) as? CollectionViewItem {
            item.view.layer?.backgroundColor = NSColor.clear.cgColor
        }
        touchBarButton.image = nil
        touchBarButton.isHidden = true
        touchBarLabel.stringValue = ""
        touchBarLabel.isHidden = true
    }
    
}

