//
//  MainViewController.m
//  Handwriting
//
//  Created by Seyithan Teymur on 5/12/11.
//  Copyright 2011 JoopleBerry Inc. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController (Internal)

- (void)addPointFromTouch:(UITouch *)touch;

@end


@implementation MainViewController

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

	pathView = [[PathView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
	[pathView setFrame:CGRectMake(0, 0, 320, 460)];
	[self.view addSubview:pathView];
	
}

- (void)viewDidUnload {
	
    [super viewDidUnload];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
	
}

#pragma mark -

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	[pathView reset];
	[self addPointFromTouch:[touches anyObject]];
	
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	
	[self addPointFromTouch:[touches anyObject]];
	
}

- (void)addPointFromTouch:(UITouch *)touch {
	
	CGPoint pointInPathView = [touch locationInView:pathView];
	
	[pathView addX:pointInPathView.x y:pointInPathView.y];
	
}

@end
