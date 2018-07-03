//
//  ViewController.m
//  Readoop
//
//  Created by Adrian Burcin on 20/02/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

+ (AnimationViewController*)getAnimationVC {
    return [[UIStoryboard storyboardWithName:@"Initial" bundle:nil]
            instantiateViewControllerWithIdentifier:@"animationViewController"];
}

+ (ProfileViewController*)getProfileVC {
    return [[UIStoryboard storyboardWithName:@"Profile" bundle:nil]
            instantiateViewControllerWithIdentifier:@"profileViewController"];
}

+ (RegisterViewController*)getRegisterVC {
    return [[UIStoryboard storyboardWithName:@"Profile" bundle:nil]
            instantiateViewControllerWithIdentifier:@"registerViewContoller"];
}

+ (DashboardTabbed*)getTabbedDashboard {
    return [[UIStoryboard storyboardWithName:@"Dashboard" bundle:nil]
            instantiateViewControllerWithIdentifier:@"dashboardTabbed"];
}

+ (TesViewController*)getTestVC {
    return [[UIStoryboard storyboardWithName:@"Dashboard" bundle:nil]
            instantiateViewControllerWithIdentifier:@"testViewController"];
}

+ (ChangePasswordVC*)getChangePasswVC {
    return [[UIStoryboard storyboardWithName:@"Profile" bundle:nil]
            instantiateViewControllerWithIdentifier:@"changePasswordVC"];
}

+ (EditProfileVC*)getEditProfileVC {
    return [[UIStoryboard storyboardWithName:@"Profile" bundle:nil]
            instantiateViewControllerWithIdentifier:@"editProfileVC"];
}

+ (AdditionalInfoVC*)getAdditionalInfoVC {
    return [[UIStoryboard storyboardWithName:@"Profile" bundle:nil]
            instantiateViewControllerWithIdentifier:@"additionalInfoVC"];
}

+ (AvatarChangeVC*)getAvatarChangeVC {
    return [[UIStoryboard storyboardWithName:@"Profile" bundle:nil]
            instantiateViewControllerWithIdentifier:@"avatarChangeVC"];
}

+ (UserPresentationVC*)getUserPresentationVC {
    return [[UIStoryboard storyboardWithName:@"Reusables" bundle:nil]
            instantiateViewControllerWithIdentifier:@"userPresentationVC"];
}

+ (RequestsTVC*)getRequestsTVC {
    return [[UIStoryboard storyboardWithName:@"Profile" bundle:nil]instantiateViewControllerWithIdentifier:@"requestsTVC"];
}

+ (BookDetailsVC*)getBookDetailsVC {
    return [[UIStoryboard storyboardWithName:@"Reusables" bundle:nil]
            instantiateViewControllerWithIdentifier:@"bookDetailsVC"];
}
+ (WritingDetailsVC*)getWritingDetailsVC {
    return [[UIStoryboard storyboardWithName:@"Reusables" bundle:nil]
            instantiateViewControllerWithIdentifier:@"writingDetailsVC"];
}

+ (PDFViewerVC *)getPdfVC {
    return [[UIStoryboard storyboardWithName:@"Reusables" bundle:nil]
            instantiateViewControllerWithIdentifier:@"pdfVC"];
}

+ (AddWritingVC *)getAddWritingVC {
    return [[UIStoryboard storyboardWithName:@"Reusables" bundle:nil]
            instantiateViewControllerWithIdentifier:@"addWritingVC"];
}

@end
