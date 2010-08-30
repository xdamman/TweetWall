//
//  JSONLoader.m
//  TweetWall
//
//  Created by Xavier Damman on 8/23/10.
//  Copyright 2010 Kwenti inc. All rights reserved.
//

#import "JSONLoader.h"


@implementation JSONLoader


+ (NSDictionary *)loadJsonFromURL: (NSURL *)url {
	return [JSONLoader loadJsonFromURL:url withMaxCacheInSeconds:0];
}

+ (NSDictionary *)loadJsonFromURL: (NSURL *)url withMaxCacheInSeconds:(int)seconds {
	[url retain];
	
	NSString* documentsPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] retain];
	NSString *fileName = [[NSString stringWithFormat:@"%@.json",[self md5:[NSString stringWithFormat:@"%@",url]]] retain];	
	NSString* filePath = [[documentsPath stringByAppendingPathComponent:fileName] retain];	
	
	if ([self fileExists:filePath]) {
		//NSLog(@"File %@ exists",filePath);
		BOOL returnFromCache = FALSE;
		if (seconds == 0) {
			returnFromCache = TRUE;
		}
		else if (seconds > 0) {
			NSFileManager *fm = [NSFileManager defaultManager];
			NSDate *fileMTimeDate = [[fm fileAttributesAtPath:filePath traverseLink:YES] fileModificationDate];
			if ([[NSDate date] timeIntervalSinceDate:fileMTimeDate] <= seconds) {
				returnFromCache = TRUE;
			}
		}
		
		if (returnFromCache) {
			NSLog(@"Return JSON from cache %@",url);
			
			NSString *jsonString = [[NSString alloc] initWithContentsOfFile:filePath] ;
			NSData *jsonData = [jsonString dataUsingEncoding:NSUTF32BigEndianStringEncoding];
			NSError *error = nil;
			
			NSDictionary *json = [[[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error] retain];
			
			
			//NSDictionary *json = [NSDictionary dictionaryWithContentsOfFile:filePath];
			NSLog(@"json from cache %@\n%@",filePath,json);
			
			[url release];
			[jsonString release];
			
			return json;
		}
	}
	
    NSError *error = nil;
	
	[[NSURLCache sharedURLCache] setMemoryCapacity:0];
	[[NSURLCache sharedURLCache] setDiskCapacity:0]; 
	NSString *rawDataString = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
	
	NSString *jsonString = [[NSString stringWithFormat:@"{\"root\":%@}",rawDataString] retain];

	NSLog(@"\nJSONLoader\n\tQuery: %@\n\tError: %@\n\tRESULT:%@",url,error,jsonString);
	
	NSData *jsonData = [jsonString dataUsingEncoding:NSUTF32BigEndianStringEncoding];
	error = nil;
	
	NSDictionary *json = [[[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error] retain];
	
	[rawDataString release];
	[documentsPath release];
	[filePath release];
	[fileName release];
	[url release];
	[JSONLoader saveJson:json withName:fileName];

	[json autorelease];
	return json;
}

+ (void)saveJson:(NSDictionary *)json withName:(NSString *)name {
	[json retain];
	NSData* data=[[[CJSONSerializer serializer] serializeDictionary:json] dataUsingEncoding:NSUTF8StringEncoding];
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSString *fullPath = [documentsPath stringByAppendingPathComponent:name];
	[fileManager createFileAtPath:fullPath contents:data attributes:nil];
	
	[json release];
}

@end
