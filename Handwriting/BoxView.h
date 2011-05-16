//
//  BoxView.h
//  Handwriting
//
//  Created by Seyithan Teymur on 5/15/11.
//  Copyright 2011 JoopleBerry Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BoxViewDelegate;

@interface BoxView : UIView {
	
	NSString	*_character;
	NSString	*_description;

	BOOL		 _editing;
	BOOL		 _selected;
	BOOL		 _allowsSelecting;
	BOOL		 _new;
	
	UIImageView	*_backgroundView;
    UIButton	*_deleteButton;
	
	UILabel		*_characterLabel;
	UILabel		*_descriptionLabel;
	
	id <BoxViewDelegate>	 _delegate;
	
}

@property (nonatomic, retain) NSString			*character;
@property (nonatomic, retain) NSString			*description;

@property (nonatomic, getter = isEditing) BOOL	 editing;
@property (nonatomic, getter = isSelected) BOOL	 selected;
@property (nonatomic) BOOL						 allowsSelecting;
@property (nonatomic, getter = isNew) BOOL		 new;

@property (nonatomic, assign) id <BoxViewDelegate>	 delegate;

@end

@protocol BoxViewDelegate <NSObject>

@optional
	- (void)boxView:(BoxView *)boxView selected:(BOOL)selected;
	- (void)boxViewDeleteButtonClicked:(BoxView *)boxView;

@end
