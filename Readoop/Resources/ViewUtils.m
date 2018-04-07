//
//  ViewUtils.m
//  Readoop
//
//  Created by Marin Chitan on 06/04/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "ViewUtils.h"
#import "Color.h"
#import "NSString+FontAwesome.h"

@implementation ViewUtils

+ (void)setUpField:(UITextField*)field withRadius:(CGFloat)radius {
    field.layer.cornerRadius = radius;
    field.layer.borderColor = [[Color getTextFieldBorderGray] CGColor];
    field.layer.masksToBounds = YES;
    field.layer.borderWidth = 1.0f;
}

+ (void)setUpButton:(UIButton*)button withRadius:(CGFloat)radius {
    button.layer.cornerRadius = radius;
}

+ (void)setUpIconLabel:(UILabel*)field withSize:(CGFloat)size{
    field.font = [UIFont fontWithName:kFontAwesomeFamilyName size:size];
}

+ (void)setUpStandardActiveButton:(UIButton*)button {
    button.backgroundColor = [Color getMainRed];
    button.enabled = YES;
    [button setTitleColor:[Color getMainPassiveGray] forState:UIControlStateDisabled];
}
+ (void)setUpStandardInactiveButton:(UIButton*)button{
    button.enabled = NO;
    button.backgroundColor = [Color getPassiveBariolRed];
    [button setTitleColor:[Color getMainPassiveGray] forState:UIControlStateDisabled];
}

+ (void)setUpCancelActiveBUtton:(UIButton*)button {
    button.backgroundColor = [Color getMainPassiveGray];
}

@end
