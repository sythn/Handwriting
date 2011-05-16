//
//  BoxView.m
//  Handwriting
//
//  Created by Seyithan Teymur on 5/15/11.
//  Copyright 2011 JoopleBerry Inc. All rights reserved.
//

#import "BoxView.h"


@implementation BoxView

@synthesize character	= _character;
@synthesize description	= _description;

@synthesize new			= _new;
@synthesize selected	= _selected;
@synthesize editing		= _editing;

- (id)initWithFrame:(CGRect)frame {
	
    self = [super initWithFrame:frame];
	
    if (self) {
		
		_backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
		[_backgroundView setImage:[UIImage imageNamed:@"box.png"]];
		[_backgroundView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
		[self addSubview:_backgroundView];
		
		_characterLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.bounds.size.width - 20, self.bounds.size.height - 50)];
		[_characterLabel setTextColor:[UIColor whiteColor]];
		[_characterLabel setBackgroundColor:[UIColor clearColor]];
		[_characterLabel setFont:[UIFont boldSystemFontOfSize:72]];
		[_characterLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
		[self addSubview:_characterLabel];
		
		_descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.bounds.size.height - 40, self.bounds.size.width - 10, 30)];
		[_descriptionLabel setTextColor:[UIColor whiteColor]];
		[_descriptionLabel setBackgroundColor:[UIColor clearColor]];
		[_descriptionLabel setFont:[UIFont boldSystemFontOfSize:10]];
		[_descriptionLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
		[self addSubview:_descriptionLabel];
		
    }
	
    return self;
	
}

#pragma mark -

- (void)setCharacter:(NSString *)character {
	
	[_character release];
	_character = [character retain];
	
	[_characterLabel setText:character];
	
}

- (void)setDescription:(NSString *)description {
	
	[_description release];
	_description = [description retain];
	
	[_descriptionLabel setText:description];
	
}

- (void)setEditing:(BOOL)editing {
	
	_editing = editing;
	
	[_backgroundView setImage:self.selected ? [UIImage imageNamed:@"box.png"] : [UIImage imageNamed:@"box-selected.png"]];
	
}

- (void)setSelected:(BOOL)selected {
	
	_selected = selected;
	
}

#pragma mark -

- (void)dealloc {
	
    [super dealloc];
	
}

@end
