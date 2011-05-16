//
//  Line.h
//  Handwriting
//
//  Created by Seyithan Teymur on 5/12/11.
//  Copyright 2011 JoopleBerry Inc. All rights reserved.
//

#define KEYPOINT_SIZE 500

#import <Foundation/Foundation.h>

@class LineSegment;

@interface Line : NSObject <NSCoding> {
	
	
	NSMutableArray	*_segments;
	
	/* 
	 * Current shif and scale size of the line. 
	 * Used to determine what scaling and shifting to apply when transforming back to the initial state.
	 */
	CGSize			 _shiftSize;
	CGFloat			 _scaleSize;
	
	CGPoint			 _keypoints[KEYPOINT_SIZE];
    
}

/*
 * Segments of Line as an array. Should never be set directly.
 */
@property (nonatomic, readonly) NSMutableArray	*segments;

@property (nonatomic, readonly) double			 length;
@property (nonatomic, readonly) CGPoint			 centerOfMass;

/*
 * Additions to Line.
 * If added as coordinates, Line instance creates a new segment with start point as the last added segment's end point
 * and end point as a point created from given parameters.
 */
- (void)addX:(CGFloat)x y:(CGFloat)y;
- (void)addSegment:(LineSegment *)segment;

/*
 * Main comparison method.
 * The line parameter is never modified. The instance whose method is invoked scales and shifts itself 
 * to match the Line parameter. 
 * It then creates keypoints with a predefined count and compares the points.
 */
- (double)compareToLine:(Line *)line;

/*
 * Shifting and scaling methods. Used before comparing to match the size and center of mass of Lines compared.
 */
- (void)scaleWithFactor:(double)scaleFactor;
- (void)shiftWithSize:(CGSize)shiftSize;

- (void)transformToIdentity;

/*
 * Methods used for creating and accessing keypoints.
 * Keypoint count is predefined although the create method takes a parameter.
 */
- (void)createKeypointsWithCount:(int)keypointCount;
- (CGPoint)keypointAtIndex:(int)index;

@end