//
//  RegisterViewController.h
//  Readoop
//
//  Created by Marin Chitan on 04/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"

typedef enum fieldStates{
    empty_field,
    valid_field,
    invalid_field
}FieldState;

@interface RegisterViewController : UIViewController
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *modularScrollView;
@property (weak, nonatomic) IBOutlet UIView *registerPanel;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordFied;
@property (weak, nonatomic) IBOutlet UITextField *confirmpasswordField;
@property (weak, nonatomic) IBOutlet UITextField *fullnameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;
@property (weak, nonatomic) IBOutlet UILabel *confirmpasswordLabel;
@property (weak, nonatomic) IBOutlet UILabel *fullnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@property (weak, nonatomic) IBOutlet UILabel *usernameValidText;
@property (weak, nonatomic) IBOutlet UILabel *passwordValidText;
@property (weak, nonatomic) IBOutlet UILabel *confirmpasswValidText;
@property (weak, nonatomic) IBOutlet UILabel *nameValidText;
@property (weak, nonatomic) IBOutlet UILabel *emailValidText;


@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@end
