//
//  BoxView.h
//  Handwriting
//
//  Created by Seyithan Teymur on 5/15/11.
//  Copyright 2011 JoopleBerry Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BoxView : UIView {
	
	NSString	*_character;
	NSString	*_description;

	BOOL		 _editing;
	BOOL		 _selected;
	BOOL		 _new;
	
	UIImageView	*_backgroundView;
    UIButton	*_deleteButton;
	
	UILabel		*_characterLabel;
	UILabel		*_descriptionLabel;
	
}

@property (nonatomic, retain) NSString			*character;
@property (nonatomic, retain) NSString			*description;

@property (nonatomic, getter = isEditing) BOOL	 editing;
@property (nonatomic, getter = isSelected) BOOL	 selected;
@property (nonatomic, getter = isNew) BOOL		 new;

@end
