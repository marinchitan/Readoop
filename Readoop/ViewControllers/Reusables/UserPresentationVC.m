//
//  UserPresentationVC.m
//  Readoop
//
//  Created by Marin Chitan on 17/04/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "UserPresentationVC.h"
#import "Essentials.h"
#import "Request.h"
#import "AlertUtils.h"

@interface UserPresentationVC ()

@end

@implementation UserPresentationVC

- (void)viewDidLoad {
    self.backButtonEnabled = YES;
    [super viewDidLoad];
    [self setupUI];
    [self populateDataWithUser:self.currentUser];
}

- (void)setupUI {
    [ViewUtils setUpButton:self.cancelButton withRadius:5.0];
    [ViewUtils setUpButton:self.addToFriendsButton withRadius:5.0];
    [ViewUtils setUpCancelActiveBUtton:self.cancelButton];
    [ViewUtils setUpStandardActiveButton:self.addToFriendsButton];

    self.userNameLabel.textColor = [Color getSubTitleGray];
    self.fullNameLabel.textColor = [Color getSubTitleGray];
    self.locaitonLabel.textColor = [Color getSubTitleGray];
    self.emailLabel.textColor = [Color getSubTitleGray];
    self.ageLabel.textColor = [Color getSubTitleGray];
    self.booksLabel.textColor = [Color getSubTitleGray];
    self.friendsLabel.textColor = [Color getSubTitleGray];
    
    self.userNameLabel.font = [Font getBariolwithSize:22];
    self.fullNameLabel.font = [Font getBariolwithSize:22];
    self.locaitonLabel.font = [Font getBariolwithSize:17];
    self.emailLabel.font = [Font getBariolwithSize:17];
    self.ageLabel.font = [Font getBariolwithSize:17];
    self.booksLabel.font = [Font getBariolwithSize:17];
    self.friendsLabel.font = [Font getBariolwithSize:17];
    
    self.userNameContent.textColor = [Color getPassiveTab];
    self.fullNameContent.textColor = [Color getPassiveTab];
    self.locationContent.textColor = [Color getPassiveTab];
    self.emailContent.textColor = [Color getPassiveTab];
    self.ageContent.textColor = [Color getPassiveTab];
    self.booksContent.textColor = [Color getPassiveTab];
    self.friendsContent.textColor = [Color getPassiveTab];
    
    self.userNameContent.font = [Font getBariolwithSize:22];
    self.fullNameContent.font = [Font getBariolwithSize:22];
    self.locationContent.font = [Font getBariolwithSize:17];
    self.emailContent.font = [Font getBariolwithSize:17];
    self.ageContent.font = [Font getBariolwithSize:17];
    self.booksContent.font = [Font getBariolwithSize:17];
    self.friendsContent.font = [Font getBariolwithSize:17];
    
    self.showBooksLabel.font = [Font getFAFont:14];
    self.showFriendsLabel.font = [Font getFAFont:14];
    self.showBooksLabel.text = [NSString stringWithFormat:@"%@%@",[NSString fontAwesomeIconStringForEnum:FAChevronRight],
                                [NSString fontAwesomeIconStringForEnum:FAChevronRight]];
    self.showFriendsLabel.text = [NSString stringWithFormat:@"%@%@",[NSString fontAwesomeIconStringForEnum:FAChevronRight],
                                  [NSString fontAwesomeIconStringForEnum:FAChevronRight]];
    self.showBooksLabel.textColor = [Color getPassiveTab];
    self.showFriendsLabel.textColor = [Color getPassiveTab];
    
    
    if(self.isOwnProfile) {
        [self.addToFriendsButton setTitle:@"Edit profie" forState:UIControlStateNormal];
        [self.addToFriendsButton setTitle:@"Edit profie" forState:UIControlStateFocused];
    }
    
    self.avatarView.clipsToBounds = YES;
    self.avatarView.layer.cornerRadius = self.avatarView.frame.size.width / 2;
}

- (void)populateDataWithUser:(User*)user {
    self.avatarView.image = [UIImage imageWithData:user.avatar];
    self.userNameContent.text = user.username;
    self.fullNameContent.text = user.fullName ? user.fullName : @" - ";
    self.emailContent.text = user.email ? user.email : @" - ";
    
    NSString *locationString = [NSString new];
    if(user.city && user.country){
        locationString = [NSString stringWithFormat:@"%@, %@", self.appSession.currentUser.city, self.appSession.currentUser.country];
    } else if(user.city) {
        locationString = user.city;
    } else if(user.country){
        locationString = user.country;
    } else {
        locationString = @" - ";
    }
    
    self.locationContent.text = locationString;
    
    NSString *ageString = [NSString new];
    if(user.dateOfBirth)
    {
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
        NSInteger currentYear = [components year];
        
        NSDateComponents *userComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:user.dateOfBirth];
        NSInteger userYear = [userComponents year];

        ageString = [NSString stringWithFormat:@"%tu",currentYear-userYear];
        self.ageContent.text = ageString;
    } else {
        self.ageContent.text = @" - ";
    }
    
    self.booksContent.text = [NSString stringWithFormat:@"%tu", [user.books count]];
    self.friendsContent.text = [NSString stringWithFormat:@"%tu", [user.friends count]];
}


- (IBAction)addToFriendsAction:(id)sender {
    //Check if is already friends
    if(self.isOwnProfile){ //Own profile, navigate to edit profile
        [self.navigationController popViewControllerAnimated:YES];
        [self.navigationController pushViewController:[ViewController getEditProfileVC] animated:YES];
    } else { //Other user profile, send request
    
        User *retrievedUser = self.currentUser;
        NSLog(@"Current user's page:%@   Current session user:%@", self.currentUser.userId, self.appSession.currentUser.userId);
    
        if([[self.appSession.currentUser.friends objectsWhere:@"username = %@", retrievedUser.username] firstObject]){
            //Alert already has in friends
            NSLog(@"Already has in friend list");
            [AlertUtils showInformation:@"You already have this user in your friend list ."
                              withTitle:@"Error"
                       withCancelButton:@"Got it"
                                   onVC:self];
            
            //Check if session user already sent a request to this user
        } else if([[Request objectsWhere:@"receiverId == %@ AND senderId == %@",retrievedUser.userId, self.appSession.currentUser.userId] firstObject]){
            [AlertUtils showInformation:@"You have already sent a friend request to this user."
                              withTitle:@"Error"
                       withCancelButton:@"Got it"
                                   onVC:self];
            
            //Check if session user already received a request to this user
        } else if([[Request objectsWhere:@"senderId == %@ AND receiverId == %@",retrievedUser.userId,self.appSession.currentUser.userId] firstObject]){
            [AlertUtils showInformation:@"This user already sent you a friend request."
                              withTitle:@"Error"
                       withCancelButton:@"Got it"
                                   onVC:self];
            
        } else {
            //Do request
            NSLog(@"Successful add");
            [AlertUtils showSuccess:@"Request sent!" withTitle:@"Success" withCancelButton:@"Got it" onVC:self];
            //MONGOPUT
            [RealmUtils createRequestfromUser:self.appSession.currentUser toUser:retrievedUser];
        }
        
    }
}

- (IBAction)cancelAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)showBooksAction:(id)sender {
}

- (IBAction)showFriendsAction:(id)sender {
}

@end
