//
//  ProfileCell.m
//  Readoop
//
//  Created by Marin Chitan on 26/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "ProfileCell.h"
#import "Color.h"
#import "NSString+FontAwesome.h"
#import "Font.h"
#import "ChangePasswordVC.h"
#import "AdditionalInfoVC.h"
#import "EditProfileVC.h"
#import "AlertUtils.h"
#import "ViewController.h"
#import "RequestsTVC.h"

@implementation ProfileCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setupUI {
    self.separatorView.backgroundColor = [Color getUltraLightGray];
    self.icon.font = [Font getFAFont:20];
    self.icon.textColor = [Color getPassiveTab];
    self.chevron.font = [Font getFAFont:20];
    self.title.font = [Font getBariolwithSize:23];
    

    self.chevron.text = [NSString fontAwesomeIconStringForEnum:FAChevronRight];
    self.chevron.textColor = [Color getBariolRed];
}

- (void)setupCellWithModel:(CellModel *)model {
    self.model = model;
    
    self.title.text = self.model.title;
    [self setUpIcons];
}

- (void)setUpIcons {
    switch(self.model.cellSubType) { //The order of the titles
        case myBooksCell:
            self.icon.text = [NSString fontAwesomeIconStringForEnum:FABook];
            break;
        case myFriendsCell:
            self.icon.text = [NSString fontAwesomeIconStringForEnum:FAUsers];
            break;
        case requestsCell:
            self.icon.text = [NSString fontAwesomeIconStringForEnum:FAuserPlus];
            break;
        case editProfileCell:
            self.icon.text = [NSString fontAwesomeIconStringForEnum:FAPencil];
            break;
        case changePasswordCell:
            self.icon.text = [NSString fontAwesomeIconStringForEnum:FAUnlockAlt];
            break;
        case additionalInfoCell:
            self.icon.text = [NSString fontAwesomeIconStringForEnum:FAFile];
            break;
        case signOutCell:
            self.icon.text = [NSString fontAwesomeIconStringForEnum:FASignOut];
            break;
    }
 
}

- (IBAction)action:(id)sender {
    //The navigationController, tabController and currentVC is stored on model
    
    EditProfileVC *editProfileVC = [ViewController getEditProfileVC];
    ChangePasswordVC *chpsswVC = [ViewController getChangePasswVC];
    AdditionalInfoVC *addInfVC = [ViewController getAdditionalInfoVC];
    RequestsTVC *requestsTVC = [ViewController getRequestsTVC];
    switch(self.model.cellSubType) {
        case myBooksCell:
            NSLog(@"MyBooks Action clicked");
            break;
        case myFriendsCell:
            NSLog(@"MyFriends Action clicked");
            self.model.currentTab.selectedIndex = 2;
            break;
        case requestsCell:
            [self.model.currentNav pushViewController:requestsTVC animated:YES];
            break;
        case editProfileCell:
            [self.model.currentNav pushViewController:editProfileVC animated:YES];
            break;
        case changePasswordCell:
            [self.model.currentNav pushViewController:chpsswVC animated:YES];
            break;
        case additionalInfoCell:
            [self.model.currentNav pushViewController:addInfVC animated:YES];
            break;
        case signOutCell:
            [AlertUtils showInformation:@"Do you want to sign out?"
                              withTitle:@"Sign Out"
                       withActionButton:@"Yes"
                       withCancelButton:@"No"
                             withAction:^{[self.model.currentTab.navigationController popViewControllerAnimated:self.model.currentTab];}
                                   onVC:self.model.currentVC];
            break;
    }
}

@end
