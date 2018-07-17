//
//  RealmUtils.m
//  Readoop
//
//  Created by Marin Chitan on 21/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "RealmUtils.h"
#import "User.h"
#import "Request.h"
#import "Post.h"
#import "BookRate.h"
#import "URLSessionManager.h"

@implementation RealmUtils

+ (void)addUserObject:(User *)user {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        [realm addObject:user];
    }];
}

+ (User*)getUserByName:(NSString*)name byPassword:(NSString*)password {
    User *retrievedUser = [[User objectsWhere:@"username == %@",name] firstObject];
    if(retrievedUser){
        if([retrievedUser.password isEqualToString:password]){
            return retrievedUser;
        }
    }
    return nil;
}

+ (User*)getUserById:(NSNumber*)userId {
    User *retrievedUser = [[User objectsWhere:@"userId == %@",userId] firstObject];
    
    return retrievedUser;
    
}

+ (void)addUser:(User*)user toFriendListOfUser:(User*)secondUser {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        [secondUser.friends addObject:user];
    }];
}

+ (void)changeRememberStatusForUser:(User*)user shouldBeRemembered:(BOOL)remember {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        user.shouldBeRemembered = remember;
    }];
}

+ (void)changePasswordForUser:(User*)user newPassword:(NSString*)newPassword {
    RLMRealm *realm = [RLMRealm defaultRealm];
   
    [realm transactionWithBlock:^{
        user.password = newPassword;
    }];
}

+ (void)changeCountryForUser:(User*)user newCountry:(NSString*)country {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        user.country = country;
    }];
}

+ (void)changeCityForUser:(User*)user newCity:(NSString*)city {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        user.city = city;
    }];
}

+ (void)changeDateForUser:(User*)user newDate:(NSDate*)date {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        user.dateOfBirth = date;
    }];
}

+ (void)changeUsernameForUser:(User*)user newUsername:(NSString*)username {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        user.username = username;
    }];
}

+ (void)changeEmailForUser:(User*)user newEmail:(NSString*)email {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        user.email = email;
    }];
}

+ (void)changeFullNameForUser:(User*)user newName:(NSString*)name {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        user.fullName = name;
    }];
}

+ (void)changeAvatarForUser:(User*)user newAvatar:(NSData*)avatar {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        user.avatar = avatar;
    }];
}

+ (void)changeFirstTimeRegister:(User*)user newFlag:(BOOL)flag {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        user.firstTimeRegsitered = flag;
    }];
}

+ (void)createRequestfromUser:(User*)sender toUser:(User*)receiver {
    RLMRealm *realm = [RLMRealm defaultRealm];
    Request *request = [Request new];
    request.senderId = sender.userId;
    request.receiverId = receiver.userId;
    request.creationTime = [NSDate date];
    NSNumber *primaryKey = [[Request allObjects] maxOfProperty:@"requestId"];
    int key = [primaryKey intValue] + 1;
    request.requestId = [NSNumber numberWithInt:key];
    
    [[URLSessionManager sharedSession] postRequestToMongo:request]; //MONGO POST
    [realm transactionWithBlock:^{
        [realm addObject:request];
    }];
}

+ (void)deleteRequest:(Request*)request {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [[URLSessionManager sharedSession] deleteRequest:request.requestId];
    [realm transactionWithBlock:^{
        [realm deleteObject:request];
    }];
}

+ (void)deleteUser:(User*)user fromFriendListOfUser:(User*)secondUser {
    RLMRealm *realm = [RLMRealm defaultRealm];
    NSUInteger index = [secondUser.friends indexOfObject:user];
    [realm transactionWithBlock:^{
        [secondUser.friends removeObjectAtIndex:index];
    }];
}

+ (void)createFeedPostByUser:(User*)user withContent:(NSString*)content {
    RLMRealm *realm = [RLMRealm defaultRealm];
    Post *post = [Post new];
    post.userId = user.userId;
    NSNumber *primaryKey = [[Post allObjects] maxOfProperty:@"postId"];
    int key = [primaryKey intValue] + 1;
    post.postId = [NSNumber numberWithInt:key];
    post.content = content;
    post.datePosted = [NSDate date];
    
    [[URLSessionManager sharedSession] postPostToMongo:post];
    
    [realm transactionWithBlock:^{
        [realm addObject:post];
        //[realm deleteObjects:[Post allObjects]];
    }];
}

+ (void)insertUserToUps:(User*)user forFeedPost:(Post*)feedPost {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        [feedPost.upRates addObject:user];
    }];
}

+ (void)insertUserToDowns:(User*)user forFeedPost:(Post*)feedPost {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        [feedPost.downRates addObject:user];
    }];
}

+ (void)removeUserToUps:(User*)user forFeedPost:(Post*)feedPost {
    RLMRealm *realm = [RLMRealm defaultRealm];
    if([[feedPost.upRates objectsWhere:@"userId == %@",user.userId] firstObject]){ //remove user if it exists in upRates
        NSUInteger index = [feedPost.upRates indexOfObject:user];
        [realm transactionWithBlock:^{
            [feedPost.upRates removeObjectAtIndex:index];
        }];
    }
}

+ (void)removeUserToDowns:(User*)user forFeedPost:(Post*)feedPost {
    RLMRealm *realm = [RLMRealm defaultRealm];
    if([[feedPost.downRates objectsWhere:@"userId == %@",user.userId] firstObject]){ //remove user if it exists in downRates
        NSUInteger index = [feedPost.downRates indexOfObject:user];
        [realm transactionWithBlock:^{
            [feedPost.downRates removeObjectAtIndex:index];
        }];
    }
}

+ (NSString*)getRatingOfUser:(User*)user ofBook:(Book*)book {
    NSString *primaryKey = [NSString stringWithFormat:@"%@%@", user.userId, book.bookId];
    
    RLMResults *rates = [BookRate objectsWhere:@"bookRateId == %@",primaryKey];
    if(rates.count > 0){
        BookRate *rate = [rates firstObject];
        return [NSString stringWithFormat:@"%1.1f",[rate.rate floatValue]];
    } else {
        return @" - ";
    }
}

+ (void)setRatingForBook:(Book*)book rating:(float)rating byUser:(User*)user {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    BookRate *newRate = [BookRate new];
    NSNumber<RLMFloat> *newRating = [NSNumber numberWithFloat:rating];
    newRate.rate = newRating;
    newRate.userId = user.userId;
    newRate.bookId = book.bookId;
    newRate.bookRateId = [NSString stringWithFormat:@"%@%@", user.userId, book.bookId];
    
    [[URLSessionManager sharedSession] postBookRateToMongo:newRate];
    
    [realm transactionWithBlock:^{
        [realm addOrUpdateObject:newRate];
    }];
}

+ (float)getInitialRatingForBook:(Book*)book forUser:(User*)user {
    RLMArray *rates = book.rates;
    for(BookRate *rate in rates){
        if(rate.userId == user.userId) {
            return [rate.rate floatValue];
        }
    }
    return 2.5;
}

+ (void)addBook:(Book*)book toUser:(User*)user {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        [user.books addObject:book];
    }];
    
}

+ (void)removeBook:(Book*)book fromUser:(User*)user {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        [user.books removeObjectAtIndex:[user.books indexOfObject:book]];
    }];
}

+ (BOOL)user:(User*)user hasBook:(Book*)book {
    int index = [user.books indexOfObject:book];
    int notFound = -1;
    return index != notFound;
}

+ (BOOL)user:(User*)user hasBoughtWriting:(Writing*)writing {
    int index = [user.writings indexOfObject:writing];
    int notFound = -1;
    return index != notFound;
}

+ (BOOL)user:(User*)user isAuthorOfWriting:(Writing*)writing {
    return [user.userId intValue] == [writing.authorId intValue];
}


+ (void)addBooksFromAPI:(NSMutableArray *)books {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        for(Book *book in books) {
            [realm addOrUpdateObject:book];
        }
    }];
}

+ (void)clearBooks {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        [realm deleteObjects:[Book allObjects]];
    }];
}


+ (NSString *)getAverageRatingOfBook:(Book *)book {
    RLMResults *bookRates = [BookRate objectsWhere:@"bookId == %@", book.bookId];
    NSInteger count = 0;
    float totalRate = 0.0;
    for(BookRate *rate in bookRates){
        totalRate += [rate.rate floatValue];
        count++;
    }
    if(count == 0){
        return @"-";
    } else {
        float average = totalRate / count;
        return [NSString stringWithFormat:@"%1.1f",average];
        
    }
}

+ (void)addWriting:(Writing*)writing toUser:(User*)user {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        [user.writings addObject:writing];
    }];
}

+ (void)addStatusPoint:(User *)user {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    NSInteger currentStatus = [user.status integerValue];
    currentStatus += 1;
    NSNumber<RLMInt> *finalStatus = [NSNumber numberWithInteger:currentStatus];
    [realm transactionWithBlock:^{
        user.status = finalStatus;
    }];
}

+ (void)removeStatusPoint:(User *)user {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    NSInteger currentStatus = [user.status integerValue];
    currentStatus -= 1;
    NSNumber<RLMInt> *finalStatus = [NSNumber numberWithInteger:currentStatus];
    [realm transactionWithBlock:^{
        user.status = finalStatus;
    }];
}

+ (int)getStatusPointsForUser:(User *)user {
    return [user.status integerValue];
}

+ (void)insertWriting:(Writing *)writing {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [[URLSessionManager sharedSession] postWritingToMongo:writing];
    
    [realm transactionWithBlock:^{
        [realm addOrUpdateObject:writing];
    }];
}

+ (Writing *)getWritingById:(NSNumber *)writingId {
    return [[Writing objectsWhere:@"writingId == %@", writingId] firstObject];
}


+ (void)insertUserToUps:(User*)user forWritingComment:(WritingComment*)writingComment {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        [writingComment.upRates addObject:user];
    }];
}

+ (void)insertUserToDowns:(User*)user forWritingComment:(WritingComment*)writingComment {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        [writingComment.downRates addObject:user];
    }];
}

+ (void)removeUserToUps:(User*)user forWritingComment:(WritingComment*)writingComment {
    RLMRealm *realm = [RLMRealm defaultRealm];
    if([[writingComment.upRates objectsWhere:@"userId == %@",user.userId] firstObject]){ //remove user if it exists in upRates
        NSUInteger index = [writingComment.upRates indexOfObject:user];
        [realm transactionWithBlock:^{
            [writingComment.upRates removeObjectAtIndex:index];
        }];
    }
}

+ (void)removeUserToDowns:(User*)user forWritingComment:(WritingComment*)writingComment {
    RLMRealm *realm = [RLMRealm defaultRealm];
    if([[writingComment.downRates objectsWhere:@"userId == %@",user.userId] firstObject]){ //remove user if it exists in downRates
        NSUInteger index = [writingComment.downRates indexOfObject:user];
        [realm transactionWithBlock:^{
            [writingComment.downRates removeObjectAtIndex:index];
        }];
    }
}

+ (void)createWritingCommentPostByUser:(User*)user withContent:(NSString*)content forWriting:(Writing *)writing{
    RLMRealm *realm = [RLMRealm defaultRealm];
    WritingComment *writingComment = [WritingComment new];
    writingComment.userId = user.userId;
    NSNumber *primaryKey = [[WritingComment allObjects] maxOfProperty:@"writingCommentId"];
    int key = [primaryKey intValue] + 1;
    writingComment.writingCommentId = [NSNumber numberWithInt:key];
    writingComment.writingId = writing.writingId;
    writingComment.content = content;
    writingComment.datePosted = [NSDate date];
    
    [[URLSessionManager sharedSession] postWritingCommentsToMongo:writingComment];
    
    [realm transactionWithBlock:^{
        [realm addObject:writingComment];
    }];
}

+ (void)populateRequestsFromMongo:(NSArray *)requests {
    RLMRealm *realm = [RLMRealm defaultRealm];
    for(Request *req in requests) {
        if(![RealmUtils requestExists:req]){
            NSLog(@"Adding request <%@>",req.requestId);
            [realm transactionWithBlock:^{
                [realm addObject:req];
            }];
        } else {
            NSLog(@"Request <%@> skipped", req.requestId);
        }
    }
}

+ (BOOL)requestExists:(Request*)req {
    RLMResults *existingRequests = [Request allObjects];
    for(Request *request in existingRequests) {
        if(request.requestId == req.requestId){
            return true;
        }
    }
    return false;
}

+ (void)populateWritinCommentsFromMongo:(NSArray *)comments {
    RLMRealm *realm = [RLMRealm defaultRealm];
    for(WritingComment *comm in comments) {
        if(![RealmUtils writingCommentExists:comm]){
            NSLog(@"Adding writing comment <%@>",comm.writingCommentId);
            [realm transactionWithBlock:^{
                [realm addObject:comm];
            }];
        } else {
            NSLog(@"Writing comment <%@> skipped", comm.writingCommentId);
        }
    }
}

+ (BOOL)writingCommentExists:(WritingComment*)comment {
    RLMResults *writingComments = [WritingComment allObjects];
    for(WritingComment *comm in writingComments) {
        if(comment.writingCommentId == comm.writingCommentId){
            return true;
        }
    }
    return false;
}

+ (void)populateBookRatesFromMongo:(NSArray *)bookRates {
    RLMRealm *realm = [RLMRealm defaultRealm];
    for(BookRate *rate in bookRates) {
        if(![RealmUtils bookRatesExist:rate]){
            NSLog(@"Adding book rate <%@>",rate.bookRateId);
            [realm transactionWithBlock:^{
                [realm addObject:rate];
            }];
        } else {
            NSLog(@"Book rate <%@> skipped", rate.bookRateId);
        }
    }
}

+ (BOOL)bookRatesExist:(BookRate*)bookRate {
    RLMResults *bookRates = [BookRate allObjects];
    for(BookRate *rate in bookRates) {
        if([rate.bookRateId isEqualToString:bookRate.bookRateId]){
            return true;
        }
    }
    return false;
}

+ (void)populatePostsFromMongo:(NSArray *)posts {
    RLMRealm *realm = [RLMRealm defaultRealm];
    for(Post *post in posts) {
        if(![RealmUtils postExists:post]){
            NSLog(@"Adding post <%@>",post.postId);
            [realm transactionWithBlock:^{
                [realm addObject:post];
            }];
        } else {
            NSLog(@"Post <%@> skipped", post.postId);
        }
    }
}

+ (BOOL)postExists:(Post*)post {
    RLMResults *posts = [Post allObjects];
    for(Post *pt in posts) {
        if(post.postId == pt.postId){
            return true;
        }
    }
    return false;
}

+ (void)populateWritingsFromMongo:(NSArray *)writings {
    RLMRealm *realm = [RLMRealm defaultRealm];
    for(Writing *writing in writings) {
        if(![RealmUtils writingsExists:writing]){
            NSLog(@"Adding writing <%@>",writing.writingId);
            [realm transactionWithBlock:^{
                [realm addObject:writing];
            }];
        } else {
            NSLog(@"Writing <%@> skipped", writing.writingId);
        }
    }
}

+ (BOOL)writingsExists:(Writing*)writing {
    RLMResults *writings = [Writing allObjects];
    for(Writing *wr in writings) {
        if(writing.writingId == wr.writingId){
            return true;
        }
    }
    return false;
}

@end
