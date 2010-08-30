//
//  Loader.h
//  TweetWall
//
//  Created by Xavier Damman on 8/23/10.
//  Copyright 2010 Kwenti inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Loader : NSObject {

}

+ (void) clean;
+ (BOOL)fileExists: (NSString *) filePath;
+ (NSString *) md5:(NSString *)str;

@end
