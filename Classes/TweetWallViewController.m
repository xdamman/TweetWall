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

	[ImageLoader clean];

	twitter = [[Twitter alloc] init];
	utils = [[Utility alloc] init];
	utils.delegate = self;
	
	//CGRect actualBounds = CGRectMake(0.0f, 0.0f, self.view.bounds.size.height, self.view.bounds.size.width); // the ipad sdk sucks and isn't able to figure out what orientation it's in at launch time, so we hardcode it
	
	backgroundLayer = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"space-bg.png"]];
	backgroundLayer.contentMode = UIViewContentModeBottomLeft;
	backgroundLayer.layer.anchorPoint = CGPointMake(0.0f, 0.0f);
	backgroundLayer.layer.position = CGPointMake(0.0f, 0.0f);
	//[backgroundLayer.layer animateLayerToPosition:CGPointMake((-backgroundLayer.frame.size.width) + actualBounds.size.width, (-backgroundLayer.frame.size.height) + actualBounds.size.height) overDuration:120 repeats:YES reverseForRepeat:YES];
	
	[self.view addSubview:backgroundLayer];
	[backgroundLayer release];
	
	UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 0.0f)];
	searchBar.delegate = self;
	NSString *searchText = @"\"I'm happy\"";
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
		loadingView.frame = CHCenterRectInRect(CGRectMake(0.0f, 0.0f, 280.0f, 80.0f), CGRectMake(0.0, 0.0, 1024.0, 768.0));
		
		loadingViewText = [CATextLayer layer];
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
			
			loadingViewText = [CATextLayer layer];
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

	UIImage *backgroundImage;
	if (tweet.user) {
		NSString *backgroundImageUrl = [tweet.user objectForKey:@"profile_background_image_url"];
		backgroundImage = [ImageLoader loadImageFromURL:[NSURL URLWithString:backgroundImageUrl]];
		
	}
	else {
		NSLog(@"no userinfo");
		backgroundImage = [UIImage imageNamed:@"space-bg.png"];
	}

	UIColor *transparentColor = [[UIColor alloc] initWithRed:255.0 green:255.0 blue:255.0 alpha:0.0];

	UIImageView *tweetView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 1024.0, 768.0)];
	
	
	if (tweet.user) {
		NSLog(@"Tiling %@: %@",[[tweet.user objectForKey:@"profile_background_tile"] class],[tweet.user objectForKey:@"profile_background_tile"]);
		if ([tweet.user objectForKey:@"profile_background_tile"]) {
			NSLog(@"Tiling this background !!!!");
			tweetView.backgroundColor = [[UIColor alloc] initWithPatternImage:backgroundImage];
		}
		else {
			tweetView.backgroundColor = [self colorWithHexString:[tweet.user objectForKey:@"profile_background_color"]];
			
			UIGraphicsBeginImageContext(CGSizeMake(1024.0, 768.0));
			[backgroundImage drawAtPoint:CGPointMake(0.0, 0.0)];
			UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
			UIGraphicsEndImageContext();
			tweetView.image = outputImage;
		}
	}

	
	/*
	if(previousTweetView)
		[previousTweetView removeFromSuperview];
	*/
	// create imageView for tweet text bubble background	
	CGRect Imageframe2 = CGRectMake(20.0, 196.0, 990.0, 360.0);
	UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:Imageframe2];
	NSString *fileLocation = [[NSBundle mainBundle] pathForResource:@"large-speech-bubble" ofType:@"png"];
	NSData *imageData = [NSData dataWithContentsOfFile:fileLocation];	
	[imageView2 setBackgroundColor:transparentColor];
	imageView2.image = [UIImage imageWithData:imageData];

	[tweetView addSubview:imageView2];
	// end bubble background
	
	
	// create imageView for user image background	
	CGRect Imageframe3 = CGRectMake(20.0, 562.0, 600.0, 164.0);
	UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:Imageframe3];
	NSString *fileLocation3 = [[NSBundle mainBundle] pathForResource:@"user-block-bg" ofType:@"png"];
	NSData *imageData3 = [NSData dataWithContentsOfFile:fileLocation3];	
	[UIImage imageWithData:imageData3];
	imageView3.image = [UIImage imageWithData:imageData3];
	[tweetView addSubview:imageView3];
	// end bubble background
	
	
	// textView for Tweet text
	if(!textView) {
		CGRect tweetFrame = CGRectMake(40.0, 210.0, 960.0, 250.0);
		textView = [[UITextView alloc] initWithFrame:tweetFrame];
		[textView setBackgroundColor: transparentColor];
	}
	
	textView.text = tweet.content;
	textView.font = [UIFont fontWithName:@"Arial" size:44.0f];
	[tweetView addSubview:textView];
	// end textview
	
	// begin uilabel for user name
	if(!screenNameView) {
		CGRect labelFrame = CGRectMake(230.0, 580.0, 300.0, 50.0);	
		screenNameView = [[UILabel alloc] initWithFrame:labelFrame];
	}
	
	screenNameView.text = tweet.screenName;
	screenNameView.font = [UIFont fontWithName:@"Arial" size:34.0f];
	[screenNameView setBackgroundColor: transparentColor];
	[tweetView addSubview:screenNameView];	
	// end uilable
		
	// create imageView
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(36.0, 574.0, 130.0, 130.0)];
	imageView.image = [[ImageLoader loadImageFromURL:tweet.avatar] retain];
	[tweetView addSubview:imageView];
	// end imageView
	[transparentColor release];

	[self.view addSubview:tweetView];
	
	[UIView setAnimationDuration:2.75];
	
	[UIView setAnimationDelegate:previousTweetView];
	[UIView setAnimationDidStopSelector:@selector(removeFromSuperview)];
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
	//[textView removeFromSuperview];
	[UIView commitAnimations];
	
	previousTweetView = tweetView;
	
}

- (void) flipToNext {
	t = [utils getNext];
	if(t)
		[self addTweet:t];
}


// delegate callback goes here
- (void) searchTwitterDidFinishSuccessfully {	
	loadingView.hidden = TRUE;
	t = [utils getNext];
	NSLog(@"Next tweet: %@",t);
	[self addTweet:t];
	
	if (!rat) {
		rat = [NSTimer scheduledTimerWithTimeInterval:6 target:self selector:@selector(flipToNext) userInfo:nil repeats:YES];
	}
}

- (void) searchTwitterDidFinishWithNoResults {	
	loadingView.hidden = FALSE;
	loadingViewText.string = @"Couldn't connect\nto Twitter.com";
}


- (UIColor *) colorWithHexString: (NSString *) stringToConvert
{
	UIColor *DEFAULT_VOID_COLOR = [UIColor colorWithWhite:0 alpha:0];
	NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
	
	// String should be 6 or 8 characters
	if ([cString length] < 6) return DEFAULT_VOID_COLOR;
	
	// strip 0X if it appears
	if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
	
	if ([cString length] != 6) return DEFAULT_VOID_COLOR;
	
	// Separate into r, g, b substrings
	NSRange range;
	range.location = 0;
	range.length = 2;
	NSString *rString = [cString substringWithRange:range];
	
	range.location = 2;
	NSString *gString = [cString substringWithRange:range];
	
	range.location = 4;
	NSString *bString = [cString substringWithRange:range];
	
	// Scan values
	unsigned int r, g, b;
	[[NSScanner scannerWithString:rString] scanHexInt:&r];
	[[NSScanner scannerWithString:gString] scanHexInt:&g];
	[[NSScanner scannerWithString:bString] scanHexInt:&b];
	
	return [UIColor colorWithRed:((float) r / 255.0f)
						   green:((float) g / 255.0f)
							blue:((float) b / 255.0f)
						   alpha:1.0f];
}

- (void)dealloc {

	[backgroundLayer release];
	[twitter release];
	[utils release];
    [super dealloc];
}

@end
