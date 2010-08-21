//
//  SocialFrameViewController.h
//  SocialFrame
//
//  Created by Xavier Damman on 8/21/10.
//  Copyright (c) 2010 Commentag SPRL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Twitter.h"
#import "Utility.h"

@interface SocialFrameViewController : UIViewController {
	IBOutlet UIButton *playBtn;
	IBOutlet UIToolbar *toolbar;
	IBOutlet UILabel *label1;
	IBOutlet UISearchBar *searchbar;
	IBOutlet UIScrollView *scrollView;
	
	Twitter *twitter;
	Utility *utils;
}

- (IBAction) clickButton;
- (id) loadWithNibName: (NSString *)nibName;

@end

