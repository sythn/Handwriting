//
//  TemplateManager.m
//  Handwriting
//
//  Created by Seyithan Teymur on 5/16/11.
//  Copyright 2011 JoopleBerry Inc. All rights reserved.
//

#import "TemplateManager.h"
#import "Line.h"

static TemplateManager *sharedTemplateManager;

@interface TemplateManager (Internal)

- (void)initialize;
- (void)synchronize;

- (NSString *)dataFilePathForCategory:(NSString *)cat title:(NSString *)title;

@end


@implementation TemplateManager

#pragma mark -

- (void)initialize {
	
	NSMutableArray *array = nil;
	
	NSString *path = [self dataFilePathForCategory:@"Shared" title:@"Templates"];
	NSData *data = [[NSData alloc] initWithContentsOfFile:path];
	
	NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];

	array = [unarchiver decodeObject];
	
	[unarchiver finishDecoding];
	
	[unarchiver release];
	[data release];
	
	if (!array) {
		array = [NSArray array];
	}
	
	_templates = [[NSMutableArray alloc] initWithArray:array];
	
	
}

- (void)synchronize {
	
	NSMutableData *data = [[NSMutableData alloc] init];
	
	NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
	[archiver encodeObject:_templates];
	[archiver finishEncoding];
	
	[archiver release];

	[data writeToFile:[self dataFilePathForCategory:@"Shared" title:@"Templates"] atomically:YES];
	[data release];
	
}

#pragma mark - Template managing

- (void)addTemplate:(Line *)template forCharacter:(NSString *)character {
	
	NSDictionary *newDict = [[NSDictionary alloc] initWithObjectsAndKeys:character, @"Character", template, @"Template", nil];
	
	for (int i=0; i<[_templates count]; i++) {
		
		NSDictionary *dict = [_templates objectAtIndex:i];
		if ([[dict objectForKey:@"Character"] isEqualToString:character]) {
			
			[_templates removeObjectAtIndex:i];
			break;
			
		}
		
	}
	
	[_templates addObject:newDict];
	
}

- (NSArray *)templates {
	
	NSMutableArray *array = [[NSMutableArray alloc] init];
	
	for (int i=0; i<[_templates count]; i++) {
		
		NSDictionary *dict = [_templates objectAtIndex:i];
		[array addObject:[dict objectForKey:@"Character"]];
		
	}
	
	[array sortUsingSelector:@selector(compare:)];
	return [array autorelease];
	
}

#pragma mark - Recognizers

- (NSString *)recognizedCharacterForInput:(Line *)input {
	
	NSString *bestMatch = nil;
	double bestError = -1;
	
	for (int i=0; i<[_templates count]; i++) {
		
		NSDictionary *dict = [_templates objectAtIndex:i];
		double error = [input compareToLine:[dict objectForKey:@"Template"]];
		
		if (bestError == -1 || error < bestError) {
			bestError = error;
			bestMatch = [dict objectForKey:@"Character"];
		}
		
	}
	
	return bestMatch;
	
}

- (NSArray *)recognizedDebugResultsForInput:(Line *)input {
	
	NSMutableArray *results = [[NSMutableArray alloc] init];
	
	for (int i=0; i<[_templates count]; i++) {
		
		NSDictionary *dict = [_templates objectAtIndex:i];
		double error = [input compareToLine:[dict objectForKey:@"Template"]];
		
		[results addObject:[NSDictionary dictionaryWithObjectsAndKeys:[dict objectForKey:@"Character"], @"Character", [NSNumber numberWithDouble:error], @"Error", nil]];
		
	}
	
	[results sortUsingSelector:@selector(compare:)];
	
	return results;
	
}

#pragma mark - Singleton methods

+ (TemplateManager *)sharedManager {
	
	if (sharedTemplateManager == nil) {
		
		sharedTemplateManager = [[super allocWithZone:NULL] init];
		[sharedTemplateManager initialize];
		
	}
	
	return sharedTemplateManager;
	
}

+ (id)allocWithZone:(NSZone *)zone {
	
    return [[self sharedManager] retain];
	
}

- (id)copyWithZone:(NSZone *)zone {
    
	return self;
	
}

- (id)retain {
	
    return self;
	
}

- (NSUInteger)retainCount {
	
    return NSUIntegerMax;  
	
}

- (void)release {
	
	
}

- (id)autorelease {
    
	return self;
	
}

#pragma mark -

- (NSString *)dataFilePathForCategory:(NSString *)cat title:(NSString *)title {
	
	NSString *suffix = nil;
	
	if (title && cat)
		suffix = [[[NSString alloc] initWithFormat:@"%@_%@", cat, title] autorelease];
	
	if (!title) {
		suffix = @"archive";
	}
	
	NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
	return [documentsDirectory stringByAppendingPathComponent:suffix];
	
}

@end
