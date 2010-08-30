//
//  JSONLoader.h
//  TweetWall
//
//  Created by Xavier Damman on 8/23/10.
//  Copyright 2010 Kwenti inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Loader.h"
#import "CJSONDeserializer.h"
#import "CJSONSerializer.h"

@interface JSONLoader : Loader {

}

+ (NSDictionary *)loadJsonFromURL: (NSURL *)url;
+ (NSDictionary *)loadJsonFromURL: (NSURL *)url withMaxCacheInSeconds:(int)seconds;
+ (void)saveJson:(NSDictionary *)json withName:(NSString *)name;


@end
