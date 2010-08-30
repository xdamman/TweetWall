//
//  StorifyAPI.m
//  Timelines
//
//  Created by Xavier Damman on 4/17/10.
//  Copyright 2010 xhead software. All rights reserved.
//

#import "StorifyAPI.h"

#pragma mark Private Interface

@interface StorifyAPI (Private)

- (NSArray *)processTweets:(NSDictionary *)tweetsData;

@end

#pragma mark -
#pragma mark Public Interface

@implementation StorifyAPI

- (id)init
{
	[super init];
	
	return self;
}


- (NSArray *)getStoryElements:(NSString *)permalink
{	
	NSString *queryString = [[NSString stringWithFormat:@"%@.json",permalink] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	NSLog(@"Fetching %@",queryString);
	
	NSDictionary *storyData = [JSONLoader loadJsonFromURL:[NSURL URLWithString:queryString] withMaxCacheInSeconds:5];
	
	NSArray *story = [[self processTweets:storyData] retain];
	return [story autorelease];
}

- (NSDictionary *)getUserInfo:(NSString *)screenName {
	
	NSString *queryString = [[NSString stringWithFormat:@"http://api.twitter.com/1/users/show/%@.json",screenName] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	NSLog(@"Requesting %@",queryString);
	
	NSDictionary *userData = [JSONLoader loadJsonFromURL:[NSURL URLWithString:queryString]];
	
	return [userData objectForKey:@"root"];
	
}


- (NSArray *) processElements:(NSDictionary *)elementsData {
	[elementsData retain];
	NSEnumerator *enumerator = [[[elementsData objectForKey:@"root"] objectForKey:@"elements"] objectEnumerator];
	NSDictionary *t;
	
	NSLog(@"processing %i elements",[[[elementsData objectForKey:@"root"] objectForKey:@"elements"] count]);
	
	NSMutableArray *elements = [[NSMutableArray alloc] init];
	
	while ((t = [enumerator nextObject])) {
		Tweet *tweet = [[Tweet alloc] initWithDictionary:t];
		NSLog(@"Story Element: %@",tweet);
		[elements addObject:tweet];
		[tweet release];
	}
	
	[elementsData release];
	[elements autorelease];
	
	return elements;
}

- (void) dealloc {
	[super dealloc];
}

@end
