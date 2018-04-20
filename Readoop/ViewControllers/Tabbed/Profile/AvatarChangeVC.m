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

@property (nonatomic, strong) UIImage *pickedAvatar;
@property (nonatomic, strong) UIImagePickerController *pickerController;


@end

@implementation AvatarChangeVC

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor colorWithDisplayP3Red:55/255 green:55/255 blue:55/255 alpha:0.7];
    [self setupUI];
    [self setupImagePicker];
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

- (void)setupImagePicker {
    self.pickerController = [UIImagePickerController new];
    self.pickerController.delegate = self;
    self.pickerController.allowsEditing = YES;
    self.pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *pickedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.pickedAvatar = pickedImage;
    self.avatarView.image = pickedImage;
    [self.pickerController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)uploadNew:(id)sender {
    [self presentViewController:self.pickerController animated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    //save the avatar
    
    Session *appSession = [Session sharedSession];
    [RealmUtils changeAvatarForUser:appSession.currentUser newAvatar:UIImagePNGRepresentation(self.pickedAvatar)];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.dashboarDelegate refreshTableView];
}

@end
