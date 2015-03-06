//
//  CanvasViewController.m
//  Sketch TNG
//
//  Created by Nathan Corvino on 3/2/15.
//  Copyright (c) 2015 Nathan Corvino. All rights reserved.
//

#import "CanvasViewController.h"

@import QuartzCore;

@interface CanvasViewController () {
    NSMutableArray *shapes;
    CAShapeLayer *selectedShape;
    CGSize originalSize;
}

@end


@implementation CanvasViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    shapes = [NSMutableArray array];
}

- (void)viewWillAppear
{
    self.canvasView.layer.backgroundColor = [NSColor whiteColor].CGColor;
}

- (IBAction)addShape:(id)sender
{
    CAShapeLayer *shape = [CAShapeLayer layer];
    CGRect parentFrame = self.canvasView.frame;

    shape.frame = CGRectMake((parentFrame.size.width - 25.) / 2., (parentFrame.size.height - 25.) / 2., 50., 50.);
    shape.path = CGPathCreateWithEllipseInRect(CGRectMake(0., 0., 50., 50.), &CGAffineTransformIdentity);
    shape.fillColor = [NSColor colorWithRed:137./255. green:180./255. blue:230./255. alpha:1.].CGColor;
    shape.strokeColor = [NSColor blackColor].CGColor;

    [shapes addObject:shape];

    [self.canvasView.layer addSublayer:shape];
}

- (void)sendShapeSelectedNotification
{
    if (selectedShape) {
        [[NSNotificationCenter defaultCenter] postNotificationName:SHAPE_BECAME_SELECTED object:nil userInfo:@{ SELECTED_SHAPE : selectedShape }];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:SHAPE_BECAME_DESELECTED object:nil];
    }
}

- (IBAction)dragWithGestureRecognizer:(NSPanGestureRecognizer *)panner
{
    if (panner.state == NSGestureRecognizerStateBegan) {
        selectedShape = [self selectShapeAtLocation:[panner locationInView:self.canvasView]];
        if (selectedShape) {
            [panner setTranslation:selectedShape.frame.origin inView:self.canvasView];
        }
        [self sendShapeSelectedNotification];
    } else if (selectedShape) {
        switch (panner.state) {
            case NSGestureRecognizerStateChanged: {
                CGRect frame = selectedShape.frame;
                frame.origin = [panner translationInView:self.canvasView];
                [CATransaction begin];
                [CATransaction setDisableActions:YES];
                selectedShape.frame = frame;
                [CATransaction commit];
                [[NSNotificationCenter defaultCenter] postNotificationName:SHAPE_ATTRIBUTES_CHANGED object:nil];
                break;
            }

            default:
                break;
        }
    }
}

- (IBAction)magnifyWithGestureRecognizer:(NSMagnificationGestureRecognizer *)magnifier
{
    if (magnifier.state == NSGestureRecognizerStateBegan) {
        selectedShape = [self selectShapeAtLocation:[magnifier locationInView:self.canvasView]];
        originalSize = selectedShape.frame.size;
        [self sendShapeSelectedNotification];
    } else if (selectedShape) {
        switch (magnifier.state) {
            case NSGestureRecognizerStateChanged: {
                NSLog(@"Magnification: %f", magnifier.magnification);
                CGRect frame = selectedShape.frame;
                frame.size.width = originalSize.width + originalSize.width * magnifier.magnification;
                frame.size.height = originalSize.height + originalSize.height * magnifier.magnification;
                [CATransaction begin];
                [CATransaction setDisableActions:YES];
                // FIXME: This needs to go in a "model" object.
                selectedShape.path = CGPathCreateWithEllipseInRect(CGRectMake(0., 0., frame.size.width, frame.size.height), &CGAffineTransformIdentity);
                selectedShape.frame = frame;
                [CATransaction commit];
                [[NSNotificationCenter defaultCenter] postNotificationName:SHAPE_ATTRIBUTES_CHANGED object:nil];
            }

            default:
                break;
        }
    }
}

- (IBAction)clickWithGestureRecognizer:(NSClickGestureRecognizer *)clicker
{
    selectedShape = [self selectShapeAtLocation:[clicker locationInView:self.canvasView]];
    [self sendShapeSelectedNotification];
}

- (CAShapeLayer *)selectShapeAtLocation:(CGPoint)point
{
    CAShapeLayer *retval = nil;
    for (CAShapeLayer *shape in shapes) {
        if (NSPointInRect(point, shape.frame)) {
            CGPoint translatedPoint = CGPointMake(point.x - shape.frame.origin.x, point.y - shape.frame.origin.y);
            if (CGPathContainsPoint(shape.path, &CGAffineTransformIdentity, translatedPoint, false)) {
                retval = shape;
                break;
            }
        }
    }
    return retval;
}

@end
