//
//  CanvasViewController.h
//  Sketch TNG
//
//  Created by Nathan Corvino on 3/2/15.
//  Copyright (c) 2015 Nathan Corvino. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define SHAPE_BECAME_SELECTED @"SHAPE_BECAME_SELECTED"
#define SHAPE_BECAME_DESELECTED @"SHAPE_BECAME_DESELECTED"
#define SHAPE_ATTRIBUTES_CHANGED @"SHAPE_ATTRIBUTES_CHANGED"

#define SELECTED_SHAPE @"SELECTED_SHAPE"

@interface CanvasViewController : NSViewController

@property (weak) IBOutlet NSView *canvasView;

- (IBAction)addShape:(id)sender;
- (IBAction)dragWithGestureRecognizer:(NSPanGestureRecognizer *)panner;
- (IBAction)magnifyWithGestureRecognizer:(NSMagnificationGestureRecognizer *)magnifier;
- (IBAction)clickWithGestureRecognizer:(NSClickGestureRecognizer *)clicker;

@end
