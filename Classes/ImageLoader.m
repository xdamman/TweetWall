//
//  ImageLoader.m
//  PicMill
//
//  Created by Xavier Damman on 5/22/10.
//  Copyright 2010 Kwenti inc. All rights reserved.
//

#import "ImageLoader.h"


@implementation ImageLoader

+ (UIImage *)loadImageFromURL: (NSURL *)url {
	NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSString *fileName = [self md5:[NSString stringWithFormat:@"%@",url]];	
	NSString* filePath = [documentsPath stringByAppendingPathComponent:fileName];
	
	if ([self fileExists:filePath]) {
		//NSLog(@"File %@ exists",filePath);
		return [UIImage imageWithContentsOfFile:filePath];
	}
	
	NSLog(@"File %@ does not exist, fetching %@",filePath,url);
	NSData *data = [NSData dataWithContentsOfURL:url];
	UIImage *image = [[UIImage alloc] initWithData:data];
	[ImageLoader saveImage:image withName:fileName];
	[image autorelease];
	return image;
}

+ (BOOL)fileExists: (NSString *)filePath {
	return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}

+ (NSString *) md5:(NSString *)str {
	const char *cStr = [str UTF8String];
	unsigned char result[16];
	CC_MD5( cStr, strlen(cStr), result );
	return [NSString stringWithFormat:
			@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
			result[0], result[1], result[2], result[3], 
			result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11],
			result[12], result[13], result[14], result[15]
			]; 
}

+ (void)saveImage:(UIImage *)image withName:(NSString *)name {
	NSData *data = UIImageJPEGRepresentation(image, 1.0);
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSString *fullPath = [documentsPath stringByAppendingPathComponent:name];
	[fileManager createFileAtPath:fullPath contents:data attributes:nil];
}

@end
