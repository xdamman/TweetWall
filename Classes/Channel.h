//
//  Channel.h
//  PicMill
//
//  Created by Xavier Damman on 5/22/10.
//  Copyright 2010 Kwenti inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageLoader.h"


@interface Channel : ImageLoader {

	NSString *name;
	NSString *description;
	NSURL *image;
	NSURL *thumbnail;
	NSDate *updated_at;
	NSNumber *identifier;
}

- (id) initWithDictionary:(NSDictionary *)dictionnary;
- (UIImage *)getImage;
- (UIImage *)getThumbnail;
- (NSString *)description;

@property (retain) NSNumber *identifier;
@property (retain) NSString *name;
@property (retain) NSString *description;
@property (retain) NSURL *thumbnail;
@property (retain) NSURL *image;
@property (retain) NSDate *updated_at;

@end
