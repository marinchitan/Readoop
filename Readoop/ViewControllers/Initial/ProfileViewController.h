//
//  ProfileViewController.h
//  Readoop
//
//  Created by Marin Chitan on 20/02/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"


@interface ProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet UIView *profileView;

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UILabel *accountLabel1;
@property (weak, nonatomic) IBOutlet UILabel *accountLabel2;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;


@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *modularScrollView;

@end
