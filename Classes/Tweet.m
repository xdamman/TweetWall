//
//  Tweet.m
//  Timelines
//
//  Created by Xavier Damman on 4/17/10.
//  Copyright 2010 xhead software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tweet.h"
#import "RegexKitLite.h"
#import "Twitter.h"

@implementation Tweet

@synthesize screenName;
@synthesize avatar;
@synthesize content;
@synthesize timestamp;
@synthesize permalink;
@synthesize image;
@synthesize thumbnail;
@synthesize type;
@synthesize user;

- (id) initWithDictionary:(NSDictionary *)tweetData {
	if(self == [super init])
	{
		screenName	= [[tweetData objectForKey:@"from_user"] retain];
		avatar		= [[NSURL URLWithString:[tweetData objectForKey:@"profile_image_url"]] retain];
		content		= [[tweetData objectForKey:@"text"] retain];
		
		NSDateFormatter *df = [[NSDateFormatter alloc] init];
		NSString *dateString = [tweetData objectForKey:@"created_at"];

		[df setDateFormat:@"EEE, d MMM yyyy HH:mm:ss Z"];
		timestamp = [[df dateFromString: dateString] retain];
				
		[df release];
		permalink	= [[NSURL URLWithString:[NSString stringWithFormat:@"http://twitter.com/%@/statuses/%@",screenName,[tweetData objectForKey:@"id"]]] retain];
		
		NSString *urlRegex = @"\\bhttps?://[a-zA-Z0-9\\-.]+(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?";
		
		NSArray *matchedURLsArray = [content componentsMatchedByRegex:urlRegex];
		//NSLog(@"URLs found in da tweet: %@",matchedURLsArray);
		NSString *u;
		for (u in matchedURLsArray) {
				if ([[u substringToIndex:14] isEqualToString:@"http://twitpic"]) {
					NSString *imageUrl = [NSString stringWithFormat:@"http://twitpic.com/show/large/%@",[u substringFromIndex:19]];
					image = [[NSURL URLWithString:imageUrl] retain];
					NSLog(@"found twitpic: %@",imageUrl);
				}
				else if ([[u substringToIndex:12] isEqualToString:@"http://yfrog"]) {
					NSString *imageUrl = [NSString stringWithFormat:@"%@:iphone",u];
					image = [[NSURL URLWithString:imageUrl] retain];
					NSLog(@"found yfrog: %@",imageUrl);
				}
			
		}
		
		[NSThread detachNewThreadSelector:@selector(getUserInfoThread) toTarget:self withObject:nil];

	}
	return self;
}

- (void) getUserInfoThread {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	Twitter *twitter = [[Twitter alloc] init];
	user = [[twitter getUserInfo:self.screenName] retain];
	NSLog(@"Fetching userinfo for %@",self.screenName);
//	[self performSelectorOnMainThread:@selector(searchTwitterDidFinish) withObject:nil waitUntilDone:NO];
	[twitter release];
	[pool release];
}

- (void)dealloc {
	[screenName release];
	[user release];
	[avatar release];
	[timestamp release];
	[content release];
	[image release];
	[super dealloc];
}

- (NSString *) description {
	//return [super description];
	return [NSString stringWithFormat:@"\nscreenName:\t%@\ncontent:\t%@\ntimestamp:\t%@\nimage:\t%@\n",screenName,content,timestamp,image];
}

@end
