//
//  AvatarChangeVC.m
//  Readoop
//
//  Created by Marin Chitan on 12/04/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "AvatarChangeVC.h"
#import "Essentials.h"
#import <QuartzCore/QuartzCore.h>

@interface AvatarChangeVC ()

@end

@implementation AvatarChangeVC

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor colorWithDisplayP3Red:55/255 green:55/255 blue:55/255 alpha:0.7];
    [self setupUI];
    
    //UIImage *imageSample = [UIImage imageNamed:@"AppIcon"];
    //NSData *imageData = UIImagePNGRepresentation(imageSample);
    

    
}

- (void)setupUI {
    [ViewUtils setUpCancelActiveBUtton:self.uploadButton];
    [ViewUtils setUpStandardActiveButton:self.saveButton];
    [ViewUtils setUpIconLabel:self.dismissLabel withSize:45];
    [ViewUtils setUpButton:self.uploadButton withRadius:self.initialCornerRadius];
    [ViewUtils setUpButton:self.saveButton withRadius:self.initialCornerRadius];
    self.dismissLabel.text = [NSString fontAwesomeIconStringForEnum:FATimes];
    
    Session *appSession = [Session sharedSession];
    self.avatarView.image = [UIImage imageWithData:appSession
                             .currentUser.avatar];
    self.avatarView.clipsToBounds = YES;
    self.avatarView.layer.cornerRadius = self.avatarView.frame.size.width / 2;
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
