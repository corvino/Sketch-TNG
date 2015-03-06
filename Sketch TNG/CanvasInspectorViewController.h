//
//  CanvasInspectorViewController.h
//  Sketch TNG
//
//  Created by Nathan Corvino on 3/5/15.
//  Copyright (c) 2015 Nathan Corvino. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CanvasInspectorViewController : NSViewController

@property (weak) IBOutlet NSColorWell *fillColorWell;
@property (weak) IBOutlet NSColorWell *strokeColorWell;
@property (weak) IBOutlet NSTextField *lineWidthTextField;
@property (weak) IBOutlet NSSlider *lineWidthSlider;

@property (weak) IBOutlet NSTextField *xTextField;
@property (weak) IBOutlet NSTextField *yTextField;
@property (weak) IBOutlet NSTextField *widthTextField;
@property (weak) IBOutlet NSTextField *heightTextField;

@end
