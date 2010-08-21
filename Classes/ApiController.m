//
//  ApiController.m
//  PicMill
//
//  Created by Xavier Damman on 5/22/10.
//  Copyright 2010 Kwenti inc. All rights reserved.
//

#import "ApiController.h"


@implementation ApiController


- (NSArray *) getFeaturedChannels {

	NSString *queryString = [NSString stringWithFormat:@"%@ipad/featured.json",API_URL];
	NSLog(@"Querying %@",queryString);
	NSDictionary *channelsData = [self getJSON: queryString];
	
	NSEnumerator *enumerator = [[channelsData objectForKey:@"root"] objectEnumerator];
	NSDictionary *c;
	
	NSMutableArray *channels = [[NSMutableArray alloc] init];
	
	NSLog(@"processing %d featured channels",[[channelsData objectForKey:@"root"] count]);
	
	while ((c = [enumerator nextObject])) {
		Channel *channel = [[Channel alloc] initWithDictionary:c];
		[channels addObject:channel];
		//NSLog(@"channels: %@",channels);
		[channel release];
	}
	
	[channels autorelease];
	
	return channels;
}

- (NSArray *) getLatestChannels {

	NSString *queryString = [NSString stringWithFormat:@"%@channels.json",API_URL];
	NSLog(@"Querying %@",queryString);
	NSDictionary *channelsData = [self getJSON: queryString];
	
	NSEnumerator *enumerator = [[channelsData objectForKey:@"root"] objectEnumerator];
	NSDictionary *c;
		
	NSMutableArray *channels = [[NSMutableArray alloc] init];
		
	NSLog(@"processing %d channels",[[channelsData objectForKey:@"root"] count]);

	while ((c = [enumerator nextObject])) {
		Channel *channel = [[Channel alloc] initWithDictionary:c];
		[channels addObject:channel];
		//NSLog(@"channels: %@",channels);
		[channel release];
	}
	
	[channels autorelease];
	
	return channels;
	
}

- (NSArray *) getPicturesFromChannel: (int)channelID {
	NSString *queryString = [NSString stringWithFormat:@"%@channels/%d/photos.json",API_URL,channelID];
//	NSString *queryString = [NSString stringWithFormat:@"%@photos_%d.json",API_URL,channelID];
	NSLog(@"Querying %@",queryString);
	NSDictionary *channelsData = [self getJSON: queryString];
	
	NSEnumerator *enumerator = [[channelsData objectForKey:@"root"] objectEnumerator];
	NSDictionary *c;
	
	NSMutableArray *pictures = [[NSMutableArray alloc] init];
	
	NSLog(@"processing %d pictures",[[channelsData objectForKey:@"root"] count]);
	
	while ((c = [enumerator nextObject])) {
		Channel *pic = [[Pic alloc] initWithDictionary:c];
		[pictures addObject:pic];
		//NSLog(@"channels: %@",channels);
		[pic release];
	}
	
	[pictures autorelease];
	
	return pictures;
	
}

- (NSDictionary *) getJSON: (NSString *)queryString {
    NSError *error = nil;
	NSString *json = [NSString stringWithContentsOfURL:[NSURL URLWithString:queryString]
                                              encoding:NSUTF8StringEncoding
                                                 error:&error];
    
	NSString *jsonObj = [NSString stringWithFormat:@"{\"root\":%@}",json];
	
	NSData *jsonData = [jsonObj dataUsingEncoding:NSUTF32BigEndianStringEncoding];
	error = nil;
	
	NSDictionary *jsonDictionnary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
	
	return jsonDictionnary;
}


@end
