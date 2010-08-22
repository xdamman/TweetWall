//
//  Utility.m
//  TweetWall
//
//  Created by Christian Sanz on 8/21/10.
//  Copyright 2010 Commentag SPRL. All rights reserved.
//

#import "Utility.h"
#import "Tweet.h"

@implementation Utility

@synthesize keyword;
@synthesize delegate;

- (id)init
{
	[super init];
	
	index = 0;
	twitter = [[Twitter alloc] init];
	tweets = [[NSMutableArray alloc] init];
	
	return self;
}


- (Tweet*) getNext {
	
	//TODO
	//handle when we have 0 and less than 20 results

	NSLog(@"Tweets count: %i",tweets.count);
	
	if (tweets.count == 0) {
		return nil;
	}
	
	if (index == tweets.count) {
		index = 0;
	}
	
	if (tweets.count > 2 && index == tweets.count - 2) {
		[self setSearchKeyword:self.keyword];
	}
	
	NSLog(@"Returning tweet %@",[tweets objectAtIndex:index]);
	return [tweets objectAtIndex:index++];
		
}

- (void) setSearchKeyword: (NSString *)aKeyword {

	self.keyword = aKeyword;
	// Thread 
	NSLog(@"Searching for %@",aKeyword);
	[NSThread detachNewThreadSelector:@selector(searchTwitter) toTarget:self withObject:nil];
	
}
												
- (void) searchTwitter {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSLog(@"New thread");
	
	[tweets removeAllObjects];
	[tweets addObjectsFromArray:[twitter searchByKeyword:self.keyword limit:20]];
	
	//NSLog(@"Tweets count: %i", tweets.count);
	if (tweets.count > 0)
		NSLog(@"first tweet: %@", [tweets objectAtIndex:0]);

	if (!tweets || tweets.count == 0) {
		NSLog(@"No result found");
		[tweets addObjectsFromArray:[twitter searchByKeyword:@"\"no results\"" limit:20]];
	}
	
	[self performSelectorOnMainThread:@selector(searchTwitterDidFinish) withObject:nil waitUntilDone:NO];
	
	[pool release];
}

- (void) dealloc {
	NSLog(@"dealloc");
	[twitter release];
	[tweets release];
	[super dealloc];
}

- (void)searchTwitterDidFinish {
	NSLog(@"This is where Im supposed to call the delegate utilityDidFinishFirstFetch");
	if([delegate respondsToSelector:@selector(utilityDidFinishFirstFetch)]) {
		[delegate utilityDidFinishFirstFetch];
	}
}

@end
