//
//  PublitweetBackend.m
//  Timelines
//
//  Created by Xavier Damman on 4/17/10.
//  Copyright 2010 xhead software. All rights reserved.
//

#import "Twitter.h"

#pragma mark Private Interface

@interface Twitter (Private)

- (NSArray *)processTweets:(NSDictionary *)tweetsData;

@end

#pragma mark -
#pragma mark Public Interface

@implementation Twitter

- (id)init
{
	[super init];
		
	return self;
}


- (NSArray *)searchByKeyword:(NSString *)keyword limit:(int)limit
{	
	NSString *queryString = [[NSString stringWithFormat:@"http://search.twitter.com/search.json?q=%@&rpp=%d",keyword,limit] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	NSLog(@"Searching %@",queryString);
		
	NSDictionary *tweetsData = [JSONLoader loadJsonFromURL:[NSURL URLWithString:queryString] withMaxCacheInSeconds:5];
	
	NSArray *tweets = [[self processTweets:tweetsData] retain];
	return [tweets autorelease];
}

- (NSDictionary *)getUserInfo:(NSString *)screenName {
	
	NSString *queryString = [[NSString stringWithFormat:@"http://api.twitter.com/1/users/show/%@.json",screenName] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	NSLog(@"Requesting %@",queryString);
	
	NSDictionary *userData = [JSONLoader loadJsonFromURL:[NSURL URLWithString:queryString]];
	
	return [userData objectForKey:@"root"];
	
}


- (NSArray *) processTweets:(NSDictionary *)tweetsData {
	[tweetsData retain];
	NSEnumerator *enumerator = [[[tweetsData objectForKey:@"root"] objectForKey:@"results"] objectEnumerator];
	NSDictionary *t;
	
	NSLog(@"processing %i tweets",[[[tweetsData objectForKey:@"root"] objectForKey:@"results"] count]);
	
	NSMutableArray *tweets = [[NSMutableArray alloc] init];
	
	while ((t = [enumerator nextObject])) {
		Tweet *tweet = [[Tweet alloc] initWithDictionary:t];
		[tweets addObject:tweet];
//		NSLog(@"tweet: %@",tweet);
		[tweet release];
	}
	
	[tweetsData release];
	[tweets autorelease];
	
	return tweets;
}

- (void) dealloc {
	[super dealloc];
}

@end
