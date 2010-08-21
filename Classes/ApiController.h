//
//  ApiController.h
//  PicMill
//
//  Created by Xavier Damman on 5/22/10.
//  Copyright 2010 Kwenti inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJSONDeserializer.h"
#import "Channel.h"
#import "Pic.h"

#define API_URL @"http://bigpicture.heroku.com/"
//#define API_URL @"http://192.168.1.114/test/"
@interface ApiController : NSObject {

	
	
}

- (NSArray *) getFeaturedChannels;
- (NSArray *) getLatestChannels;
- (NSArray *) getPicturesFromChannel: (int)channelID;

- (NSDictionary *) getJSON: (NSString *)queryString;


@end
