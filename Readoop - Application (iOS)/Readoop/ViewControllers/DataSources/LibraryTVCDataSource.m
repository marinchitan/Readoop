//
//  LibraryTVCDataSource.m
//  Readoop
//
//  Created by Marin Chitan on 14/05/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "LibraryTVCDataSource.h"
#import "BookModel.h"
#import "WritingModel.h"
#import <Realm/Realm.h>
#import "Book.h"
#import "Writing.h"
#import "Session.h"

@implementation LibraryTVCDataSource

+ (NSArray*)getAllBooks {
    RLMResults *books = [Book allObjects];
    NSMutableArray *booksModels = [NSMutableArray new];
    
    for(Book *book in books){
        BookModel *model = [BookModel getBookModel:book withReuseId:@"bookCell"];
        [booksModels addObject:model];
    }
    
    return booksModels;
}

+ (NSArray*)getAllWritings {
    RLMResults *writings = [Writing allObjects];
    NSMutableArray *writingsModels = [NSMutableArray new];
    
    for(Writing *writing in writings){
        WritingModel *model = [WritingModel getWritingModel:writing withReuseId:@"writingCell"];
        [writingsModels addObject:model];
    }
    
    return writingsModels;
}

+ (NSArray*)getBooksForCurrentUser {
    Session *appSession = [Session sharedSession];
    NSMutableArray *booksModels = [NSMutableArray new];
    RLMArray *books = appSession.currentUser.books;
    for(Book *book in books){
        BookModel *model = [BookModel getBookModel:book withReuseId:@"bookCell"];
        [booksModels addObject:model];
    }
    
    return booksModels;
}

+ (NSArray*)getWritingsForCurrentUser {
    Session *appSession = [Session sharedSession];
    NSMutableArray *writingsModels = [NSMutableArray new];
    RLMArray *writings = appSession.currentUser.writings;
    for(Writing *writing in writings){
        WritingModel *model = [WritingModel getWritingModel:writing withReuseId:@"writingCell"];
        [writingsModels addObject:model];
    }
    
    return writingsModels;
}



+ (NSArray*)getAllBooksWithWildCard:(NSString*)wildCard {
    NSString *predicate = [NSString stringWithFormat:@"*%@*", wildCard];
    RLMResults *books = [Book objectsWhere:@"bookTitle LIKE %@ OR bookAuthor LIKE %@ OR bookPublisher LIKE %@", predicate, predicate, predicate];
    NSMutableArray *booksModels = [NSMutableArray new];
    
    for(Book *book in books){
        BookModel *model = [BookModel getBookModel:book withReuseId:@"bookCell"];
        [booksModels addObject:model];
    }
    
    return booksModels;
}

+ (NSArray*)getAllWritingsWithWildCard:(NSString*)wildCard {
    NSString *predicate = [NSString stringWithFormat:@"*%@*", wildCard];
    
    RLMResults *writings = [Writing objectsWhere:@"writingTitle LIKE %@ ", predicate];
    NSMutableArray *writingsModels = [NSMutableArray new];
    
    for(Writing *writing in writings){
        WritingModel *model = [WritingModel getWritingModel:writing withReuseId:@"writingCell"];
        [writingsModels addObject:model];
    }
    
    return writingsModels;
}

+ (NSArray*)getBooksForCurrentUserWithWildCard:(NSString*)wildCard {
    NSString *predicate = [NSString stringWithFormat:@"*%@*", wildCard];
    Session *appSession = [Session sharedSession];
    NSMutableArray *booksModels = [NSMutableArray new];
    RLMResults *books = [appSession.currentUser.books objectsWhere:@"bookTitle LIKE %@ OR bookAuthor LIKE %@ OR bookPublisher LIKE %@", predicate, predicate, predicate];
    
    for(Book *book in books){
        BookModel *model = [BookModel getBookModel:book withReuseId:@"bookCell"];
        [booksModels addObject:model];
    }
    
    return booksModels;
}

+ (NSArray*)getWritingsForCurrentUserWithWildCard:(NSString*)wildCard {
    NSString *predicate = [NSString stringWithFormat:@"*%@*", wildCard];
    
    Session *appSession = [Session sharedSession];
    NSMutableArray *writingsModels = [NSMutableArray new];
    RLMResults *writings = [appSession.currentUser.writings objectsWhere:@"writingTitle LIKE %@ ", predicate];
    for(Writing *writing in writings){
        WritingModel *model = [WritingModel getWritingModel:writing withReuseId:@"writingCell"];
        [writingsModels addObject:model];
    }
    
    return writingsModels;
}

@end
