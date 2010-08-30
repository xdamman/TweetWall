//
//  StorifyAPI.h
//  TweetWall
//
//  Created by Xavier Damman on 8/29/10.
//  Copyright 2010 Kwenti inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJSONDeserializer.h"
#import "JSONLoader.h"
#import "Tweet.h"


@interface StorifyAPI : NSObject {

	
}

- (NSArray *)getStoryElements:(NSString *)permalink;
- (NSDictionary *)getUserInfo:(NSString *)screenName;
- (NSArray *) processElements:(NSDictionary *)elementsData;


@end
