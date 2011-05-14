//
//  Line.m
//  Handwriting
//
//  Created by Seyithan Teymur on 5/12/11.
//  Copyright 2011 JoopleBerry Inc. All rights reserved.
//



#import "Line.h"
#import "LineSegment.h"

@implementation Line

@synthesize segments	= _segments;

@synthesize shiftSize	= _shiftSize;
@synthesize scaleSize	= _scaleSize;

- (id)init {
	
	self = [super init];
	
	if (self) {
		
		_segments = [[NSMutableArray alloc] init];

		_shiftSize = CGSizeMake(0, 0);
		_scaleSize = 1;
		
	}
	
	return self;
	
}

#pragma mark - Synthesizing methods

- (CGFloat)length {
	
	_length = 0;
	
	for (int i=0; i<[_segments count]; i++) {
		
		_length += [[_segments objectAtIndex:i] length];
		
	}
	
	return _length;
	
}

- (CGPoint)centerOfMass {
	
	double centerX = 0;
	double centerY = 0;
	
	double totalLength = 0;
	
	for (int i=0; i<[_segments count]; i++) {
		
		LineSegment *segment = [_segments objectAtIndex:i];
		
		CGPoint center = [segment center];
		CGFloat length = [segment length];
		
		centerX += center.x * length;
		centerY += center.y * length;
		totalLength += length;
		
	}
	
	_centerOfMass = CGPointMake(centerX / totalLength, centerY / totalLength);
	return _centerOfMass;
	
}

#pragma mark -


- (void)addX:(CGFloat)x y:(CGFloat)y {
	
	CGPoint startPoint = CGPointMake(x, y);
	CGPoint endPoint = CGPointMake(x, y);

	if ([_segments count]) {
		
		LineSegment *segment = [_segments lastObject];
		startPoint = [segment endPoint];
		
	}
	
	[self addSegment:[LineSegment lineSegmentWithStartPoint:startPoint endPoint:endPoint]];
	
}

- (void)addSegment:(LineSegment *)segment {
	
	[_segments addObject:segment];
	
}

#pragma mark -

- (void)scaleWithFactor:(double)scaleFactor {
	
	_scaleSize += scaleFactor;
	
	for (int i=0; i<[self.segments count]; i++) {
		
		LineSegment *segment = [self.segments objectAtIndex:i];
		
		[segment scaleWithFactor:scaleFactor];
		
	}
	
}

- (void)shiftWithSize:(CGSize)shiftSize {
	
	_shiftSize = CGSizeMake(_shiftSize.width + shiftSize.width, _shiftSize.height + shiftSize.height);
	
	for (int i=0; i<[self.segments count]; i++) {
		
		LineSegment *segment = [self.segments objectAtIndex:i];
		
		[segment shiftWithSize:shiftSize];
		
	}
	
}

- (void)transformToIdentity {
	
	[self shiftWithSize:CGSizeMake(-_shiftSize.width, -_shiftSize.height)];
	[self scaleWithFactor:-_scaleSize];
	
}

#pragma mark -

- (void)createKeypointsWithCount:(int)keypointCount {
	
	double keypointInterval = self.length / keypointCount;

	double pointthrough = 0;
	double segmentIndex = 0;
	int i = 0;
	
	while (i < keypointCount) {
		
		LineSegment *segment = [_segments objectAtIndex:segmentIndex];
		
		if (pointthrough > [segment length]) {
			
			pointthrough -= [segment length];
			segmentIndex++;
			continue;
			
		}		
		
		CGPoint newPoint = [segment pointThroughLength:pointthrough];
		_keypoints[i] = newPoint;
		i++;
		
		pointthrough += keypointInterval;
		
	}
	
}

- (CGPoint)keypointAtIndex:(int)index {
	
	return _keypoints[index];
	
}

#pragma mark -

- (double)compareToLine:(Line *)line {
	
	double error = 0;
	
	double	scaleFactor = line.length / self.length;
	
	[self scaleWithFactor:scaleFactor];
	
	CGPoint centerOfMass = self.centerOfMass;
	CGPoint otherCenterOfMass = line.centerOfMass;
	
	[self shiftWithSize:CGSizeMake(otherCenterOfMass.x - centerOfMass.x, otherCenterOfMass.y - centerOfMass.y)];
	
	[self createKeypointsWithCount:KEYPOINT_SIZE];
	[line createKeypointsWithCount:KEYPOINT_SIZE];
	
	for (int i=0; i<KEYPOINT_SIZE; i++) {
		
		CGPoint point = [self keypointAtIndex:i];
		CGPoint other = [line keypointAtIndex:i];
		
		error += (pow(point.x - other.x, 2) + pow(point.y - other.y, 2));
		
	}
	
	[self transformToIdentity];
	
	return error;	
	
}

@end
