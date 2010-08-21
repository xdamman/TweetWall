//
//  PublitweetBackend.h
//  Timelines
//
//  Created by Xavier Damman on 4/17/10.
//  Copyright 2010 xhead software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJSONDeserializer.h"
#import "Tweet.h"

@interface Twitter : NSObject

- (NSArray *)searchByKeyword:(NSString *)keyword limit:(int)limit;
- (NSArray *)searchByScreenName:(NSString *)screenName since:(NSDate *)since until:(NSDate *)until limit:(int)limit;
- (NSArray *)searchImages:(NSString *)keyword since:(NSDate *)since until:(NSDate *)until limit:(int)limit;

@end
