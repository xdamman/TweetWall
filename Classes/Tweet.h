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
	NSDictionary *user;
	float		id;
}

- (id) initWithDictionary:(NSDictionary *)tweetData;
- (void) getUserInfoThread;

@property (nonatomic,retain) NSString *screenName;
@property (nonatomic,retain) NSDictionary *user;
@property (nonatomic,retain) NSString *content;
@property (nonatomic,retain) NSString *type;
@property (nonatomic,retain) NSURL *permalink;
@property (nonatomic,retain) NSURL *avatar;
@property (nonatomic,retain) NSDate *timestamp;
@property (nonatomic,retain) NSURL *image;
@property (nonatomic,retain) NSURL *thumbnail;

@end
