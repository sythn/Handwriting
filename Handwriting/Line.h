//
//  Line.h
//  Handwriting
//
//  Created by Seyithan Teymur on 5/12/11.
//  Copyright 2011 JoopleBerry Inc. All rights reserved.
//

#define KEYPOINT_SIZE 100

#import <Foundation/Foundation.h>

@class LineSegment;

@interface Line : NSObject {
	
	NSMutableArray	*_segments;
	
	CGSize			 _shiftSize;
	CGFloat			 _scaleSize;
	
	CGFloat			 _length;
	CGPoint			 _centerOfMass;
	
	CGPoint			 _keypoints[KEYPOINT_SIZE];
    
}

@property (readonly) NSMutableArray	*segments;

@property (readonly) CGSize			 shiftSize;
@property (readonly) CGFloat		 scaleSize;

@property (readonly) double			 length;
@property (readonly) CGPoint		 centerOfMass;

- (void)addX:(CGFloat)x y:(CGFloat)y;
- (void)addSegment:(LineSegment *)segment;

- (double)compareToLine:(Line *)line;

- (void)scaleWithFactor:(double)scaleFactor;
- (void)shiftWithSize:(CGSize)shiftSize;

- (void)transformToIdentity;

- (void)createKeypointsWithCount:(int)keypointCount;
- (CGPoint)keypointAtIndex:(int)index;

@end