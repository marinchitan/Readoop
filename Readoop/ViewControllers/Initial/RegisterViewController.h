//
//  RegisterViewController.h
//  Readoop
//
//  Created by Marin Chitan on 04/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"

@interface RegisterViewController : UIViewController
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *modularScrollView;
@property (weak, nonatomic) IBOutlet UIView *registerPanel;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordFied;
@property (weak, nonatomic) IBOutlet UITextField *confirmpasswordField;
@property (weak, nonatomic) IBOutlet UITextField *fullnameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;


@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@end
