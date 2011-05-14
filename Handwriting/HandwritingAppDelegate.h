//
//  HandwritingAppDelegate.h
//  Handwriting
//
//  Created by Seyithan Teymur on 5/12/11.
//  Copyright 2011 JoopleBerry Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;

@interface HandwritingAppDelegate : NSObject <UIApplicationDelegate> {
	
	MainViewController *_controller;

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet MainViewController *controller;

@end
