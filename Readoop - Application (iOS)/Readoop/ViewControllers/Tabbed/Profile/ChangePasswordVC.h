//
//  ChangePasswordVC.h
//  Readoop
//
//  Created by Marin Chitan on 06/04/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContainerViewController.h"

@interface ChangePasswordVC : ContainerViewController
@property (weak, nonatomic) IBOutlet UILabel *lockIcon;
@property (weak, nonatomic) IBOutlet UITextField *oldPasswordField;
@property (weak, nonatomic) IBOutlet UITextField *nwPasswordField;
@property (weak, nonatomic) IBOutlet UITextField *reNewPasswordField;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end
