//
//  Shape.h
//  Sketch TNG
//
//  Created by Nathan Corvino on 3/6/15.
//  Copyright (c) 2015 Nathan Corvino. All rights reserved.
//

@import Foundation;
@import QuartzCore;

#import "Graphic.h"

@interface Shape : Graphic

@property (nonatomic, readonly) CAShapeLayer *shapeLayer;

@end
