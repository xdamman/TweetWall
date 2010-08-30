//
//  Utility.m
//  TweetWall
//
//  Created by Christian Sanz on 8/21/10.
//  Copyright 2010 Xavier Damman. All rights reserved.
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
	tweets = [[NSArray alloc] init];
	
	return self;
}


- (Tweet*) getNext {
	
	//TODO
	//handle when we have 0 and less than 20 results
	
	NSLog(@"\n\
		  *****************************\n\
		  Current tweet: %i/%i, next: %i\n\
		  *****************************",index,[tweets count],index+1);
	
	if (tweets.count == 0) {
		return nil;
	}
	
	if (index == tweets.count) {
		index = 0;
	}
	
	if (tweets.count > 2 && index == tweets.count - 2) {
		NSLog(@"Updating tweets queue for keyword: %@",self.keyword);
		[self setSearchKeyword:self.keyword];
	}
	
	return [tweets objectAtIndex:index++];		
}

- (void) setSearchKeyword: (NSString *)aKeyword {

	self.keyword = aKeyword;
	// Thread 
	NSLog(@"Searching for %@",aKeyword);
	[NSThread detachNewThreadSelector:@selector(searchTwitterThread) toTarget:self withObject:nil];
	
}
												
- (void) searchTwitterThread {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	NSArray *newtweets = [[twitter searchByKeyword:self.keyword limit:5] retain];
		
	if (!newtweets || newtweets.count == 0) {
		NSLog(@"No result found");
		newtweets = [twitter searchByKeyword:@"\"no results\"" limit:15];
	}
	
	if (newtweets && newtweets.count > 0) {
		tweets = newtweets;
		[self performSelectorOnMainThread:@selector(searchTwitterDidFinish) withObject:nil waitUntilDone:NO];
	}
	else {
		[self performSelectorOnMainThread:@selector(searchTwitterDidFinishWithNoResults) withObject:nil waitUntilDone:NO];
	}
	[pool release];
}

- (void) dealloc {
	NSLog(@"dealloc");
	[twitter release];
	[tweets release];
	[super dealloc];
}

- (void)searchTwitterDidFinishWithNoResults {
	if([delegate respondsToSelector:@selector(searchTwitterDidFinishWithNoResults)]) {
		[delegate searchTwitterDidFinishWithNoResults];
	}
}

- (void)searchTwitterDidFinish {
	if([delegate respondsToSelector:@selector(searchTwitterDidFinishSuccessfully)]) {
		[delegate searchTwitterDidFinishSuccessfully];
	}
}

@end
