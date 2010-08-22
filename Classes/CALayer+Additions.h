//
//  CALayer+Additions.h
//  A Quiet Mind
//
//  Created by Joel Levin on 8/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CALayer (Additions)

- (CABasicAnimation *)animateLayerToPosition:(CGPoint)newPosition overDuration:(NSTimeInterval)theDuration repeats:(BOOL)repeatsFlag reverseForRepeat:(BOOL)autoreversesFlag;

@end
