//
//  TweetWallViewController.m
//  TweetWall
//
//  Created by Xavier Damman on 8/21/10.
//  Copyright (c) 2010 Xavier Damman. All rights reserved.
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
	//[backgroundLayer.layer animateLayerToPosition:CGPointMake((-backgroundLayer.frame.size.width) + actualBounds.size.width, (-backgroundLayer.frame.size.height) + actualBounds.size.height) overDuration:120 repeats:YES reverseForRepeat:YES];
	
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
		}
	}
}

- (void) addTweet:(Tweet*)tweet {


	[UIView beginAnimations:nil context:nil];
	
	// create imageView for tweet text bubble background	
	CGRect Imageframe2 = CGRectMake(20.0, 196.0, 990.0, 360.0);
	UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:Imageframe2];
	NSString *fileLocation = [[NSBundle mainBundle] pathForResource:@"large-speech-bubble" ofType:@"png"];
	NSData *imageData = [NSData dataWithContentsOfFile:fileLocation];	
	[UIImage imageWithData:imageData];
	imageView2.image = [UIImage imageWithData:imageData];
	[self.view addSubview:imageView2];
	// end bubble background
	
	
	// create imageView for user image background	
	CGRect Imageframe3 = CGRectMake(20.0, 562.0, 600.0, 164.0);
	UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:Imageframe3];
	NSString *fileLocation3 = [[NSBundle mainBundle] pathForResource:@"user-block-bg" ofType:@"png"];
	NSData *imageData3 = [NSData dataWithContentsOfFile:fileLocation3];	
	[UIImage imageWithData:imageData3];
	imageView3.image = [UIImage imageWithData:imageData3];
	[self.view addSubview:imageView3];
	// end bubble background
	
	
	// textView for Tweet text
	if(!textView) {
		CGRect tweetFrame = CGRectMake(40.0, 210.0, 950.0, 250.0);
		textView = [[UITextView alloc] initWithFrame:tweetFrame];
	}
	
	textView.text = tweet.content;
	textView.font = [UIFont fontWithName:@"Arial" size:44.0f];
	UIColor *bcolor = [[UIColor alloc] initWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
	[textView setBackgroundColor: bcolor];
	[self.view addSubview:textView];
	// end textview
	
	// begin uilabel for user name
	if(!screenNameView) {
		CGRect labelFrame = CGRectMake(230.0, 580.0, 300.0, 50.0);	
		screenNameView = [[UILabel alloc] initWithFrame:labelFrame];
	}
	screenNameView.text = tweet.screenName;
	screenNameView.font = [UIFont fontWithName:@"Arial" size:34.0f];
	[screenNameView setBackgroundColor: bcolor];
	[self.view addSubview:screenNameView];	
	// end uilable
	
	
/*	
	// create imageView
	NSURL *url = [NSURL URLWithString:[tweet objectForKey:@"profile_image_url"]];
	NSData *data = [NSData dataWithContentsOfURL:url];
	CGRect Imageframe = CGRectMake(36.0, 574.0, 130.0, 130.0);
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:Imageframe];
	imageView.image = [UIImage imageWithData:data];
	[self.view addSubview:imageView];
	// end imageView
*/	
	
	// create imageView
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(36.0, 574.0, 130.0, 130.0)];
	imageView.image = [[ImageLoader loadImageFromURL:tweet.avatar] retain];
	[self.view addSubview:imageView];
	// end imageView
	
	[bcolor release];
	
/*	
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
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
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
