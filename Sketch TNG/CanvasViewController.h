//
//  CanvasViewController.h
//  Sketch TNG
//
//  Created by Nathan Corvino on 3/2/15.
//  Copyright (c) 2015 Nathan Corvino. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CanvasViewController : NSViewController

@property (weak) IBOutlet NSView *canvasView;

- (IBAction)addShape:(id)sender;
- (IBAction)dragWithGestureRecognizer:(NSPanGestureRecognizer *)panner;
- (IBAction)magnifyWithGestureRecognizer:(NSMagnificationGestureRecognizer *)magnifier;

@end
