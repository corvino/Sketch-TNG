//
//  ShapePickerController.m
//  Sketch TNG
//
//  Created by Nathan Corvino on 3/6/15.
//  Copyright (c) 2015 Nathan Corvino. All rights reserved.
//

#import "ShapePickerController.h"

#import "Ellipse.h"
#import "Rectangle.h"
#import "Triangle.h"

@implementation ShapePickerController

- (IBAction)rectangleSelected:(id)sender
{
    [self.shapeContainer addShape:[[Rectangle alloc] init]];
}

- (IBAction)ellipseSelected:(id)sender
{
    [self.shapeContainer addShape:[[Ellipse alloc] init]];
}

- (IBAction)triangleSelected:(id)sender
{
    [self.shapeContainer addShape:[[Triangle alloc] init]];
}

@end
