//
//  URLSessionManager.m
//  Readoop
//
//  Created by Marin Chitan on 29/06/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "URLSessionManager.h"
#import "NetworkingConfig.h"
#import <Realm/Realm.h>
#import "Book.h"
#import "RealmUtils.h"

@implementation URLSessionManager

- (NSArray *)getAuthorsForBooks {
    return @[@"Lucian%20Blaga", @"Marin%20Preda", @"Mark%20Twain", @"Ray%20Bradbury", @"George%20Orwell", @"Kurt%20Vonnegut", @"Tolstoy", @"Dostoievski", @"Dickens", @"Tolkien", @"Victor%20Hugo", @"Oscar%20Wilde", @"Franz%20Kafka", @"Hemingway", @"Joyce", @"Dumas", @"Verne", @"Christie"];
}

- (void)startBookRequests {
    [RealmUtils clearBooks];
    
    for(NSString *author in [self getAuthorsForBooks]) {
        [self loadBooksFromGoogleAPIForAuthor:author];
    }


}


- (void)loadBooksFromGoogleAPIForAuthor:(NSString *)author {
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSString *urlString = [NetworkingConfig getGoogleURLStringWithAuthor:author withKey:[NetworkingConfig getGoogleAPIKey]];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"URL:%@", urlString);
    __block NSArray *books = [NSArray new];
    
    NSURLSessionDataTask *booksGetTask = [session dataTaskWithURL:url
                                                completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                    NSLog(@"Start request for author: %@", author);
                                                    NSError *jsonError;
                                                    NSDictionary *dict = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data
                                                                                                                         options:NSJSONReadingAllowFragments
                                                                                                                           error:&jsonError];
                                                    books = dict[@"items"];
                                                    [session finishTasksAndInvalidate];
                                                    NSLog(@"Finish request for author: %@", author);
                                                    
                                                    [RealmUtils addBooksFromAPI:[self getBookObjects:books]];
                                                }];
    [booksGetTask resume];
    
   
}

- (NSMutableArray *)getBookObjects:(NSArray*)books {
    NSMutableArray *bookObjects = [NSMutableArray new];
    for(id book in books){
        [bookObjects addObject:[self getBookObject:book]];
    }
    
    return bookObjects;
}

- (Book *)getBookObject:(id)bookFromAPI {
    Book *bookObject = [Book new];
    bookObject.bookId = bookFromAPI[@"id"];
    bookObject.bookTitle = bookFromAPI[@"volumeInfo"][@"title"];
    bookObject.bookAuthor = bookFromAPI[@"volumeInfo"][@"authors"][0];
    bookObject.bookPublishedYear = bookFromAPI[@"volumeInfo"][@"publishedDate"];
    
    NSString *publisher = bookFromAPI[@"volumeInfo"][@"publisher"];
    if(publisher != NULL && publisher != (id)[NSNull null]) {
        bookObject.bookPublisher = publisher;
    } else {
        bookObject.bookPublisher = @"-";
    }
    
    NSString *imageURL = bookFromAPI[@"volumeInfo"][@"imageLinks"][@"thumbnail"];
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: imageURL]];
    
    if(imageURL != NULL && imageURL != (id)[NSNull null]) {
        bookObject.imageWithURL = imageURL;
        bookObject.imageName = @"";
        bookObject.coverImage = imageData;
    } else {
        bookObject.imageWithURL = @"";
        bookObject.imageName = @"defaultLoadBook";
    }
    
   
    
    NSString *numberOfPages = [NSString stringWithFormat:@"%@", bookFromAPI[@"volumeInfo"][@"pageCount"]];
    if(publisher != NULL && publisher != (id)[NSNull null]) {
        bookObject.pages = numberOfPages;
    } else {
        bookObject.pages = [self getPages];
    }
    
    
    return bookObject;
}

- (NSString *)getPages {
    int lowerBound = 150;
    int upperBound = 400;
    int rndValue = lowerBound + arc4random() % (upperBound - lowerBound);
    return [NSString stringWithFormat:@"%d",rndValue];
}

+ (id)sharedSession {
    static URLSessionManager *urlManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        urlManager = [[self alloc] init];
    });
    return urlManager;
}

- (id)init {
    if(self = [super init]){
        //DO somet default initialization
    }
    return self;
}

@end
