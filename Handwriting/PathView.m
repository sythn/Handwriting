//
//  PathView.m
//  iWand
//
//  Created by Seyithan Teymur on 5/9/11.
//  Copyright 2011 JoopleBerry Inc. All rights reserved.
//

#define LOGGING 0

#define PATH_LENGTH 10000

#import "PathView.h"
#import <QuartzCore/QuartzCore.h>

CGColorRef gridBackgroundColor() {
	
	static CGColorRef c = NULL;

	if(c == NULL) {
		c = [[UIColor colorWithRed:(float)55/256 green:(float)134/256 blue:(float)183/256 alpha:1] CGColor];
		CFRetain(c);
	}
	
	return c;
	
}

CGColorRef gridForegroundColor() {
	
	static CGColorRef c = NULL;
	
	if(c == NULL) {
		c = [[UIColor colorWithRed:(float)75/256 green:(float)150/256 blue:(float)200/256 alpha:1] CGColor];
		CFRetain(c);
	}
	
	return c;
	
}

CGColorRef pathColor() {
	
	static CGColorRef c = NULL;
	
	if(c == NULL) {
		c = [[UIColor colorWithRed:1 green:1 blue:1 alpha:1] CGColor];
		CFRetain(c);
	}
	
	return c;
	
}

void DrawGridlines(CGContextRef context, CGFloat width, CGFloat height) {
	
	for(CGFloat y = 0; y <= 460; y += 20) {
		CGContextMoveToPoint(context, 0, y);
		CGContextAddLineToPoint(context, width, y);
	}
	
	for(CGFloat x = 0; x <= 460; x += 20) {
		CGContextMoveToPoint(context, x, 0);
		CGContextAddLineToPoint(context, x, height);
	}
	
	CGContextSetStrokeColorWithColor(context, gridForegroundColor());
	CGContextStrokePath(context);
	
}

@implementation PathView

- (id)initWithFrame:(CGRect)frame {
	
    self = [super initWithFrame:frame];
    if (self) {
		
		for (int i=0; i<PATH_LENGTH; i++) {
			
			path[i] = CGPointMake(100, 100);
			
		}
		
		[self reset];
		
		self.layer.opaque = YES;
		self.layer.delegate = self;
		self.layer.bounds = CGRectMake(0, 0, frame.size.width, frame.size.height);
		
    }
	
    return self;
	
}

- (void)dealloc {
	
    [super dealloc];
	
}

-(void)reset {
	
	memset(path, 0, sizeof(path));
	currentIndex = 0;

	[self.layer setNeedsDisplay];
	
}

-(BOOL)isVisibleInRect:(CGRect)r {
	
	return CGRectIntersectsRect(r, self.layer.frame);
	
}

- (void)addX:(double)x y:(double)y {
	
	if (LOGGING) {
		
		NSLog(@"adding with currentIndex: %i", currentIndex);
		
	}
	
	CGPoint point = CGPointMake(x, y);
	
	if (currentIndex < 1) {
		
		if (LOGGING) {
			
			NSLog(@"setting %i to %@", currentIndex, NSStringFromCGPoint(point));			
			
		}
		
		path[currentIndex] = point;
		currentIndex++;
		
	}
	
	else {
		
		CGPoint previousPoint = path[currentIndex - 1];
		
		double width = fabs(round(previousPoint.x - point.x));
		double height = fabs(round(previousPoint.y - point.y));
		
		double largeSide = MAX(width, height);
		
		double xStep = width / largeSide;
		double yStep = height / largeSide;
		
		BOOL toRight = point.x > previousPoint.x;
		BOOL toBottom	 = point.y > previousPoint.y;
		
		if (LOGGING) {
			
			NSLog(@"%@, %@", NSStringFromCGPoint(point), NSStringFromCGPoint(previousPoint));
			
			NSLog(@"width: %f, height: %f; larger: %f", width, height, largeSide);
			
			NSLog(@"right: %i, bottom: %i; (xStep: %f, yStep: %f)", toRight, toBottom, xStep, yStep);
			NSLog(@"currentIndexOutside: %i", currentIndex);
			
		}

		currentIndex--;
		
		int index = currentIndex;
		
		for (double i=0; i<largeSide; i++) {
			
			currentIndex++;
			
			CGPoint interPoint = CGPointMake(toRight ? previousPoint.x + i*xStep : previousPoint.x - i*xStep, toBottom ? previousPoint.y + i*yStep : previousPoint.y - i*yStep);
			
			if (LOGGING) {
				
				NSLog(@"currentIndexInside: %i, %@", currentIndex, NSStringFromCGPoint(interPoint));
				
			}
			
			path[currentIndex] = interPoint;
			
		}
		
		for (int i = index; i < currentIndex; i++) {
			
			
			
		}
		
	}
	
	[self.layer setNeedsDisplay];
	
}

-(void)drawLayer:(CALayer*)l inContext:(CGContextRef)context {

	CGContextSetFillColorWithColor(context, gridBackgroundColor());
	CGContextFillRect(context, self.layer.bounds);
	
	DrawGridlines(context, 320.0, 460.0);
	
	CGContextSetLineWidth(context, 3);
	
	if (LOGGING) {
		
		for (int i=0; i<currentIndex; i++) {
			
			NSLog(@"draw %i, %@", i, NSStringFromCGPoint(path[i]));
			
		}		
		
	}
	
	{
		
		CGPoint linesToDraw[currentIndex * 2];
		
		for (int i=0; i<currentIndex - 1; i++) {
			
			linesToDraw[i*2] = path[i];
			linesToDraw[i*2+1] = path[i+1];
			
		}
		
		CGContextSetStrokeColorWithColor(context, pathColor());
		CGContextStrokeLineSegments(context, linesToDraw, currentIndex * 2);
		
	}
	
}

-(id)actionForLayer:(CALayer *)layer forKey :(NSString *)key {
	
	return [NSNull null];
	
}

-(void)drawRect:(CGRect)rect {
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, gridBackgroundColor());
	CGContextFillRect(context, self.bounds);
	
	CGFloat width = self.bounds.size.width;
	CGContextTranslateCTM(context, 0.0, 56.0);
	
	DrawGridlines(context, 0.0, width);
	
}


@end
