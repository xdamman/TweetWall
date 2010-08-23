//
//  ImageLoader.h
//  PicMill
//
//  Created by Xavier Damman on 5/22/10.
//  Copyright 2010 Xavier Damman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface ImageLoader : NSObject {

}

+ (UIImage *)loadImageFromURL: (NSURL *)url;
+ (BOOL)fileExists: (NSString *) filePath;

+ (NSString *) md5:(NSString *)str;

+ (void)saveImage:(UIImage *)image withName:(NSString *)name;

@end
