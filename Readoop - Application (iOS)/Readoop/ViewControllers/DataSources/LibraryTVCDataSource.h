//
//  LibraryTVCDataSource.h
//  Readoop
//
//  Created by Marin Chitan on 14/05/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LibraryTVCDataSource : NSObject

+ (NSArray*)getAllBooks;
+ (NSArray*)getAllWritings;
+ (NSArray*)getBooksForCurrentUser;
+ (NSArray*)getWritingsForCurrentUser;

+ (NSArray*)getAllBooksWithWildCard:(NSString*)wildCard;
+ (NSArray*)getAllWritingsWithWildCard:(NSString*)wildCard;
+ (NSArray*)getBooksForCurrentUserWithWildCard:(NSString*)wildCard;
+ (NSArray*)getWritingsForCurrentUserWithWildCard:(NSString*)wildCard;


@end
