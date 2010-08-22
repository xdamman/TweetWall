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
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:searchBar] autorelease];
	[searchBar release];
}



// Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)iInterfaceOrientation {
    return (iInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || iInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
	NSString *searchText = searchBar.text;
	if (searchText.length > 0) {
		self.navigationItem.title = [NSString stringWithFormat:@"Searching for \"%@\"", searchText];
		[searchBar resignFirstResponder];	
	}
}


//- (IBAction) clickButton {
//	NSLog(@"Click %@",searchbar.text);
//	NSArray *tweets = [utils getTwitListByKeyword:searchbar.text]; //[twitter searchByKeyword:searchbar.text limit:10];
//	
//	NSLog(@"tweets: %@",tweets);
//
//}


- (void)dealloc {
	[twitter release];
	[utils release];
    [super dealloc];
}

@end
