//
//  Square.m
//  Sketch TNG
//
//  Created by Nathan Corvino on 3/6/15.
//  Copyright (c) 2015 Nathan Corvino. All rights reserved.
//

#import "Rectangle.h"

@implementation Rectangle

- (void)setFrame:(CGRect)frame
{
    super.frame = frame;
    CGPathRef path = CGPathCreateWithRect(CGRectMake(0., 0., frame.size.width, frame.size.height), &CGAffineTransformIdentity);
    self.shapeLayer.path = path;
    CGPathRelease(path);
}

@end
