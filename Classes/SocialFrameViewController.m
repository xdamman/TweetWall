//
//  SocialFrameViewController.m
//  SocialFrame
//
//  Created by Xavier Damman on 8/21/10.
//  Copyright (c) 2010 Commentag SPRL. All rights reserved.
//

#import "SocialFrameViewController.h"
#import "TweetView.h"

@implementation SocialFrameViewController



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	TweetView *tweetView = [self loadWithNibName:@"TweetView"];
	twitter = [[Twitter alloc] init];
	searchbar.text = @"#iosdevcamp";
	[scrollView addSubview:tweetView];
}

- (id) loadWithNibName: (NSString *)nibName {
	NSArray *array = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
	for (id obj in array) {
		if ([obj isKindOfClass:[UIView class]]) {
			return obj;
		}
	}
	return nil;
}


// Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;

}

- (IBAction) clickButton {
	NSLog(@"Click %@",searchbar.text);
	NSArray *tweets = [twitter searchByKeyword:searchbar.text limit:10];
	NSLog(@"tweets: %@",tweets);
}


- (void)dealloc {
	[twitter dealloc];
    [super dealloc];
}

@end
