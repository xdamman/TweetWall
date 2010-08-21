//
//  Utility.m
//  SocialFrame
//
//  Created by Christian Sanz on 8/21/10.
//  Copyright 2010 Commentag SPRL. All rights reserved.
//

#import "Utility.h"

@implementation Utility

- (NSArray*) getTwitListByKeyword:(NSString*) keyword {
	twitter = [[Twitter alloc] init];
	NSArray *tweets = [twitter searchByKeyword:keyword limit:10];
	return tweets;
}
@end
