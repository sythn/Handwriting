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
	
	NSMutableArray	*_templates;
    
}

+ (TemplateManager *)sharedManager;

/*
 * Currently there's support for only one template for each char.
 */
- (void)addTemplate:(Line *)template forCharacter:(NSString *)character;

/*
 * Existing templates
 * Returns an array of characters of NSString * type.
 */
- (NSArray *)templates;

/*
 * Use this method to get the recognized char. 
 * For detailed debug results with char-rating pairs use recognizedDebugResultsForInput:
 */
- (NSString *)recognizedCharacterForInput:(Line *)input;

/*
 * Debug results for a given line input
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
 * All ratings sum up to 1.
 * The smaller the error, the more accurate the comparison.
 */
- (NSArray *)recognizedDebugResultsForInput:(Line *)input;

@end
