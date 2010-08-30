//
//  DataSource.h
//  TweetWall
//
//  Created by Xavier Damman on 8/29/10.
//  Copyright 2010 Kwenti inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StorifyAPI.h"
#import "TweetElement.h"

@protocol DataSourceDelegate <NSObject>

- (void) fetchDidFinishWithNoResults; // Happen if no Internet Connection, or Twitter Down
- (void) fetchDidFinishSuccessfully;

@end


@interface DataSource : NSObject {
	StorifyAPI *storify;
	NSArray *elements;
	int index;
	NSString *permalink;
	NSString *title;
	
	id <DataSourceDelegate> delegate;
	
}

- (TweetElement *) getNext;

- (void) getStory: (NSString *)permalink;
- (void) getStoryElementsThread;


@property (nonatomic, retain) NSString *permalink;
@property (nonatomic,retain) NSString *title;
@property (nonatomic, retain) id delegate;


@end
