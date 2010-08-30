//
//  TweetWallViewController.h
//  TweetWall
//
//  Created by Xavier Damman on 8/21/10.
//  Copyright (c) 2010 Xavier Damman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Twitter.h"
#import "TweetElement.h"
#import "DataSource.h"
#import "UIKit/UIWebView.h"

@interface TweetWallViewController : UIViewController <UISearchBarDelegate,DataSourceDelegate,UIWebViewDelegate> {
	Twitter *twitter;
	DataSource *datasource;
	TweetElement *t;
	UIImageView *backgroundLayer;
	CALayer *loadingView;
	CATextLayer *loadingViewText;
	NSTimer *rat;
	UIView *previousTweetView;
	UITextView *textView;
	UITextView *screenNameView;
	
}

- (void) flipToNext;
- (void) search:(NSString *)searchText;
//- (void) searchTwitterDidFinishSuccessfully;
//- (void) searchTwitterDidFinishWithNoResults;	
- (void) fetchDidFinishSuccessfully;
- (void) fetchDidFinishWithNoResults;	
- (UIColor *) colorWithHexString: (NSString *) stringToConvert;
@end
