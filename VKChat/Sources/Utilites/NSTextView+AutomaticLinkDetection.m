//
//  NSTextView+AutomaticLinkDetection.m
//  AutoLink
//
//  Created by Randall Brown on 8/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSTextView+AutomaticLinkDetection.h"
#import "NSString+FindURLs.h"
#import "NSAttributedString+Hyperlink.h"

@implementation NSTextView (NSTextView_AutomaticLinkDetection)

- (void)detectAndAddLinks {
   NSArray *linkLocations = [[self string] locationsOfLinks];
   NSArray *links = [[self string] arrayOfLinks];

   for (int i = 0; i < [links count]; i++) {
       NSString *link = [links objectAtIndex:i];
       NSAttributedString *linkString = [NSAttributedString hyperlinkFromString:link withURL:[NSURL URLWithString:link]];
       [[self textStorage] replaceCharactersInRange:[[linkLocations objectAtIndex:i] range] withAttributedString:linkString];
   }
}

@end
