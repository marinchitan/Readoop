//
//  ViewUtils.h
//  Readoop
//
//  Created by Marin Chitan on 06/04/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ViewUtils : NSObject

+ (void)setUpField:(UITextField*)field withRadius:(CGFloat)radius;
+ (void)setUpTextView:(UITextView*)field withRadius:(CGFloat)radius;

+ (void)setUpButton:(UIButton*)button withRadius:(CGFloat)radius;
+ (void)setUpIconLabel:(UILabel*)field withSize:(CGFloat)size;
+ (void)setUpStandardActiveButton:(UIButton*)button;
+ (void)setUpStandardInactiveButton:(UIButton*)button;

+ (void)setUpCancelActiveBUtton:(UIButton*)button;
@end
