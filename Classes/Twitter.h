//
//  PublitweetBackend.h
//  Timelines
//
//  Created by Xavier Damman on 4/17/10.
//  Copyright 2010 xhead software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJSONDeserializer.h"
#import "JSONLoader.h"
#import "Tweet.h"

@interface Twitter : NSObject

- (NSArray *)searchByKeyword:(NSString *)keyword limit:(int)limit;
- (NSDictionary *)getUserInfo:(NSString *)screenName;

@end
