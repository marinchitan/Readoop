//
//  ProfilePresentationCell.m
//  Readoop
//
//  Created by Marin Chitan on 24/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "ProfilePresentationCell.h"
#import "Session.h"
#import "Font.h"
#import "Color.h"
#import "AvatarChangeVC.h"
#import "ViewController.h"

@implementation ProfilePresentationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)populateWithCurrenUserData {
    Session *appSession = [Session sharedSession];
    self.userImage.image = [UIImage imageWithData:appSession.currentUser.avatar];

    self.userImage.layer.cornerRadius = self.userImage.frame.size.width/2 ;
    self.userImage.clipsToBounds = YES;
    
    NSString *fullName = appSession.currentUser.fullName;
    NSString *username = appSession.currentUser.username;
    NSString *email = appSession.currentUser.email;
    NSString *location = @"";
    if(appSession.currentUser.city && appSession.currentUser.country ){
        location = [NSString stringWithFormat:@"%@, %@", appSession.currentUser.country, appSession.currentUser.city];
    } else if(!appSession.currentUser.city  && appSession.currentUser.country ){
        location = [NSString stringWithFormat:@"%@", appSession.currentUser.country];
    } else if(appSession.currentUser.city  && !appSession.currentUser.country) {
        location = [NSString stringWithFormat:@"%@", appSession.currentUser.city];
    } else {
        location = @" — ";
    }
    
    NSMutableAttributedString *formattedNameString = [[NSMutableAttributedString alloc]
                                                       initWithAttributedString: fullName.length > 0 ?
                                                                [[NSAttributedString alloc]
                                                                     initWithString:[NSString
                                                                                     stringWithFormat:@"%@ (%@)",fullName,username]] :
                                                                [[NSAttributedString alloc]
                                                                     initWithString:[NSString
                                                                                     stringWithFormat:@"%@",username]]]  ;

    [formattedNameString addAttribute:NSFontAttributeName
                                value:[Font getBariolwithSize:24]
                                range:NSMakeRange(0, formattedNameString.length)];
    
    if(fullName.length > 0){
        [formattedNameString addAttribute:NSForegroundColorAttributeName value:[Color getBlack] range:NSMakeRange(0, fullName.length)];
        [formattedNameString addAttribute:NSForegroundColorAttributeName value:[Color getSubTitleGray] range:NSMakeRange(fullName.length + 1, username.length + 2)];
    } else {
        [formattedNameString addAttribute:NSForegroundColorAttributeName value:[Color getBlack] range:NSMakeRange(0, formattedNameString.length)];
    }
    
    NSMutableAttributedString *formattedEmailString = [[NSMutableAttributedString alloc]
                                                       initWithAttributedString:email.length > 0 ?
                                                         [[NSAttributedString alloc]
                                                          initWithString:[NSString
                                                                          stringWithFormat:@"email: %@",email]] :
                                                         [[NSAttributedString alloc]
                                                          initWithString:[NSString
                                                                          stringWithFormat:@"email: — "]]];
    
    [formattedEmailString addAttribute:NSFontAttributeName
                                value:[Font getBariolwithSize:19]
                                range:NSMakeRange(0, formattedEmailString.length)];
    if(email.length >0) {
        [formattedEmailString addAttribute:NSForegroundColorAttributeName value:[Color getSubTitleGray] range:NSMakeRange(0, 6)];
        [formattedEmailString addAttribute:NSForegroundColorAttributeName value:[Color getBlack] range:NSMakeRange(6, email.length)];
    } else {
        [formattedEmailString addAttribute:NSForegroundColorAttributeName value:[Color getSubTitleGray] range:NSMakeRange(0,formattedEmailString.length)];
    
    }
    
    NSMutableAttributedString *formattedLocationString = [[NSMutableAttributedString alloc]
                                                   initWithAttributedString:location.length > 0 ?
                                                               [[NSAttributedString alloc]
                                                                initWithString:[NSString
                                                                                stringWithFormat:@"location: %@",location]] :
                                                               [[NSAttributedString alloc]
                                                                initWithString:[NSString
                                                                                stringWithFormat:@"location: —"]]];
    
    [formattedLocationString addAttribute:NSFontAttributeName
                                 value:[Font getBariolwithSize:19]
                                 range:NSMakeRange(0, formattedLocationString.length)];
    
    if(location.length > 0) {
        [formattedLocationString addAttribute:NSForegroundColorAttributeName value:[Color getSubTitleGray] range:NSMakeRange(0, 9)];
        [formattedLocationString addAttribute:NSForegroundColorAttributeName value:[Color getBlack] range:NSMakeRange(9, location.length)];
    } else {
        [formattedLocationString addAttribute:NSForegroundColorAttributeName value:[Color getSubTitleGray] range:NSMakeRange(0,formattedLocationString.length)];
    }
    
    self.fullNameLabel.attributedText = formattedNameString;
    self.email.attributedText = formattedEmailString;
    self.location.attributedText = formattedLocationString;
}

- (IBAction)avatarChange:(id)sender {
    AvatarChangeVC *avatarVC = [ViewController getAvatarChangeVC];
    avatarVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    avatarVC.dashboarDelegate = self.currentVC;
    [self.currentNavController presentViewController:avatarVC animated:YES completion:nil];
}

- (IBAction)showMyProfile:(id)sender {
    UserPresentationVC *userVC = [ViewController getUserPresentationVC];
    userVC.isOwnProfile = YES;
    [self.currentNavController pushViewController:userVC animated:YES];
}

@end
