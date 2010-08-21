//
//  Pic.m
//  PicMill
//
//  Created by Xavier Damman on 5/22/10.
//  Copyright 2010 Kwenti inc. All rights reserved.
//

#import "Pic.h"


@implementation Pic

@synthesize title;
@synthesize text;
@synthesize thumbnail;
@synthesize image;
@synthesize created_at;
@synthesize source;

- (id) initWithDictionary:(NSDictionary *)dictionnary {
	if(self == [super init])
	{
		title		= [[dictionnary objectForKey:@"title"] retain];
		text		= [[dictionnary objectForKey:@"text"] retain];
		source		= [[dictionnary objectForKey:@"author"] retain];
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setTimeStyle:NSDateFormatterFullStyle];
		[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
		created_at	= [[dateFormatter dateFromString:[dictionnary objectForKey:@"created_at"]] retain];
		thumbnail	= [[NSURL URLWithString:[dictionnary objectForKey:@"thumbnail_url"]] retain];
		image		= [[NSURL URLWithString:[dictionnary objectForKey:@"image_url"]] retain];
		[dateFormatter release];
	}
	return self;
}

- (UIImage *)getImage {
	NSLog(@"Get image %@",image);
	return [self loadImageFromURL:image];
}

- (UIImage *)getThumbnail {
	return [self loadImageFromURL:thumbnail];	
}

- (NSString *)description {
	if(text != [NSNull null])
		return text;
	else {
		return @"No pic description";
	}
	
}

- (NSString *)getDate {
	//      dateString =            @"Fri Dec 11 23:48:27 2009";
	//      pubdate =          @"Thu, 25 Mar 2010 09:20:21 -0400"
	//      techdirt - broke          @"Thu, 25 Mar 2010 22:00:00 PST"
	//      boing - broke             @"Sat, 03 Apr 2010 07:55:08 PDT";
	//      NSLog([NSString stringWithFormat:@"string2 - %@",dateString2    ]);
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"dd MMM yyyy"];
	NSString *date = [dateFormatter stringFromDate:[self created_at]];
	/*
	if (!date) {
		[dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss zzz"];
		date = [dateFormatter dateFromString:dateString];
	}
	*/

	[dateFormatter release];
	
	return date;
	
}

- (void) dealloc {
	[image release];
	[thumbnail release];
	[title release];
	[text release];
	[created_at release];
	[super dealloc];
}

@end
