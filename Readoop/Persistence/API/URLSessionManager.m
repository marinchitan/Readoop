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

#pragma mark: Requests(social) handling

- (void)loadRequestsFromMongo {
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSString *urlString = [NetworkingConfig getRequestsHostString];
    NSURL *url = [NSURL URLWithString:urlString];
    
    __block NSArray *requests = [NSArray new];
    
    NSURLSessionDataTask *requestsGetTask = [session dataTaskWithURL:url
                                                completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                    NSError *jsonError;
                                                    if(data != nil) {
                                                        requests = (NSArray *)[NSJSONSerialization JSONObjectWithData:data
                                                                                                                             options:NSJSONReadingAllowFragments
                                                                                                                               error:&jsonError];
                                                        
                                                        [RealmUtils populateRequestsFromMongo:[self getRequestsObjects:requests]];
                                                    } else {
                                                        NSLog(@"Can not connect to Mongo");
                                                    }
                                                    
                                                    }];
    
    [requestsGetTask resume];
}

- (void)postRequestToMongo:(Request *)request {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    
    NSString *dateString = [dateFormat stringFromDate:request.creationTime];
    NSDictionary *dictionary = @{@"requestId": request.requestId, @"senderId": request.senderId, @"receiverId": request.receiverId, @"dateAdded": dateString};
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSString *urlString = [NetworkingConfig getRequestsHostString];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *postRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary
                                                   options:kNilOptions error:&error];
    [postRequest setHTTPBody:data];
    
    NSURLSessionUploadTask *requestsPostTask = [session uploadTaskWithRequest:postRequest
                                                                     fromData:data
                                                            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                                    if(data != nil) {
                                                                        NSLog(@"POST request status: %@", response.description); //Post request status
                                                                    } else {
                                                                        NSLog(@"Can not connect to Mongo");
                                                                    }
                                                            }];
    [requestsPostTask resume];
}

- (void)deleteRequest:(NSNumber *)requestId {
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSString *urlString = [NetworkingConfig getRequestsHostString];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *deleteRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    [deleteRequest setHTTPMethod:@"DELETE"];
    [deleteRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSDictionary *dict = @{@"requestId":requestId};
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict
                                                   options:kNilOptions error:&error];
    
    
    
    
    [deleteRequest setHTTPBody:data];
    
    NSURLSessionDataTask *requestDeleteTask = [session dataTaskWithRequest:deleteRequest
                                                     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                         if(data != nil) {
                                                             NSLog(@"DELETE request status: %@", response.description); //Delete request status
                                                         } else {
                                                             NSLog(@"Can not connect to Mongo");
                                                         }
                                                     }];
    [requestDeleteTask resume];
}

- (NSArray *)getRequestsObjects:(NSArray *)apiDict {
    NSMutableArray *newRequests = [NSMutableArray new];
    for(id object in apiDict){
        NSLog(@"Request: %@", object[@"requestId"]);
        Request *newRequest = [Request new];
        newRequest.requestId = object[@"requestId"];
        newRequest.senderId = object[@"senderId"];
        newRequest.receiverId = object[@"receiverId"];
        NSString *dateString = object[@"dateAdded"];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd-MM-yyyy"];
        NSDate *date = [dateFormat dateFromString:dateString];
        newRequest.creationTime = date;
        
        [newRequests addObject:newRequest];
    }
    return newRequests;
}

#pragma mark: WritingComment handling

- (void)loadWritingCommentsFromMongo {
    
}

- (void)postWritingCommentsToMongo:(WritingComment *)writingComment {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    
    NSString *dateString = [dateFormat stringFromDate:writingComment.datePosted];
    NSDictionary *dictionary = @{@"writingCommentId": writingComment.writingCommentId, @"userId": writingComment.userId, @"writingId": writingComment.writingId, @"datePosted":dateString, @"content":writingComment.content, @"upRates":@[], "downRates":@[]};
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSString *urlString = [NetworkingConfig getWritingCommentHostString];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *postRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary
                                                   options:kNilOptions error:&error];
    [postRequest setHTTPBody:data];
    
    NSURLSessionUploadTask *writingCommentPostTask = [session uploadTaskWithRequest:postRequest
                                                                     fromData:data
                                                            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                                if(data != nil) {
                                                                    NSLog(@"POST request status: %@", response.description); //Post request status
                                                                } else {
                                                                    NSLog(@"Can not connect to Mongo");
                                                                }
                                                            }];
    [writingCommentPostTask resume];
}

- (void)deleteWritingComment:(NSNumber *)writingCommentId {
    
}


#pragma mark: Books from Google API

- (NSArray *)getAuthorsForBooks {
    return @[@"Lucian%20Blaga", @"Marin%20Preda", @"Mark%20Twain", @"Ray%20Bradbury", @"George%20Orwell", @"Kurt%20Vonnegut", @"Tolstoy", @"Dostoievski", @"Dickens", @"Tolkien", @"Victor%20Hugo", @"Oscar%20Wilde", @"Franz%20Kafka", @"Hemingway", @"Joyce", @"Dumas", @"Verne", @"Christie", @"Camus", @"Kipling"];
}

- (void)startBookRequests {
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
                                                    if(data != nil) {
                                                        NSDictionary *dict = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data
                                                                                                                         options:NSJSONReadingAllowFragments
                                                                                                                           error:&jsonError];
                                                        books = dict[@"items"];
                                                        [session finishTasksAndInvalidate];
                                                        NSLog(@"Finish request for author: %@", author);
                                                        [RealmUtils addBooksFromAPI:[self getBookObjects:books]];
                                                    }
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
