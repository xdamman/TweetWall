//
//  Tweet3ViewController.m
//  Tweet3
//
//  Created by Stefan Gorzkiewicz on 8/21/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "Tweet3ViewController.h"

@implementation Tweet3ViewController


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


- (void)viewDidLoad {
    [super viewDidLoad];
	jsonData = [[NSMutableString alloc] initWithString:@""];
	NSString *searchQuery = [NSString stringWithString:@"q=iosdevcamp"];
	NSString *urlString = [NSString stringWithFormat:@"http://search.twitter.com/search.json?%@", searchQuery];	
	NSURL *url = [NSURL URLWithString:urlString];
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	[connection release];
	[request release];
}
 


-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{
	NSString *partialData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	[jsonData appendString:partialData];   
    [partialData release];
}

/*
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary *twitterJSON = [jsonData JSONValue];
	
    NSArray *tweets = [twitterJSON objectForKey:@"results"];
    NSLog(@"found %d tweets", [tweets count]);
	
    NSDictionary *tweet = [tweets objectAtIndex:0]; // get the last tweet
	
	
	// textView for Tweet text
	CGRect tweetFrame = CGRectMake(40.0, 210.0, 950.0, 250.0);
	UITextView *textView = [[UITextView alloc] initWithFrame:tweetFrame];
	textView.text = [tweet objectForKey:@"text"];
	textView.font = [UIFont fontWithName:@"Arial" size:44.0f];
	UIColor *bcolor = [[UIColor alloc] initWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
	[textView setBackgroundColor: bcolor];
	[self.view addSubview:textView];
	// end textview
	
	// begin uilabel for user name
	CGRect labelFrame = CGRectMake(230.0, 580.0, 200.0, 50.0);	
	UILabel *userName = [[UILabel alloc] initWithFrame:labelFrame];
	userName.text = [tweet objectForKey:@"from_user"];
	userName.font = [UIFont fontWithName:@"Arial" size:34.0f];
	[userName setBackgroundColor: bcolor];
	[self.view addSubview:userName];	
	// end uilable
	
			
	// create imageView
	NSURL *url = [NSURL URLWithString:[tweet objectForKey:@"profile_image_url"]];
	NSData *data = [NSData dataWithContentsOfURL:url];
	CGRect Imageframe = CGRectMake(36.0, 574.0, 130.0, 130.0);
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:Imageframe];
	imageView.image = [UIImage imageWithData:data];
	[self.view addSubview:imageView];
	// end imageView
	
	[bcolor release];
		
}
*/

/*
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	// version 2 
	
    NSDictionary *twitterJSON = [jsonData JSONValue];
	
    NSArray *tweets = [twitterJSON objectForKey:@"results"];
    NSLog(@"found %d tweets", [tweets count]);
	
    NSDictionary *tweet = [tweets objectAtIndex:0]; // get the last tweet
	
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
	CGRect tweetFrame = CGRectMake(40.0, 210.0, 950.0, 250.0);
	UITextView *textView = [[UITextView alloc] initWithFrame:tweetFrame];
	textView.text = [tweet objectForKey:@"text"];
	textView.font = [UIFont fontWithName:@"Arial" size:44.0f];
	UIColor *bcolor = [[UIColor alloc] initWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
	[textView setBackgroundColor: bcolor];
	[self.view addSubview:textView];
	// end textview
	
	// begin uilabel for user name
	CGRect labelFrame = CGRectMake(230.0, 580.0, 300.0, 50.0);	
	UILabel *userName = [[UILabel alloc] initWithFrame:labelFrame];
	userName.text = [tweet objectForKey:@"from_user"];
	userName.font = [UIFont fontWithName:@"Arial" size:34.0f];
	[userName setBackgroundColor: bcolor];
	[self.view addSubview:userName];	
	// end uilable
	
	
	// create imageView
	NSURL *url = [NSURL URLWithString:[tweet objectForKey:@"profile_image_url"]];
	NSData *data = [NSData dataWithContentsOfURL:url];
	CGRect Imageframe = CGRectMake(36.0, 574.0, 130.0, 130.0);
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:Imageframe];
	imageView.image = [UIImage imageWithData:data];
	[self.view addSubview:imageView];
	// end imageView
	
	[bcolor release];
	
}
*/

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	// version 2 
	
    NSDictionary *twitterJSON = [jsonData JSONValue];
	
    NSArray *tweets = [twitterJSON objectForKey:@"results"];
    NSLog(@"found %d tweets", [tweets count]);
	
    NSDictionary *tweet = [tweets objectAtIndex:0]; // get the last tweet
	
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
	
	//image view for twitpic
	CGRect Imageframe4 = CGRectMake(40.0, 214.0, 940.0, 268.0);
	UIImageView *imageView4 = [[UIImageView alloc] initWithFrame:Imageframe4];
	NSString *fileLocation4 = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"jpg"];
	NSData *imageData4 = [NSData dataWithContentsOfFile:fileLocation4];	
	[UIImage imageWithData:imageData4];
	imageView4.image = [UIImage imageWithData:imageData4];
	[self.view addSubview:imageView4];
	// end twitpic
	
	
	// textView for Tweet text
	CGRect tweetFrame = CGRectMake(40.0, 400.0, 940.0, 80.0);
	UITextView *textView = [[UITextView alloc] initWithFrame:tweetFrame];
	textView.text = [tweet objectForKey:@"text"];
	textView.font = [UIFont fontWithName:@"Arial" size:26.0f];
	UIColor *bcolor = [[UIColor alloc] initWithRed:0.0 green:0.0 blue:0.0 alpha:0.6];
	UIColor *fcolor = [[UIColor alloc] initWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
	[textView setBackgroundColor: bcolor];
	textView.textColor = fcolor;
	[self.view addSubview:textView];
	// end textview
	
	// begin uilabel for user name
	CGRect labelFrame = CGRectMake(230.0, 580.0, 300.0, 50.0);	
	UILabel *userName = [[UILabel alloc] initWithFrame:labelFrame];
	userName.text = [tweet objectForKey:@"from_user"];
	userName.font = [UIFont fontWithName:@"Arial" size:34.0f];
	UIColor *bcolor2 = [[UIColor alloc] initWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
	[userName setBackgroundColor: bcolor2];
	[self.view addSubview:userName];	
	// end uilable
	
	
	// create imageView
	NSURL *url = [NSURL URLWithString:[tweet objectForKey:@"profile_image_url"]];
	NSData *data = [NSData dataWithContentsOfURL:url];
	CGRect Imageframe = CGRectMake(36.0, 574.0, 130.0, 130.0);
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:Imageframe];
	imageView.image = [UIImage imageWithData:data];
	[self.view addSubview:imageView];
	// end imageView
	
	[bcolor release];
	
}





	
// Override to allow orientations other than the default portrait orientation.
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


- (void)dealloc {
    [super dealloc];
}

@end
