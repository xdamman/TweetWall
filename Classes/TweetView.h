//
//  TweetView.h
//  TweetWall
//
//  Created by Xavier Damman on 8/21/10.
//  Copyright 2010 Xavier Damman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageLoader.h"

@interface TweetView : UIView {
	IBOutlet UITextView *tweetContent;
	IBOutlet UIImageView *avatar;
	
}

- (void)dealloc;

@end
