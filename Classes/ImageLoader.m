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
		NSLog(@"Returning %@ from cache",url);
		return [UIImage imageWithContentsOfFile:filePath];
	}
	
	//NSLog(@"File %@ does not exist, fetching %@",filePath,url);
	NSData *data = [NSData dataWithContentsOfURL:url];
	UIImage *image = [[UIImage alloc] initWithData:data];
	[ImageLoader saveImage:image withName:fileName];
	[image autorelease];
	return image;
}


+ (void)saveImage:(UIImage *)image withName:(NSString *)name {
	NSData *data = UIImageJPEGRepresentation(image, 1.0);
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSString *fullPath = [documentsPath stringByAppendingPathComponent:name];
	[fileManager createFileAtPath:fullPath contents:data attributes:nil];
}

@end
