//
//  ShapePickerController.h
//  Sketch TNG
//
//  Created by Nathan Corvino on 3/6/15.
//  Copyright (c) 2015 Nathan Corvino. All rights reserved.
//

@import Cocoa;

#import "Graphic.h"


@protocol ShapeContainer <NSObject>

- (void)addShape:(Graphic *)graphic;

@end


@interface ShapePickerController : NSViewController

@property (nonatomic, retain) NSObject<ShapeContainer> *shapeContainer;

- (IBAction)rectangleSelected:(id)sender;
- (IBAction)ellipseSelected:(id)sender;
- (IBAction)triangleSelected:(id)sender;

@end
