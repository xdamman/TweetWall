//
//  DataSource.m
//  TweetWall
//
//  Created by Xavier Damman on 8/29/10.
//  Copyright 2010 Kwenti inc. All rights reserved.
//

#import "DataSource.h"


@implementation DataSource


@synthesize permalink;
@synthesize title;
@synthesize delegate;

- (id)init
{
	[super init];
	
	index = 0;
	storify = [[StorifyAPI alloc] init];
	elements = [[NSArray alloc] init];
	
	return self;
}


- (TweetElement*) getNext {
	
	//TODO
	//handle when we have 0 and less than 20 results
	
	NSLog(@"\n\
		  *****************************\n\
		  Current tweet: %i/%i, next: %i\n\
		  *****************************",index,[elements count],index+1);
	
	if (elements.count == 0) {
		return nil;
	}
	
	if (index == elements.count) {
		index = 0;
	}
	
	
	if (elements.count > 2 && index == elements.count - 2) {
		NSLog(@"Updating elements queue for permalink: %@",self.permalink);
		[self getStory:self.permalink];
	}
	
	
	return [elements objectAtIndex:index++];		
}

- (void) getStory: (NSString *)aPermalink {
	
	self.permalink = aPermalink;
	// Thread 
	[NSThread detachNewThreadSelector:@selector(getStoryElementsThread) toTarget:self withObject:nil];
	
}

- (void) getStoryElementsThread {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSArray *newtweets = [[storify getStoryElements:self.permalink] retain];
	NSLog(@"getStoryElementsThread %@",self.permalink);
	if (newtweets && newtweets.count > 0) {
		elements = newtweets;
		[self performSelectorOnMainThread:@selector(fetchDidFinish) withObject:nil waitUntilDone:NO];
	}
	else {
		[self performSelectorOnMainThread:@selector(fetchDidFinishWithNoResults) withObject:nil waitUntilDone:NO];
	}
	[pool release];
}

- (void) dealloc {
	NSLog(@"dealloc");
	[storify release];
	[elements release];
	[super dealloc];
}

- (void)fetchDidFinishWithNoResults {
	if([delegate respondsToSelector:@selector(fetchDidFinishWithNoResults)]) {
		[delegate fetchDidFinishWithNoResults];
	}
}

- (void)fetchDidFinish {
	title = storify.title;
	if([delegate respondsToSelector:@selector(fetchDidFinishSuccessfully)]) {
		[delegate fetchDidFinishSuccessfully];
	}
}


@end
