//
//  ViewController.h
//  Readoop
//
//  Created by Adrian Burcin on 20/02/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//
//  This is a class that encapsulates all the viewcontrollers retrieving logic

#import <UIKit/UIKit.h>
#import "AnimationViewController.h"
#import "ProfileViewController.h"
#import "RegisterViewController.h"
#import "DashboardTabbed.h"
#import "TesViewController.h"
#import "ChangePasswordVC.h"
#import "EditProfileVC.h"
#import "AdditionalInfoVC.h"
#import "AvatarChangeVC.h"
#import "UserPresentationVC.h"

@interface ViewController : UIViewController

+ (AnimationViewController*)getAnimationVC;
+ (ProfileViewController*)getProfileVC;
+ (RegisterViewController*)getRegisterVC;

+ (DashboardTabbed*)getTabbedDashboard;

+ (ChangePasswordVC*)getChangePasswVC;
+ (EditProfileVC*)getEditProfileVC;
+ (AdditionalInfoVC*)getAdditionalInfoVC;
+ (AvatarChangeVC*)getAvatarChangeVC;

+ (UserPresentationVC*)getUserPresentationVC;

+ (TesViewController*)getTestVC;

@end
