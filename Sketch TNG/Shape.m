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

- (void)setShouldFill:(BOOL)shouldFill
{
    super.shouldFill = shouldFill;
    if (shouldFill) {
        self.shapeLayer.fillColor = self.fillColor.CGColor;
    } else {
        self.shapeLayer.fillColor = [NSColor clearColor].CGColor;
    }
}

- (void)setShouldStroke:(BOOL)shouldStroke
{
    super.shouldStroke = shouldStroke;
    if (shouldStroke) {
        self.shapeLayer.strokeColor = self.strokeColor.CGColor;
        self.shapeLayer.lineWidth = self.strokeWidth;
    } else {
        self.shapeLayer.strokeColor = [NSColor clearColor].CGColor;
        self.shapeLayer.lineWidth = 0.;
    }
}

- (void)setFillColor:(NSColor *)fillColor
{
    super.fillColor = fillColor;
    if (self.shouldFill) {
        self.shapeLayer.fillColor = fillColor.CGColor;
    }
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
