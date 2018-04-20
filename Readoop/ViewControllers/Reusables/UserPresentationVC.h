//
//  UserPresentationVC.h
//  Readoop
//
//  Created by Marin Chitan on 17/04/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContainerViewController.h"

@interface UserPresentationVC : ContainerViewController
@property (assign, nonatomic) BOOL isOwnProfile;

@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameContent;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fullNameContent;
@property (weak, nonatomic) IBOutlet UILabel *locaitonLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationContent;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailContent;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageContent;
@property (weak, nonatomic) IBOutlet UILabel *booksLabel;
@property (weak, nonatomic) IBOutlet UILabel *booksContent;
@property (weak, nonatomic) IBOutlet UILabel *showBooksLabel;
@property (weak, nonatomic) IBOutlet UIButton *showBooksButton;
@property (weak, nonatomic) IBOutlet UILabel *friendsLabel;
@property (weak, nonatomic) IBOutlet UILabel *friendsContent;
@property (weak, nonatomic) IBOutlet UILabel *showFriendsLabel;
@property (weak, nonatomic) IBOutlet UIButton *showFriendsButton;

@property (weak, nonatomic) IBOutlet UIButton *addToFriendsButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;


@end
