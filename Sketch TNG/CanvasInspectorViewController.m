//
//  CanvasInspectorViewController.m
//  Sketch TNG
//
//  Created by Nathan Corvino on 3/5/15.
//  Copyright (c) 2015 Nathan Corvino. All rights reserved.
//

#import "CanvasInspectorViewController.h"

@import QuartzCore;

#import "CanvasViewController.h"

@interface NumericOnlyFormatter : NSNumberFormatter
@end

@implementation NumericOnlyFormatter

- (BOOL)isPartialStringValid:(NSString **)partialStringPtr
       proposedSelectedRange:(NSRangePointer)proposedSelRangePtr
              originalString:(NSString *)origString
       originalSelectedRange:(NSRange)origSelRange
            errorDescription:(NSString **)error
{
    // Not the most sophisticated check, but good enough for now.
    BOOL valid = YES;
    NSString *input = *partialStringPtr;
    for (NSUInteger i = 0; i < input.length; i++) {
        if (!isnumber([input characterAtIndex:i])) {
            valid = NO;
        }
    }
    return valid;
}

@end

@interface CanvasInspectorViewController () {
    CAShapeLayer *selectedShape;
}

@end

@implementation CanvasInspectorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shapeSelected:) name:SHAPE_BECAME_SELECTED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shapeChanged:) name:SHAPE_ATTRIBUTES_CHANGED object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)readShapeAttributes
{
    if (selectedShape) {
        self.fillColorWell.color = [NSColor colorWithCGColor:selectedShape.fillColor];
        self.strokeColorWell.color = [NSColor colorWithCGColor:selectedShape.strokeColor];

        double lineWidth = fmax(fmin(selectedShape.lineWidth, 100.), 0.);
        self.lineWidthSlider.doubleValue = lineWidth;
        self.lineWidthTextField.stringValue = [NSString stringWithFormat:@"%0.1f", selectedShape.lineWidth];

        self.xTextField.stringValue = [NSString stringWithFormat:@"%0.1f", selectedShape.frame.origin.x];
        self.yTextField.stringValue = [NSString stringWithFormat:@"%0.1f", selectedShape.frame.origin.y];
        self.widthTextField.stringValue = [NSString stringWithFormat:@"%0.1f", selectedShape.frame.size.width];
        self.heightTextField.stringValue = [NSString stringWithFormat:@"%0.1f", selectedShape.frame.size.height];
    }
}

#pragma mark - Attribute Adjustment Actions

- (void)shapeSelected:(NSNotification *)notification
{
    selectedShape = notification.userInfo[SELECTED_SHAPE];
    [self readShapeAttributes];
}

- (void)shapeChanged:(NSNotification *)notification
{
    [self readShapeAttributes];
}

- (IBAction)lineWidthSliderChanged:(id)sender
{
    selectedShape.lineWidth = self.lineWidthSlider.doubleValue;
    self.lineWidthTextField.stringValue = [NSString stringWithFormat:@"%0.1f", selectedShape.lineWidth];
}

- (IBAction)lineWidthTextReceived:(id)sender
{
    selectedShape.lineWidth = self.lineWidthTextField.floatValue;
    self.lineWidthSlider.doubleValue = selectedShape.lineWidth;
}

- (IBAction)strokeColorChanged:(NSColorWell *)sender
{
    selectedShape.strokeColor = sender.color.CGColor;
}

- (IBAction)fillColorChanged:(NSColorWell *)sender
{
    selectedShape.fillColor = sender.color.CGColor;
}

- (IBAction)textInputReceived:(id)sender
{
    CGRect frame = CGRectMake(self.xTextField.floatValue, self.yTextField.floatValue, self.widthTextField.floatValue, self.heightTextField.floatValue);
    selectedShape.frame = frame;
}

@end
