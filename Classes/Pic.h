//
//  Pic.h
//  PicMill
//
//  Created by Xavier Damman on 5/22/10.
//  Copyright 2010 Kwenti inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageLoader.h"

@interface Pic : ImageLoader {
	
	NSString *title;
	NSString *text;
	NSString *source;
	NSURL *source_url;
	NSURL *thumbnail;
	NSURL *image;
	NSDate *created_at;
}

- (id) initWithDictionary:(NSDictionary *)dictionnary;
- (NSString *)description;

- (UIImage *)getImage;
- (UIImage *)getThumbnail;

- (NSString *)getDate;

@property (retain) NSString *title;
@property (retain) NSString *source;
@property (retain) NSString *text;
@property (retain) NSURL *thumbnail;
@property (retain) NSURL *image;
@property (retain) NSDate *created_at;

@end
