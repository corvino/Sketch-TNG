//
//  Triangle.m
//  Sketch TNG
//
//  Created by Nathan Corvino on 3/6/15.
//  Copyright (c) 2015 Nathan Corvino. All rights reserved.
//

#import "Triangle.h"

@implementation Triangle

- (void)setFrame:(CGRect)frame
{
    super.frame = frame;

    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, &CGAffineTransformIdentity, 0., 0.);
    CGPathAddLineToPoint(path, &CGAffineTransformIdentity, frame.size.width, 0.);
    CGPathAddLineToPoint(path, &CGAffineTransformIdentity, frame.size.width / 2., frame.size.height);
    CGPathCloseSubpath(path);

    self.shapeLayer.path = path;
    CGPathRelease(path);
}

@end
