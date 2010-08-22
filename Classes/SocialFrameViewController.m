//
//  SocialFrameViewController.m
//  SocialFrame
//
//  Created by Xavier Damman on 8/21/10.
//  Copyright (c) 2010 Commentag SPRL. All rights reserved.
//

#import "SocialFrameViewController.h"
#import "TweetView.h"
#import "CALayer+Additions.h"

@implementation SocialFrameViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	twitter = [[Twitter alloc] init];
	utils = [[Utility alloc] init];
	utils.delegate = self;
	
	CGRect actualBounds = CGRectMake(0.0f, 0.0f, self.view.bounds.size.height, self.view.bounds.size.width); // the ipad sdk sucks and isn't able to figure out what orientation it's in at launch time, so we hardcode it
	
	UIImageView *backgroundLayer = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"space-bg.png"]];
	backgroundLayer.contentMode = UIViewContentModeBottomLeft;
	backgroundLayer.layer.anchorPoint = CGPointMake(0.0f, 0.0f);
	backgroundLayer.layer.position = CGPointMake(0.0f, 0.0f);
	[backgroundLayer.layer animateLayerToPosition:CGPointMake((-backgroundLayer.frame.size.width) + actualBounds.size.width, (-backgroundLayer.frame.size.height) + actualBounds.size.height) overDuration:75 repeats:YES reverseForRepeat:YES];
	
	[self.view addSubview:backgroundLayer];
	[backgroundLayer release];
	
	UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 0.0f)];
	searchBar.delegate = self;
	NSString *searchText = @"#iosdevcamp";
	searchBar.text = searchText;
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:searchBar] autorelease];
	[self search:searchText];
	[searchBar release];
	
	
}



// Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)iInterfaceOrientation {
    return (iInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || iInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void) search:(NSString *)searchText {
	[utils setSearchKeyword:searchText];
	self.navigationItem.title = [NSString stringWithFormat:@"Searching for \"%@\"", searchText];
	if (!loadingView) {
		loadingView = [CALayer layer];
		loadingView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.6f].CGColor;
		loadingView.cornerRadius = 6.0f;
		loadingView.masksToBounds = YES;
		loadingView.frame = CGRectMake(0.0f, 0.0f, 140.0f, 50.0f);
		loadingView.frame = CHCenterRectInRect(loadingView.frame, self.view.bounds);
		
		CATextLayer *loadingViewText = [CATextLayer layer];
		loadingViewText.font = @"Helvetica Neue Bold";
		loadingViewText.fontSize = 20.0f;
		loadingViewText.foregroundColor = [UIColor whiteColor].CGColor;
		loadingViewText.string = @"Loading...";
		loadingViewText.alignmentMode = kCAAlignmentCenter;
		loadingViewText.frame = CGRectInset(loadingView.bounds, 0.0f, 13.0f);
		[loadingView addSublayer:loadingViewText];
		
		[self.view.layer addSublayer:loadingView];
	}
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
	NSString *searchText = searchBar.text;
	if (searchText.length > 0) {
		[utils setSearchKeyword:searchText];
		self.navigationItem.title = [NSString stringWithFormat:@"Searching for \"%@\"", searchText];
		[searchBar resignFirstResponder];
		
		if (!loadingView) {
			loadingView = [CALayer layer];
			loadingView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.6f].CGColor;
			loadingView.cornerRadius = 6.0f;
			loadingView.masksToBounds = YES;
			loadingView.frame = CGRectMake(0.0f, 0.0f, 140.0f, 50.0f);
			loadingView.frame = CHCenterRectInRect(loadingView.frame, self.view.bounds);
			
			CATextLayer *loadingViewText = [CATextLayer layer];
			loadingViewText.font = @"Helvetica Neue Bold";
			loadingViewText.fontSize = 20.0f;
			loadingViewText.foregroundColor = [UIColor whiteColor].CGColor;
			loadingViewText.string = @"Loading...";
			loadingViewText.alignmentMode = kCAAlignmentCenter;
			loadingViewText.frame = CGRectInset(loadingView.bounds, 0.0f, 13.0f);
			[loadingView addSublayer:loadingViewText];
			
			[self.view.layer addSublayer:loadingView];
			[self onTimer];
		}
	}
}

- (void) flipToNext {
	NSLog(@"Entering timer.");
	t = [utils getNext];
	NSLog(@"Next tweet: %@",t);
	[self addTweet:t];
}

- (void) addTweet:(Tweet*)theTweet {
	CALayer *tweetView;
	tweetView = [CALayer layer];
	tweetView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.6f].CGColor;
	tweetView.cornerRadius = 6.0f;
	tweetView.masksToBounds = YES;
	tweetView.frame = CGRectMake(0.0f, 0.0f, 540.0f, 250.0f);
	tweetView.frame = CHCenterRectInRect(tweetView.frame, self.view.bounds);
	
	CATextLayer *tweetViewText = [CATextLayer layer];
	tweetViewText.font = @"Helvetica Neue Bold";
	tweetViewText.fontSize = 20.0f;
	tweetViewText.foregroundColor = [UIColor whiteColor].CGColor;
	tweetViewText.string = theTweet.content;
	tweetViewText.alignmentMode = kCAAlignmentCenter;
	tweetViewText.frame = CGRectInset(tweetView.bounds, 0.0f, 13.0f);
	[tweetView addSublayer:tweetViewText];
	
	[self.view.layer addSublayer:tweetView];
	
}

// delegate callback goes here
- (void) utilityDidFinishFirstFetch {
	
	loadingView.hidden = TRUE;
	t = [utils getNext];
	NSLog(@"Next tweet: %@",t);
	[self addTweet:t];
	
	[NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(flipToNext) userInfo:nil repeats:YES];
}


- (void)dealloc {
	[twitter release];
	[utils release];
    [super dealloc];
}

@end
