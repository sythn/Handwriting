//
//  LineSegment.m
//  Handwriting
//
//  Created by Seyithan Teymur on 5/12/11.
//  Copyright 2011 JoopleBerry Inc. All rights reserved.
//

#import "LineSegment.h"


@implementation LineSegment

@synthesize startPoint		= _startPoint;
@synthesize endPoint		= _endPoint;

- (id)initWithStartPoint:(CGPoint)start endPoint:(CGPoint)end {
	
	if ((self = [self init])) {
		
		_length = 0;
		
		self.startPoint = start;
		self.endPoint	= end;
		
	}
	
	return self;
	
}

+ (LineSegment *)lineSegmentWithStartPoint:(CGPoint)start endPoint:(CGPoint)end {
	
	LineSegment *segment = [[LineSegment alloc] initWithStartPoint:start endPoint:end];
	
	return [segment autorelease];
	
}

- (double)length {
	
	double length = sqrt(pow(_startPoint.x - _endPoint.x, 2) + pow(_startPoint.y - _endPoint.y, 2));	
	return length;
	
}

- (CGPoint)center {
	
	_center = CGPointMake((_startPoint.x + _endPoint.x)/2, (_startPoint.y + _endPoint.y)/2);
	return _center;
	
}

- (void)scaleWithFactor:(double)scaleFactor {
	
	self.startPoint = CGPointMake(self.startPoint.x * scaleFactor, self.startPoint.y * scaleFactor);
	self.endPoint = CGPointMake(self.endPoint.x * scaleFactor, self.endPoint.y * scaleFactor);
	
}

- (void)shiftWithSize:(CGSize)shiftSize {
	
	self.startPoint = CGPointMake(self.startPoint.x + shiftSize.width, self.startPoint.y + shiftSize.height);
	self.endPoint = CGPointMake(self.endPoint.x + shiftSize.width, self.endPoint.y + shiftSize.height);
	
}

- (CGPoint)pointThroughLength:(double)length {
	
	double ratio = self.length / length;
	
	return CGPointMake(_startPoint.x + (_endPoint.x - _startPoint.x) / ratio, _startPoint.y + (_endPoint.y - _startPoint.y) / ratio);
	
}

@end
