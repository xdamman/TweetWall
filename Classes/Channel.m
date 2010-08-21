//
//  Channel.m
//  PicMill
//
//  Created by Xavier Damman on 5/22/10.
//  Copyright 2010 Kwenti inc. All rights reserved.
//

#import "Channel.h"


@implementation Channel 

@synthesize identifier;
@synthesize name;
@synthesize description;
@synthesize thumbnail;
@synthesize image;
@synthesize updated_at;

- (id) initWithDictionary:(NSDictionary *)dictionnary {
	if(self == [super init])
	{
		NSLog(@"Parsing %@",[dictionnary objectForKey:@"name"]);
		identifier	= [[dictionnary objectForKey:@"id"] retain];
		name		= [[dictionnary objectForKey:@"name"] retain];
		description	= [[dictionnary objectForKey:@"description"] retain];
		int interval= [(NSNumber *)[dictionnary objectForKey:@"updated_at"] intValue];
		updated_at	= [[NSDate dateWithTimeIntervalSince1970:interval] retain];
		thumbnail	= [[NSURL URLWithString:[dictionnary objectForKey:@"thumbnail_url"]] retain];
		image		= [[NSURL URLWithString:[dictionnary objectForKey:@"image_url"]] retain];
	}
	return self;
}

- (UIImage *)getImage {
	return [self loadImageFromURL:image];
}

- (UIImage *)getThumbnail {
	NSLog(@"Getting thumbnail %@",thumbnail);
	return [self loadImageFromURL:thumbnail];	
}

- (NSString *)description {
	if(description != [NSNull null])
		return description;
	else {
		return @"No channel description";
	}

}

- (void) dealloc {
	[image release];
	[thumbnail release];
	[name release];
	[description release];
	[updated_at release];
	[super dealloc];
}

@end
