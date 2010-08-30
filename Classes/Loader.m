//
//  Loader.m
//  TweetWall
//
//  Created by Xavier Damman on 8/23/10.
//  Copyright 2010 Kwenti inc. All rights reserved.
//

#import "Loader.h"


@implementation Loader


+ (void) clean {
	NSFileManager *fm = [NSFileManager defaultManager];
	NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSError *error = nil;
	int total = 0;
	for (NSString *file in [fm contentsOfDirectoryAtPath:documentsPath error:&error]) {
		BOOL success = [fm removeItemAtPath:[NSString stringWithFormat:@"%@/%@", documentsPath, file] error:&error];
		total++;
		if (!success || error) {
			// it failed.
			NSLog(@"Couldn't remove file %@ because %@",file,error);
		}
	}
	NSLog(@"[ImageLoader] %i files removed",total);
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

@end
