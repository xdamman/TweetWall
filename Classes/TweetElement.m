//
//  TweetElement.m
//  Timelines
//
//  Created by Xavier Damman on 4/17/10.
//  Copyright 2010 xhead software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TweetElement.h"
#import "RegexKitLite.h"
#import "Twitter.h"

@implementation TweetElement

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
		screenName	= [[tweetData objectForKey:@"author"]retain];
		avatar		= [[NSURL URLWithString:[[tweetData objectForKey:@"metadata"]objectForKey:@"avatar"]] retain];
		content		= [[tweetData objectForKey:@"title"] retain];
		
		timestamp = [[NSDate dateWithTimeIntervalSince1970:[[tweetData objectForKey:@"created_at"] integerValue]] retain];
		permalink	= [[NSURL URLWithString:[tweetData objectForKey:@"permalink"]] retain];
		
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

	NSLog(@"Fetching userinfo for %@",self.screenName);
	NSString *queryString = [[NSString stringWithFormat:@"http://api.twitter.com/1/users/show/%@.json",self.screenName] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	user = [[[JSONLoader loadJsonFromURL:[NSURL URLWithString:queryString] withMaxCacheInSeconds:600] objectForKey:@"root"] retain];
//	NSLog(@"User info: %@",user);
	//	[self performSelectorOnMainThread:@selector(searchTwitterDidFinish) withObject:nil waitUntilDone:NO];
	[pool release];
	return;
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
