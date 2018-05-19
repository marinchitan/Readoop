//
//  BookModel.m
//  Readoop
//
//  Created by Marin Chitan on 14/05/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "BookModel.h"

@implementation BookModel

+ (BookModel*)getBookModel:(id)object withReuseId:(NSString*)reuseId {
    BookModel *model = [BookModel new];
    model.object = object;
    model.reuseIdentifier = reuseId;
    return model;
}

@end
