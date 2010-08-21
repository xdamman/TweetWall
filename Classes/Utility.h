//
//  Utility.h
//  SocialFrame
//
//  Created by Christian Sanz on 8/21/10.
//  Copyright 2010 Commentag SPRL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Twitter.h"

@interface Utility : NSObject {
	Twitter *twitter;
}

- (NSArray*) getTwitListByKeyword:(NSString*)keyword;



@end
