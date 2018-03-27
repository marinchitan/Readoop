//
//  Font.m
//  Readoop
//
//  Created by Marin Chitan on 16/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "Font.h"
#import "NSString+FontAwesome.h"

@implementation Font

+ (UIFont *)getBariolwithSize:(CGFloat)size {
    return [UIFont fontWithName:@"Bariol" size:size];
}

+ (UIFont *)getFAFont:(CGFloat)size {
    return [UIFont fontWithName:kFontAwesomeFamilyName size:20.0];
}

@end
