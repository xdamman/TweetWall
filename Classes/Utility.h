//
//  Utility.h
//  TweetWall
//
//  Created by Christian Sanz on 8/21/10.
//  Copyright 2010 Xavier Damman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Twitter.h"
#import "Tweet.h"

@protocol UtilityDelegate <NSObject>

- (void) searchTwitterDidFinishWithNoResults; // Happen if no Internet Connection, or Twitter Down
- (void) searchTwitterDidFinishSuccessfully;

@end



@interface Utility : NSObject {
	Twitter *twitter;
	NSArray *tweets;
	int index;
	NSString *keyword;
	
	id <UtilityDelegate> delegate;
}


- (Tweet *) getNext;
- (void) setSearchKeyword: (NSString *)aKeyword;
- (void) searchTwitterThread;

@property (nonatomic, retain) NSString *keyword;
@property (nonatomic, retain) id delegate;

@end
