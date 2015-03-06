//
//  Shape.h
//  Sketch TNG
//
//  Created by Nathan Corvino on 3/6/15.
//  Copyright (c) 2015 Nathan Corvino. All rights reserved.
//

@import Cocoa;

@interface Graphic : NSObject

@property (nonatomic) CGRect frame;
@property (nonatomic, retain) NSColor *fillColor;
@property (nonatomic, retain) NSColor *strokeColor;
@property (nonatomic) CGFloat strokeWidth;

@property (nonatomic, readonly) CALayer *layer;

- (BOOL)containsPointInBounds:(CGPoint)point;

@end
