//
//  TemplateManager.h
//  Handwriting
//
//  Created by Seyithan Teymur on 5/16/11.
//  Copyright 2011 JoopleBerry Inc. All rights reserved.
//


#import <Foundation/Foundation.h>

@class Line;

@interface TemplateManager : NSObject {
	
	/*
	 * Array of template-char pairs.
	 * Array structure:
	 *
	 *	- Array
	 *		- (NSDictionary *) Pair
	 *			- (NSString *) Character
	 *			- (Line *) Template
	 *		- (NSDictionary *) Pair
	 *			- (NSString *) Character
	 *			- (Line *) Template
	 */
	NSMutableArray	*_templates;
    
}

+ (TemplateManager *)sharedManager;

/*
 * Existing templates.
 * Returns an array of characters of NSString * type.
 */
- (NSArray *)templates;

/*
 * Currently there's support for only one template for each char.
 */
- (void)addTemplate:(Line *)template forCharacter:(NSString *)character;

/*
 * Method that returns whether templates exist for a char.
 */
- (BOOL)templateExistsForCharacter:(NSString *)character;

/*
 * Method to recognize the char from a given Line. 
 * For detailed debug results with char-rating pairs use recognizedDebugResultsForInput:
 */
- (NSString *)recognizedCharacterForInput:(Line *)input;

/*
 * Debug results for a given Line input.
 * Array structure:
 * 
 *	- Array
 *		- (NSDictionary *) Result
 *			- (NSNumber *) Error (number with double)
 *			- (NSString *) Character
 *		- (NSDictionary *) Result
 *			- (NSNumber *) Error (number with double)
 *			- (NSString *) Character
 *
 * The smaller the error, the more accurate the comparison.
 */
- (NSArray *)recognizedDebugResultsForInput:(Line *)input;

@end
