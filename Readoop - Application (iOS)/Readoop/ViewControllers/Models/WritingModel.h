//
//  WritingModel.h
//  Readoop
//
//  Created by Marin Chitan on 01/07/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WritingModel : NSObject

@property(nonatomic, strong) NSString* reuseIdentifier;
@property(nonatomic, strong) id object;

+ (WritingModel*)getWritingModel:(id)object withReuseId:(NSString*)reuseId;

@end
