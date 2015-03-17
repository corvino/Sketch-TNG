//
//  Shape.m
//  Sketch TNG
//
//  Created by Nathan Corvino on 3/6/15.
//  Copyright (c) 2015 Nathan Corvino. All rights reserved.
//

#import "Graphic.h"

@implementation Graphic

- (instancetype)init
{
    self = [super init];
    if (self) {
        _shouldFill = YES;
        _shouldStroke = YES;
        _strokeWidth = 1.;
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    _frame = frame;
    self.layer.frame = frame;
}

- (BOOL)containsPointInBounds:(CGPoint)point
{
    return YES;
}

@end
