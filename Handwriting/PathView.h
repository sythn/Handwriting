//
//  PathView.h
//  iWand
//
//  Created by Seyithan Teymur on 5/9/11.
//  Copyright 2011 JoopleBerry Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface PathView : UIView {
	
	CGPoint	path[10000];
	
	int		currentIndex;
    
}

- (void)reset;
- (void)addX:(double)x y:(double)y;

@end
