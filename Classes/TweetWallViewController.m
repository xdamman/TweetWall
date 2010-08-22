//
//  TweetWallViewController.m
//  TweetWall
//
//  Created by Xavier Damman on 8/21/10.
//  Copyright (c) 2010 Commentag SPRL. All rights reserved.
//

#import "TweetWallViewController.h"
#import "TweetView.h"
#import "CALayer+Additions.h"

@implementation TweetWallViewController

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
	NSString *searchText = @"#iosdevcamp twitpic";
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
		}
	}
}

- (void) addTweet:(Tweet*)tweet {


	[UIView beginAnimations:nil context:nil];
	
	// textView for Tweet text
	CGRect tweetFrame = CGRectMake(200.0, 300.0, 600.0, 300.0);
	UITextView *textView = [[UITextView alloc] initWithFrame:tweetFrame];
	textView.text = tweet.content;
	textView.font = [UIFont fontWithName:@"Arial" size:48.0f];
	[self.view addSubview:textView];
	// end textview
	
		
	// begin uilabel for user name
	CGRect labelFrame = CGRectMake(300.0, 50.0, 400.0, 50.0);	
	UILabel *userName = [[UILabel alloc] initWithFrame:labelFrame];
	userName.text = tweet.screenName;
	userName.font = [UIFont fontWithName:@"Arial" size:48.0f];
	[self.view addSubview:userName];	
	// end uilable
	
	// create imageView
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(40.0, 40.0, 200.0, 200.0)];
	imageView.image = [[ImageLoader loadImageFromURL:tweet.avatar] retain];
//	[[UIImageView alloc] initWithFrame:Imageframe];
//	imageView.image = [UIImage imageWithData:data];
	[self.view addSubview:imageView];
	// end imageView
	
	
	/*
	UIWebView* webview = [[UIWebView alloc] initWithFrame:CGRectMake(0.0f, 44.0f, 500, 324)];
	webview.frame = CHCenterRectInRect(webview.frame, self.view.bounds);

	webview.delegate = self;
	
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:t.permalink];
	
	//load the URL into the web view.
	[webview loadRequest:requestObj];
	
	//add the web view to the content view
	[self.view addSubview:webview];
	 */
	
	[UIView setAnimationDuration:2.75];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
	//[textView removeFromSuperview];
	[UIView commitAnimations];
	
	
	
}

- (void) flipToNext {
	NSLog(@"Entering timer.");
	t = [utils getNext];
	NSLog(@"Next tweet: %@",t);
	[self addTweet:t];
}


// delegate callback goes here
- (void) utilityDidFinishFirstFetch {
	
	loadingView.hidden = TRUE;
	t = [utils getNext];
	NSLog(@"Next tweet: %@",t);
	[self addTweet:t];
	
	if (!rat) {
		rat = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(flipToNext) userInfo:nil repeats:YES];
	}
}

- (void)dealloc {
	[twitter release];
	[utils release];
    [super dealloc];
}

@end
