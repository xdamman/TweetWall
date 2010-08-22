//
//  TweetWallAppDelegate.h
//  TweetWall
//
//  Created by Xavier Damman on 8/21/10.
//  Copyright (c) 2010 Commentag SPRL. All rights reserved.
//


#import <UIKit/UIKit.h>

@class TweetWallViewController;

@interface TweetWallAppDelegate : NSObject <UIApplicationDelegate> {

    UIWindow *window;

    TweetWallViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;


@property (nonatomic, retain) IBOutlet TweetWallViewController *viewController;

@end

