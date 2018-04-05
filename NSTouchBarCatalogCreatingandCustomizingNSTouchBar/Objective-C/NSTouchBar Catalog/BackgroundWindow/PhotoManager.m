/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 Singlelton object used to asychronously load all photos from the Desktop Pictures folder.
 */

@import Cocoa;
@import Foundation;

#import "PhotoManager.h"

NSString *kImageNameKey = @"name";
NSString *kImageKey = @"image";
NSString *kImageURLKey = @"url";

@implementation PhotoManager: NSObject

+ (PhotoManager *)shared
{
    static PhotoManager *photoManager;  // our singleton PhotoManager controller.
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        photoManager = [[PhotoManager alloc] init];
    });
    return photoManager;
}

- (instancetype)init
{
    self = [super init];
    if (self != nil)
    {
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), ^{
            NSURL *picturesURL =
            [[[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSLocalDomainMask] lastObject];
            picturesURL = [picturesURL URLByAppendingPathComponent:@"Desktop Pictures"];
            
            NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtURL:picturesURL
                                                                     includingPropertiesForKeys:nil
                                                                                        options:NSDirectoryEnumerationSkipsHiddenFiles
                                                                                   errorHandler:nil];
            _photos = [NSMutableArray array];
            
            // Here we will be loading each image, and cache their reduced thumbnail, name and url.
            for (NSURL *file in enumerator)
            {
                NSImage *fullImage = [[NSImage alloc] initWithContentsOfURL:file];
                NSSize imageSize = [fullImage size];
                
                if (imageSize.width > 0 && imageSize.height > 0)
                {
                    CGFloat thumbnailHeight = 30;
                    NSSize thumbnailSize = NSMakeSize(ceil(thumbnailHeight * imageSize.width / imageSize.height), thumbnailHeight);
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSImage *thumbnail = [[NSImage alloc] initWithSize:thumbnailSize];
                        
                        [thumbnail lockFocus];
                        [fullImage drawInRect:NSMakeRect(0, 0, thumbnailSize.width, thumbnailSize.height) fromRect:NSMakeRect(0, 0, imageSize.width, imageSize.height) operation:NSCompositingOperationSourceOver fraction:1.0];
                        [thumbnail unlockFocus];
                        
                        NSString *imageName = [file lastPathComponent];
                        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                     imageName, kImageNameKey,
                                                     thumbnail, kImageKey,
                                                     file, kImageURLKey,
                                                     // You can add any more pertinent information for this image object here.
                                                     nil];
                        [self.photos addObject:dict];
                    });
                }
            }
            
            _loadComplete = YES;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate didLoadPhotos:self.photos];
            });
        });
    }
	return self;
}

@end


