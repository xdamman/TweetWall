//
//  CALayer+Additions.m
//  A Quiet Mind
//
//  Created by Joel Levin on 8/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CALayer+Additions.h"


@implementation CALayer (Additions)

- (CABasicAnimation *)animateLayerToPosition:(CGPoint)newPosition overDuration:(NSTimeInterval)theDuration repeats:(BOOL)repeatsFlag reverseForRepeat:(BOOL)autoreversesFlag
{
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
	animation.fromValue = [self valueForKey:@"position"];
	animation.toValue = [NSValue valueWithCGPoint:newPosition];
	animation.duration = theDuration;
	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	
	if (repeatsFlag)
		animation.repeatCount = HUGE_VALF;
	
	if (autoreversesFlag)
		animation.autoreverses = YES;
	
	self.position = newPosition;
	[self addAnimation:animation forKey:@"position"];
	
	return animation;
}

@end
