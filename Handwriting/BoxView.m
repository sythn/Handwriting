//
//  BoxView.m
//  Handwriting
//
//  Created by Seyithan Teymur on 5/15/11.
//  Copyright 2011 JoopleBerry Inc. All rights reserved.
//

#import "BoxView.h"


@implementation BoxView

@synthesize character		= _character;
@synthesize description		= _description;

@synthesize new				= _new;
@synthesize selected		= _selected;
@synthesize allowsSelecting	= _allowsSelecting;
@synthesize editing			= _editing;

@synthesize delegate	= _delegate;

- (id)initWithFrame:(CGRect)frame {
	
    self = [super initWithFrame:frame];
	
    if (self) {
		
		_backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
		[_backgroundView setImage:[UIImage imageNamed:@"box.png"]];
		[_backgroundView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
		[self addSubview:_backgroundView];
		
		_characterLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.bounds.size.width - 20, self.bounds.size.height - 30)];
		[_characterLabel setTextColor:[UIColor whiteColor]];
		[_characterLabel setBackgroundColor:[UIColor clearColor]];
		[_characterLabel setFont:[UIFont boldSystemFontOfSize:70]];
		[_characterLabel setTextAlignment:UITextAlignmentCenter];
		[_characterLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
		[self addSubview:_characterLabel];
		
		_descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.bounds.size.height - 25, self.bounds.size.width - 20, 20)];
		[_descriptionLabel setTextColor:[UIColor whiteColor]];
		[_descriptionLabel setBackgroundColor:[UIColor clearColor]];
		[_descriptionLabel setFont:[UIFont boldSystemFontOfSize:10]];
		[_descriptionLabel setTextAlignment:UITextAlignmentCenter];
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
	
}

- (void)setSelected:(BOOL)selected {
	
	_selected = selected;
	
	[_backgroundView setImage:self.selected ? [UIImage imageNamed:@"box-selected.png"] : [UIImage imageNamed:@"box.png"]];
	
}

#pragma mark -

- (void)dealloc {
	
    [super dealloc];
	
}

#pragma mark -

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	[self setSelected:!self.selected];
	
	if ([self.delegate respondsToSelector:@selector(boxView:selected:)]) {
		[self.delegate boxView:self selected:self.selected];
	}
	
}

@end
