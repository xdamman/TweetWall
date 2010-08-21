//
//  SocialFrameAppDelegate.h
//  SocialFrame
//
//  Created by Xavier Damman on 8/21/10.
//  Copyright (c) 2010 Commentag SPRL. All rights reserved.
//


#import <UIKit/UIKit.h>

@class SocialFrameViewController;

@interface SocialFrameAppDelegate : NSObject <UIApplicationDelegate> {

    UIWindow *window;

    SocialFrameViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;


@property (nonatomic, retain) IBOutlet SocialFrameViewController *viewController;

@end

