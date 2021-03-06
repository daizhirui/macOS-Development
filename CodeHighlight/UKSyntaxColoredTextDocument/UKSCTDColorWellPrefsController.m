//
//  UKSCTDColorWellPrefsController.m
//  CocoaTADS
//
//  Created by Uli Kusterer on Wed Feb 11 2004.
//  Copyright (c) 2004 M. Uli Kusterer. All rights reserved.
//

// -----------------------------------------------------------------------------
//  Headers:
// -----------------------------------------------------------------------------

#import "UKSCTDColorWellPrefsController.h"
#import "NSArray+Color.h"
#import "UKSyntaxColoredTextDocument.h"


@implementation UKSCTDColorWellPrefsController

// -----------------------------------------------------------------------------
//	awakeFromNib:
//		This object has just been loaded from its NIB. Initialize the prefs
//		and display them in the color wells we are connected to.
//
//	REVISIONS:
//		2004-05-18	witness	Documented.
// -----------------------------------------------------------------------------

-(void) awakeFromNib
{
	[UKSyntaxColoredTextDocument makeSurePrefsAreInited];
	[self updateUIFromPrefs: self];
}

// -----------------------------------------------------------------------------
//	updateUIFromPrefs:
//		Assign the colors from user defaults to the corresponding color wells.
//
//	REVISIONS:
//		2004-05-18	witness	Documented.
// -----------------------------------------------------------------------------

-(void) updateUIFromPrefs: (id)sender
{
	NSArray*	arr = [[NSUserDefaults standardUserDefaults] objectForKey: @"SyntaxColoring:Color:Comments"];
	if( arr )
		[commentsColor setColor: [arr colorValue]];
	
	arr = [[NSUserDefaults standardUserDefaults] objectForKey: @"SyntaxColoring:Color:Identifiers"];
	if( arr )
		[identifiersColor setColor: [arr colorValue]];	
	
	arr = [[NSUserDefaults standardUserDefaults] objectForKey: @"SyntaxColoring:Color:Preprocessor"];
	if( arr )
		[preprocessorColor setColor: [arr colorValue]];	

	arr = [[NSUserDefaults standardUserDefaults] objectForKey: @"SyntaxColoring:Color:Strings"];
	if( arr )
		[stringsColor setColor: [arr colorValue]];	

	arr = [[NSUserDefaults standardUserDefaults] objectForKey: @"SyntaxColoring:Color:Tags"];
	if( arr )
		[tagsColor setColor: [arr colorValue]];	

	arr = [[NSUserDefaults standardUserDefaults] objectForKey: @"SyntaxColoring:Color:UserIdentifiers"];
	if( !arr )
		arr = [[NSUserDefaults standardUserDefaults] objectForKey: @"SyntaxColoring:Color:Identifiers2"];
	if( arr )
		[identifiers2Color setColor: [arr colorValue]];	

	arr = [[NSUserDefaults standardUserDefaults] objectForKey: @"SyntaxColoring:Color:Comments2"];
	if( arr )
		[comments2Color setColor: [arr colorValue]];	
}


// -----------------------------------------------------------------------------
//	takeCommentsColorFrom:
//		Action for "comments" color well that takes the new color and saves
//		it to the user defaults.
//
//	REVISIONS:
//		2004-05-18	witness	Documented.
// -----------------------------------------------------------------------------

-(IBAction)		takeCommentsColorFrom: (NSColorWell*)cw
{
	NSArray*		theColor = [NSArray arrayWithColor: [cw color]];
	[[NSUserDefaults standardUserDefaults] setObject: theColor forKey: @"SyntaxColoring:Color:Comments"];
}


// -----------------------------------------------------------------------------
//	takeIdentifiersColorFrom:
//		Action for "identifiers" color well that takes the new color and saves
//		it to the user defaults.
//
//	REVISIONS:
//		2004-05-18	witness	Documented.
// -----------------------------------------------------------------------------

-(IBAction)		takeIdentifiersColorFrom: (NSColorWell*)cw
{
	NSArray*		theColor = [NSArray arrayWithColor: [cw color]];
	[[NSUserDefaults standardUserDefaults] setObject: theColor forKey: @"SyntaxColoring:Color:Identifiers"];
}


// -----------------------------------------------------------------------------
//	takeIdentifiers2ColorFrom:
//		Action for "identifiers2" color well that takes the new color and saves
//		it to the user defaults.
//
//	REVISIONS:
//		2004-05-18	witness	Documented.
// -----------------------------------------------------------------------------

-(IBAction)		takeIdentifiers2ColorFrom: (NSColorWell*)cw
{
	NSArray*		theColor = [NSArray arrayWithColor: [cw color]];
	[[NSUserDefaults standardUserDefaults] setObject: theColor forKey: @"SyntaxColoring:Color:Identifiers2"];
	[[NSUserDefaults standardUserDefaults] setObject: theColor forKey: @"SyntaxColoring:Color:UserIdentifiers"];
}


// -----------------------------------------------------------------------------
//	takePreprocessorColorFrom:
//		Action for "preprocessor" color well that takes the new color and saves
//		it to the user defaults.
//
//	REVISIONS:
//		2004-05-18	witness	Documented.
// -----------------------------------------------------------------------------

-(IBAction)		takePreprocessorColorFrom: (NSColorWell*)cw
{
	NSArray*		theColor = [NSArray arrayWithColor: [cw color]];
	[[NSUserDefaults standardUserDefaults] setObject: theColor forKey: @"SyntaxColoring:Color:Preprocessor"];
}


// -----------------------------------------------------------------------------
//	takeStringsColorFrom:
//		Action for "strings" color well that takes the new color and saves
//		it to the user defaults.
//
//	REVISIONS:
//		2004-05-18	witness	Documented.
// -----------------------------------------------------------------------------

-(IBAction)		takeStringsColorFrom: (NSColorWell*)cw
{
	NSArray*		theColor = [NSArray arrayWithColor: [cw color]];
	[[NSUserDefaults standardUserDefaults] setObject: theColor forKey: @"SyntaxColoring:Color:Strings"];
}


// -----------------------------------------------------------------------------
//	takeTagsColorFrom:
//		Action for "tags" color well that takes the new color and saves
//		it to the user defaults.
//
//	REVISIONS:
//		2004-05-18	witness	Documented.
// -----------------------------------------------------------------------------

-(IBAction)		takeTagsColorFrom: (NSColorWell*)cw
{
	NSArray*		theColor = [NSArray arrayWithColor: [cw color]];
	[[NSUserDefaults standardUserDefaults] setObject: theColor forKey: @"SyntaxColoring:Color:Tags"];
}


// -----------------------------------------------------------------------------
//	takeComments2ColorFrom:
//		Action for "comments2" color well that takes the new color and saves
//		it to the user defaults.
//
//	REVISIONS:
//		2004-05-18	witness	Documented.
// -----------------------------------------------------------------------------

-(IBAction)		takeComments2ColorFrom: (NSColorWell*)cw
{
	NSArray*		theColor = [NSArray arrayWithColor: [cw color]];
	[[NSUserDefaults standardUserDefaults] setObject: theColor forKey: @"SyntaxColoring:Color:Comments2"];
}


// -----------------------------------------------------------------------------
//	resetColors:
//		Load the list of colors from the SyntaxColorDefaults file and re-apply
//		them to the prefs.
//
//	REVISIONS:
//		2004-05-18	witness	Documented.
// -----------------------------------------------------------------------------

-(IBAction)		resetColors: (id)sender
{
	NSDictionary*   newValues = [NSDictionary dictionaryWithContentsOfFile: [[NSBundle mainBundle] pathForResource: @"SyntaxColorDefaults" ofType:@"plist"]];
	NSEnumerator*   keysEnny = [newValues keyEnumerator];
	NSString*		currKey = nil;
	id				currValue = nil;
	NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
	
	while( (currKey = [keysEnny nextObject]) )
	{
		currValue = [newValues objectForKey: currKey];
		[ud setObject: currValue forKey: currKey];
	}
	
	[self updateUIFromPrefs: self];
}


@end
