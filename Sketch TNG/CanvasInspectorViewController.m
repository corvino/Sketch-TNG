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
#import "Graphic.h"

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
    Graphic *selectedShape;
}

@end

@implementation CanvasInspectorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self disableShapeAttributes];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shapeSelected:) name:SHAPE_BECAME_SELECTED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shapeDeselected:) name:SHAPE_BECAME_DESELECTED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shapeChanged:) name:SHAPE_ATTRIBUTES_CHANGED object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)readShapeAttributes
{
    if (selectedShape) {
        self.fillColorWell.color = selectedShape.fillColor;
        self.strokeColorWell.color = selectedShape.strokeColor;

        double lineWidth = fmax(fmin(selectedShape.strokeWidth, 100.), 0.);
        self.lineWidthSlider.doubleValue = lineWidth;
        self.lineWidthTextField.stringValue = [NSString stringWithFormat:@"%0.1f", selectedShape.strokeWidth];

        self.xTextField.stringValue = [NSString stringWithFormat:@"%0.1f", selectedShape.frame.origin.x];
        self.yTextField.stringValue = [NSString stringWithFormat:@"%0.1f", selectedShape.frame.origin.y];
        self.widthTextField.stringValue = [NSString stringWithFormat:@"%0.1f", selectedShape.frame.size.width];
        self.heightTextField.stringValue = [NSString stringWithFormat:@"%0.1f", selectedShape.frame.size.height];
    }
}

- (void)enableShapeAttributes
{
    self.fillCheckbox.enabled = YES;
    self.fillColorWell.enabled = YES;
    self.strokeCheckbox.enabled = YES;
    self.strokeColorWell.enabled = YES;
    self.lineWidthTextField.enabled = YES;
    self.lineWidthSlider.enabled = YES;
    self.lineWidthStepper.enabled = YES;
    self.xTextField.enabled = YES;
    self.yTextField.enabled = YES;
    self.widthTextField.enabled = YES;
    self.heightTextField.enabled = YES;
    self.xStepper.enabled = YES;
    self.yStepper.enabled = YES;
    self.widthStepper.enabled = YES;
    self.heightStepper.enabled = YES;
}

- (void)disableShapeAttributes
{
    self.fillCheckbox.enabled = NO;
    self.fillColorWell.enabled = NO;
    self.strokeCheckbox.enabled = NO;
    self.strokeColorWell.enabled = NO;
    self.lineWidthTextField.enabled = NO;
    self.lineWidthSlider.enabled = NO;
    self.lineWidthStepper.enabled = NO;
    self.xTextField.enabled = NO;
    self.yTextField.enabled = NO;
    self.widthTextField.enabled = NO;
    self.heightTextField.enabled = NO;
    self.xStepper.enabled = NO;
    self.yStepper.enabled = NO;
    self.widthStepper.enabled = NO;
    self.heightStepper.enabled = NO;

    self.fillCheckbox.state = NSOffState;
    self.fillColorWell.color = [NSColor blackColor];
    self.strokeCheckbox.state = NSOffState;
    self.strokeColorWell.color = [NSColor blackColor];
    self.lineWidthTextField.stringValue = @"";
    self.lineWidthSlider.doubleValue = 0.;
    self.xTextField.stringValue = @"";
    self.yTextField.stringValue = @"";
    self.widthTextField.stringValue = @"";
    self.heightTextField.stringValue = @"";
}

#pragma mark - Attribute Adjustment Actions

- (void)shapeSelected:(NSNotification *)notification
{
    if (!selectedShape) {
        [self enableShapeAttributes];
    }
    selectedShape = notification.userInfo[SELECTED_SHAPE];
    [self readShapeAttributes];
}

- (void)shapeDeselected:(NSNotification *)notification
{
    if (selectedShape) {
        [self disableShapeAttributes];
        selectedShape = nil;
    }
}

- (void)shapeChanged:(NSNotification *)notification
{
    [self readShapeAttributes];
}

- (IBAction)lineWidthSliderChanged:(id)sender
{
    selectedShape.strokeWidth = self.lineWidthSlider.doubleValue;
    self.lineWidthTextField.stringValue = [NSString stringWithFormat:@"%0.1f", selectedShape.strokeWidth];
}

- (IBAction)lineWidthTextReceived:(id)sender
{
    selectedShape.strokeWidth = self.lineWidthTextField.floatValue;
    self.lineWidthSlider.doubleValue = selectedShape.strokeWidth;
}

- (IBAction)strokeColorChanged:(NSColorWell *)sender
{
    selectedShape.strokeColor = sender.color;
}

- (IBAction)fillColorChanged:(NSColorWell *)sender
{
    selectedShape.fillColor = sender.color;
}

- (IBAction)textInputReceived:(id)sender
{
    CGRect frame = CGRectMake(self.xTextField.floatValue, self.yTextField.floatValue, self.widthTextField.floatValue, self.heightTextField.floatValue);
    selectedShape.frame = frame;
}

@end
