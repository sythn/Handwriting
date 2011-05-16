//
//  LineSegment.h
//  Handwriting
//
//  Created by Seyithan Teymur on 5/12/11.
//  Copyright 2011 JoopleBerry Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DEFAULT_SMOOTHING_FACTOR .5f

@interface LineSegment : NSObject {
	
	CGPoint	 _startPoint;
	CGPoint	 _endPoint;
    
	CGFloat	 _length;
	CGPoint	 _center;
	
}

@property (nonatomic) CGPoint	 startPoint;
@property (nonatomic) CGPoint	 endPoint;

@property (readonly) double		 length;
@property (readonly) CGPoint	 center;

- (id)initWithStartPoint:(CGPoint)start endPoint:(CGPoint)end;

+ (LineSegment *)lineSegmentWithStartPoint:(CGPoint)start endPoint:(CGPoint)end;

- (void)scaleWithFactor:(double)scaleFactor;
- (void)shiftWithSize:(CGSize)shiftSize;

- (CGPoint)pointThroughLength:(double)length;

@end
