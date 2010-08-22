//
//  Tweet.m
//  Timelines
//
//  Created by Xavier Damman on 4/17/10.
//  Copyright 2010 xhead software. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

@synthesize screenName;
@synthesize avatar;
@synthesize content;
@synthesize timestamp;
@synthesize permalink;
@synthesize image;
@synthesize thumbnail;
@synthesize type;

- (id) initWithDictionary:(NSDictionary *)tweetData {
	if(self == [super init])
	{
		screenName	= [[tweetData objectForKey:@"from_user"] retain];
		avatar		= [[tweetData objectForKey:@"profile_image_url"] retain];
		content		= [[tweetData objectForKey:@"text"] retain];
		
		NSDateFormatter *df = [[NSDateFormatter alloc] init];
		NSString *dateString = [tweetData objectForKey:@"created_at"];

		[df setDateFormat:@"EEE, d MMM yyyy HH:mm:ss Z"];
		timestamp = [[df dateFromString: dateString] retain];
				
		[df release];
		permalink	= [[NSURL URLWithString:[NSString stringWithFormat:@"http://twitter.com/%@/statuses/%@",screenName,[tweetData objectForKey:@"id"]]] retain];

	}
	return self;
}

- (void)dealloc {
	[super dealloc];
}

- (NSString *) description {
	//return [super description];
	return [NSString stringWithFormat:@"\nscreenName:\t%@\ncontent:\t%@\ntimestamp:\t%@\nimage:\t%@\n",screenName,timestamp,content,image];
}

@end
