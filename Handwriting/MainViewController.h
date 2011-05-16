//
//  MainViewController.h
//  Handwriting
//
//  Created by Seyithan Teymur on 5/12/11.
//  Copyright 2011 JoopleBerry Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoxView.h"

@class PathView;
@class Line;

typedef enum {
	
	InputModeTrain = 0,
	InputModeRecognize,
	InputModeDebug
	
} InputMode;

@interface MainViewController : UIViewController <BoxViewDelegate> {
	
	PathView			*_pathView;
	UITextView			*_textView;
	
	UIButton			*_settingsButton;
	UIView				*_settingsView;
	UIScrollView		*_resultsView;
	
	UIView				*_maskView;
	
	UIView				*_containerView;
	
	UISegmentedControl	*_inputModeSegment;
	
	Line				*_currentLine;
	NSString			*_currentChar;
	NSMutableString		*_text;
	
	BOOL				 _showingSettings;
	InputMode			 _inputMode;
	
	NSArray				*_currentOutput;
	
	NSString			*_chars;
    
}

@property (nonatomic, retain) IBOutlet PathView				*pathView;
@property (nonatomic, retain) IBOutlet UITextView			*textView;

@property (nonatomic, retain) IBOutlet UIButton				*settingsButton;
@property (nonatomic, retain) IBOutlet UIView				*settingsView;
@property (nonatomic, retain) IBOutlet UIScrollView			*resultsView;

@property (nonatomic, retain) IBOutlet UIView				*maskView;

@property (nonatomic, retain) IBOutlet UIView				*containerView;

@property (nonatomic, retain) IBOutlet UISegmentedControl	*inputModeSegment;

- (IBAction)settingsButtonClicked:(id)sender;
- (IBAction)segmentValueChanged:(id)sender;


@end
