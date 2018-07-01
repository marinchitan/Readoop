//
//  WritingDetailsVC.m
//  Readoop
//
//  Created by Marin Chitan on 19/05/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "WritingDetailsVC.h"
#import "Essentials.h"
#import "User.h"

@interface WritingDetailsVC ()

@property (nonatomic, assign) BOOL alreadyBoughtThisWriting;
@property (nonatomic, assign) BOOL isTheAuthorOfTHewriting;



@end

@implementation WritingDetailsVC

- (void)viewDidLoad {
    self.backButtonEnabled = YES;
    [super viewDidLoad];
    
    
    [self setupInitialFlags];
    [self setupUI];
    [self setupVCWithWritingData];
}

- (void)setupInitialFlags {
    
}

- (void)setupUI {
    
    [ViewUtils setUpButton:self.buyButton withRadius:5.0];
    [ViewUtils setUpButton:self.cancelButton withRadius:5.0];
    [ViewUtils setUpCancelActiveBUtton:self.cancelButton];
    [ViewUtils setUpStandardActiveButton:self.buyButton];

    self.titleContents.textColor = [Color getSubTitleGray];
    self.authorContents.textColor = [Color getSubTitleGray];
    self.descriptionContents.textColor = [Color getSubTitleGray];
    
    
    
    
    //use raccommand for buy button
}

- (void)setupVCWithWritingData {
    self.titleContents.text = self.currentWriting.writingTitle;
    User *user = [RealmUtils getUserById:self.currentWriting.authorId];
    self.authorContents.text = [user.fullName isEqualToString:@""] ? user.username : user.fullName;
    self.descriptionContents.text = self.currentWriting.writingDescription;
    self.avatarImageView.image = [UIImage imageWithData:user.avatar];
    self.priceContents.text = [NSString stringWithFormat:@"%@ €",self.currentWriting.writingPrice];
    
    self.avatarImageView.clipsToBounds = YES;
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.width / 2;
}

- (void)setupVCwithWriting:(Writing*)writing {
    self.currentWriting = writing;
}

- (IBAction)buyAction:(id)sender {
    [AlertUtils showInformation:@"Are you sure you want to buy this writing?"
                      withTitle:@"Buy writing"
               withActionButton:@"Buy"
               withCancelButton:@"Cancel"
                     withAction:^{
                         //[RealmUtils addBook:self.currentBook toUser:self.appSession.currentUser];
                         [self.delegate reloadData];
                         [self.navigationController popViewControllerAnimated:YES];
                     }
                           onVC:self];
}

- (IBAction)cancelAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
