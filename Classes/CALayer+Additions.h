//
//  CALayer+Additions.h
//  A Quiet Mind
//
//  Created by J
//

#import <Foundation/Foundation.h>


@interface CALayer (Additions)

- (CABasicAnimation *)animateLayerToPosition:(CGPoint)newPosition overDuration:(NSTimeInterval)theDuration repeats:(BOOL)repeatsFlag reverseForRepeat:(BOOL)autoreversesFlag;

@end
