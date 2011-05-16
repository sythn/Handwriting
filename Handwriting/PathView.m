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
	
	self.layer.opaque = YES;
	self.layer.delegate = self;
	self.layer.bounds = self.bounds;

	[self.layer setNeedsDisplay];
	
}

-(BOOL)isVisibleInRect:(CGRect)r {
	
	return CGRectIntersectsRect(r, self.layer.frame);
	
}

- (void)addX:(double)x y:(double)y {
	
	path[currentIndex] = CGPointMake(x, y);
	currentIndex++;
	
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
