//
//  LineSegment.h
//  Handwriting
//
//  Created by Seyithan Teymur on 5/12/11.
//  Copyright 2011 JoopleBerry Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DEFAULT_SMOOTHING_FACTOR .5f

@interface LineSegment : NSObject <NSCoding> {
	
	CGPoint	 _startPoint;
	CGPoint	 _endPoint;
	
}

/*
 * Start and end points of the segment.
 */
@property (nonatomic) CGPoint	 startPoint;
@property (nonatomic) CGPoint	 endPoint;

@property (readonly) double		 length;
@property (readonly) CGPoint	 center;

- (id)initWithStartPoint:(CGPoint)start endPoint:(CGPoint)end;

/*
 * Factory method for a segment with start and end point.
 */
+ (LineSegment *)lineSegmentWithStartPoint:(CGPoint)start endPoint:(CGPoint)end;

/*
 * Scaling and shifting methods.
 * Note that segments doesn't keep the scale and shift information.
 * The wrapping Line instance is responsible of it's segments to transform back to the initial state.
 */
- (void)scaleWithFactor:(double)scaleFactor;
- (void)shiftWithSize:(CGSize)shiftSize;

- (CGPoint)pointThroughLength:(double)length;

@end
