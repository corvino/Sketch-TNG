//
//  Circle.m
//  Sketch TNG
//
//  Created by Nathan Corvino on 3/6/15.
//  Copyright (c) 2015 Nathan Corvino. All rights reserved.
//

#import "Circle.h"

@interface Circle() {
    CAShapeLayer *_layer;
}

@property (nonatomic, readonly) CAShapeLayer *shapeLayer;

@end


@implementation Circle

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

- (void)setFrame:(CGRect)frame
{
    super.frame = frame;
    self.shapeLayer.path = CGPathCreateWithEllipseInRect(CGRectMake(0., 0., frame.size.width, frame.size.height), &CGAffineTransformIdentity);
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
