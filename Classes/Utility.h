//
//  Utility.h
//  TweetWall
//
//  Created by Christian Sanz on 8/21/10.
//  Copyright 2010 Commentag SPRL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Twitter.h"
#import "Tweet.h"

@protocol UtilityDelegate <NSObject>

- (void) utilityDidFinishFirstFetch;

@end



@interface Utility : NSObject {
	Twitter *twitter;
	NSMutableArray *tweets;
	int index;
	NSString *keyword;
	
	id <UtilityDelegate> delegate;
}


- (Tweet *) getNext;
- (void) setSearchKeyword: (NSString *)aKeyword;


@property (nonatomic, retain) NSString *keyword;
@property (nonatomic, retain) id delegate;

@end
