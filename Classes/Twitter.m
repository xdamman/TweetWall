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
	NSString *queryString = [[NSString stringWithFormat:@"http://search.twitter.com/search.json?q=%@&limit=%d",keyword,limit] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	
//	NSURL *query = [[NSURL alloc] initWithString:queryString];
	NSLog(@"Searching %@",queryString);
	
    // shoaiby 4/18: Fixed deprecated warning with stringWithContentsOfURL
    NSError *error = nil;
	NSString *json = [NSString stringWithContentsOfURL:[NSURL URLWithString:queryString]
                                              encoding:NSUTF8StringEncoding
                                                 error:&error];
    
	NSString *jsonObj = [NSString stringWithFormat:@"{\"root\":%@}",json];
	
		
	NSData *jsonData = [jsonObj dataUsingEncoding:NSUTF32BigEndianStringEncoding];
	error = nil;
		
	NSDictionary *tweetsData = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];

	//NSLog(@"Error received: %@",error);
	return [self processTweets:tweetsData];
//	[query release];
	//NSLog(@"Tweets: %@",tweets);
}

- (NSDictionary *)getUserInfo:(NSString *)screenName {
	
	NSString *queryString = [[NSString stringWithFormat:@"http://api.twitter.com/1/users/show/%@.json",screenName] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	NSLog(@"Requesting %@",queryString);
	
    NSError *error = nil;
	NSString *json = [NSString stringWithContentsOfURL:[NSURL URLWithString:queryString]
                                              encoding:NSUTF8StringEncoding
                                                 error:&error];
    
	NSString *jsonObj = [NSString stringWithFormat:@"{\"root\":%@}",json];
	
	
	NSData *jsonData = [jsonObj dataUsingEncoding:NSUTF32BigEndianStringEncoding];
	error = nil;
	
	NSDictionary *userData = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
	
	//NSLog(@"Error received: %@",error);
	return [userData objectForKey:@"root"];
	
}


- (NSArray *) processTweets:(NSDictionary *)tweetsData {

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
	
	[tweets autorelease];
	
	return tweets;
}

- (void) dealloc {
	[super dealloc];
}

@end
