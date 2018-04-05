/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 Singlelton object used to asychronously load all photos from the Desktop Pictures folder.
 */

extern NSString *kImageNameKey;
extern NSString *kImageKey;
extern NSString *kImageURLKey;

@protocol PhotoManagerDelegate;

@interface PhotoManager: NSObject

@property (strong) NSMutableArray *photos;
@property (assign) BOOL loadComplete;

@property (nonatomic, weak, readwrite) id<PhotoManagerDelegate> delegate;

+ (PhotoManager *)shared;

@end

@protocol PhotoManagerDelegate <NSObject>

- (void)didLoadPhotos:(NSArray *)photos;

@end

