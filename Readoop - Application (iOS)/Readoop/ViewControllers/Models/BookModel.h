//
//  BookModel.h
//  Readoop
//
//  Created by Marin Chitan on 14/05/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookModel : NSObject

@property(nonatomic, strong) NSString* reuseIdentifier;
@property(nonatomic, strong) id object;

+ (BookModel*)getBookModel:(id)object withReuseId:(NSString*)reuseId;

@end
