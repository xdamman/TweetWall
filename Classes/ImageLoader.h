//
//  ImageLoader.h
//  PicMill
//
//  Created by Xavier Damman on 5/22/10.
//  Copyright 2010 Xavier Damman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import "Loader.h"

@interface ImageLoader : Loader {

}

+ (UIImage *)loadImageFromURL: (NSURL *)url;
+ (void)saveImage:(UIImage *)image withName:(NSString *)name;

@end
