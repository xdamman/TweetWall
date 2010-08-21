//
//  Tweet.h
//  Timelines
//
//  Created by Xavier Damman on 4/17/10.
//  Copyright 2010 xhead software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tweet : NSObject
{
	NSString	*screenName;
	NSURL		*avatar;
	NSString	*content;
	NSString	*type;
	NSURL		*permalink;
	NSDate		*timestamp;
	NSURL		*image;
	NSURL		*thumbnail;
	float		id;
}

- (id) initWithDictionary:(NSDictionary *)tweetData;

@property (copy) NSString *screenName;
@property (copy) NSString *content;
@property (copy) NSString *type;
@property (copy) NSURL *permalink;
@property (copy) NSURL *avatar;
@property (copy) NSDate *timestamp;
@property (copy) NSURL *image;
@property (copy) NSURL *thumbnail;

@end
