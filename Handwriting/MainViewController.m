//
//  MainViewController.m
//  Handwriting
//
//  Created by Seyithan Teymur on 5/12/11.
//  Copyright 2011 JoopleBerry Inc. All rights reserved.
//

#import "MainViewController.h"

#import "PathView.h"
#import "Line.h"
#import "TemplateManager.h"
#import "BoxView.h"

@interface MainViewController (Internal)

- (void)addPointFromTouch:(UITouch *)touch;
- (void)reloadBoxViews;

@end


@implementation MainViewController

@synthesize pathView			= _pathView;
@synthesize textView			= _textView;

@synthesize settingsButton		= _settingsButton;
@synthesize settingsView		= _settingsView;
@synthesize resultsView			= _resultsView;

@synthesize maskView			= _maskView;

@synthesize containerView		= _containerView;

@synthesize inputModeSegment	= _inputModeSegment;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
	if (self) {

		
		
    }
	
    return self;
	
}

- (void)dealloc {
	
    [super dealloc];
	
}

- (void)didReceiveMemoryWarning {
	
    [super didReceiveMemoryWarning];
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	_text = [[NSMutableString alloc] init];

	_inputMode = InputModeRecognize;
	
	_chars = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ";
	
	for (int i=0; i<[_chars length]; i++) {

		BoxView *box = [[BoxView alloc] initWithFrame:CGRectMake(i*80, 0, 80, 100)];
		[box setCharacter:[_chars substringWithRange:NSMakeRange(i, 1)]];
		[box setDescription:[[TemplateManager sharedManager] templateExistsForCharacter:box.character] ? @"Trained" : @"Not trained"];
		[box setDelegate:self];
		[_resultsView addSubview:box];
		
		if (i == 0) {
			[box setSelected:YES];
			[self boxView:box selected:YES];
		}
		
		[box release];
		
	}
	
	[_resultsView setContentSize:CGSizeMake(([_chars length] / 4 + 1) * _resultsView.bounds.size.width, 100)];
	
}

- (void)viewDidUnload {
	
    [super viewDidUnload];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
	
}

#pragma mark -

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	if ([[touches anyObject] view] == _maskView && _showingSettings) {
		[self settingsButtonClicked:nil];
		return;
	}
	
	if ([[touches anyObject] view] != self.pathView) {
		return;
	}
	
	[_pathView reset];
	
	_currentLine = [[Line alloc] init];
	
	[self addPointFromTouch:[touches anyObject]];
	
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	
	if (!_currentLine) {
		return;
	}
	
	[self addPointFromTouch:[touches anyObject]];
	
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
	if (!_currentLine || [[touches anyObject] view] != self.pathView || [_currentLine.segments count] <= 1) {
		return;
	}
	
	if (_inputMode == InputModeTrain) {
		
		[[TemplateManager sharedManager] addTemplate:_currentLine forCharacter:_currentChar];
		return;
		
	}
	
	else if (_inputMode == InputModeRecognize) {
		
		NSString *recognizedChar = [[TemplateManager sharedManager] recognizedCharacterForInput:_currentLine];
		if (recognizedChar)
			[_text appendString:recognizedChar];
		
	}
	
	else {
		
		_currentOutput = [[TemplateManager sharedManager] recognizedDebugResultsForInput:_currentLine];
		[self reloadBoxViews];
		
	}
	
	[_textView setText:_text];
	
	[_currentLine release];
	_currentLine = nil;
	
}

- (void)addPointFromTouch:(UITouch *)touch {
	
	CGPoint pointInPathView = [touch locationInView:_pathView];
	
	[_pathView addX:pointInPathView.x y:pointInPathView.y];
	[_currentLine addX:pointInPathView.x y:pointInPathView.y];
	
}

#pragma mark -

- (void)settingsButtonClicked:(id)sender {
	
	_showingSettings = !_showingSettings;
	
	CGFloat frameY = 0;
	
	if (_showingSettings) {
		frameY = -160;
	}
	
	else {
		frameY = _inputMode == InputModeRecognize ? 0 : -110;
	}
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.32];
		
	[self.containerView setFrame:CGRectMake(0, frameY, 320, 460)];
	[self.maskView setAlpha:_showingSettings ? .76 : 0];
	[self.maskView setUserInteractionEnabled:_showingSettings];
	
	[UIView commitAnimations];
		
	
}

- (void)segmentValueChanged:(id)sender {
	
	UISegmentedControl *segment = (UISegmentedControl *)sender;
	_inputMode = [segment selectedSegmentIndex];
	
	[self.textView setHidden:!(_inputMode == InputModeRecognize)];
	
	[self reloadBoxViews];
	[self.resultsView setContentOffset:CGPointMake(0, 0)];
	
}

#pragma mark - Box view delegate methods

- (void)boxView:(BoxView *)boxView selected:(BOOL)selected {
	
	if (_inputMode != InputModeTrain) {
		return;
	}
	
	for (int i=0; i<[self.resultsView.subviews count]; i++) {
		
		UIView *subview = [self.resultsView.subviews objectAtIndex:i];
		
		if (![subview isKindOfClass:[BoxView class]]) {
			continue;
		}
		
		BoxView *otherBoxView = (BoxView *)subview;
		
		if ([otherBoxView isEqual:boxView]) {
			continue;
		}
		
		[otherBoxView setSelected:NO];
		
	}
	
	[_currentChar release];
	_currentChar = [[boxView character] retain];
	
	[self reloadBoxViews];
	
}

- (void)reloadBoxViews {
	
	if (_inputMode == InputModeDebug) {
		
		for (int i=0; i<[_resultsView.subviews count]; i++) {
			
			BoxView *box = [_resultsView.subviews objectAtIndex:i];
			
			if (i >= [_currentOutput count]) {
				[box setHidden:YES];
				return;
			}
			
			[box setHidden:NO];
			
			NSDictionary *dict = [_currentOutput objectAtIndex:i];

			[box setCharacter:[dict objectForKey:@"Character"]];
			[box setDescription:[NSString stringWithFormat:@"error: %.2f", [[dict objectForKey:@"Error"] doubleValue]]];
			
		}
		
	}
	
	else {
		
		for (int i=0; i<[_resultsView.subviews count]; i++) {
			
			BoxView *box = [_resultsView.subviews objectAtIndex:i];
			[box setCharacter:[_chars substringWithRange:NSMakeRange(i, 1)]];
			
			[box setHidden:NO];
			
			if ([box isSelected])
				[box setDescription:@"Training"];
				
			else 
				[box setDescription:[[TemplateManager sharedManager] templateExistsForCharacter:box.character] ? @"Trained" : @"Not trained"];
				
		}
		
	}
	
}

@end
