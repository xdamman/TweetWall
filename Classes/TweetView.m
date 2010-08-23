//
//  TweetView.m
//  TweetWall
//
//  Created by Xavier Damman on 8/21/10.
//  Copyright 2010 Xavier Damman. All rights reserved.
//

#import "TweetView.h"

@implementation TweetView


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void) awakeFromNib {
	tweetContent.text = @"This is my super tweet about #iOSDevCamp - awesome!";
	NSURL *imageURL;
	imageURL = [NSURL URLWithString:@"https://s3.amazonaws.com/twitter_production/profile_images/16158822/xavier2.jpg"];
	avatar.image = [ImageLoader loadImageFromURL:imageURL];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc {
    [super dealloc];
}


@end
