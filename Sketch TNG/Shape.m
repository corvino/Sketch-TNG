//
//  Shape.m
//  Sketch TNG
//
//  Created by Nathan Corvino on 3/6/15.
//  Copyright (c) 2015 Nathan Corvino. All rights reserved.
//

#import "Shape.h"

@interface Shape() {
    CAShapeLayer *_layer;
}

@end


@implementation Shape

- (CALayer *)layer
{
    if (!_layer) {
        _layer = [CAShapeLayer layer];
    }
    return _layer;
}

- (CAShapeLayer *)shapeLayer
{
    return (CAShapeLayer *)self.layer;
}

- (void)setFillColor:(NSColor *)fillColor
{
    super.fillColor = fillColor;
    self.shapeLayer.fillColor = fillColor.CGColor;
}

- (void)setStrokeColor:(NSColor *)strokeColor
{
    super.strokeColor = strokeColor;
    self.shapeLayer.strokeColor = strokeColor.CGColor;
}

- (void)setStrokeWidth:(CGFloat)strokeWidth
{
    super.strokeWidth = strokeWidth;
    self.shapeLayer.lineWidth = strokeWidth;
}

- (BOOL)containsPointInBounds:(CGPoint)point
{
    return (BOOL) CGPathContainsPoint(self.shapeLayer.path, &CGAffineTransformIdentity, point, false);
}

@end
