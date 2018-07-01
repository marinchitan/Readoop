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
@property (nonatomic, assign) BOOL isTheAuthorOfTheWriting;



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
    self.alreadyBoughtThisWriting = [RealmUtils user:self.appSession.currentUser hasBoughtWriting:self.currentWriting];
    self.isTheAuthorOfTheWriting = [RealmUtils user:self.appSession.currentUser isAuthorOfWriting:self.currentWriting];
}

- (void)setupUI {
    
    [ViewUtils setUpButton:self.buyButton withRadius:5.0];
    [ViewUtils setUpButton:self.cancelButton withRadius:5.0];
    [ViewUtils setUpCancelActiveBUtton:self.cancelButton];
    [ViewUtils setUpStandardActiveButton:self.buyButton];

    self.titleContents.textColor = [Color getSubTitleGray];
    self.authorContents.textColor = [Color getSubTitleGray];
    self.descriptionContents.textColor = [Color getSubTitleGray];
    
    [self actionButtonCheck];
}

- (void)actionButtonCheck {
    if(self.alreadyBoughtThisWriting){
        [self.buyButton setTitle:@"Download writing" forState:UIControlStateNormal];
        [self.buyButton setTitle:@"Download writing" forState:UIControlStateFocused];
    } else if(self.isTheAuthorOfTheWriting) {
        [self.buyButton setTitle:@"Edit writing" forState:UIControlStateNormal];
        [self.buyButton setTitle:@"Edit writing" forState:UIControlStateFocused];
    } else {
        [self.buyButton setTitle:@"Buy writing" forState:UIControlStateNormal];
        [self.buyButton setTitle:@"Buy writing" forState:UIControlStateFocused];
    }
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
    if(self.alreadyBoughtThisWriting) {
        [AlertUtils showInformation:@"Are you sure you want to download this writing?"
                          withTitle:@"Download writing"
                   withActionButton:@"Download"
                   withCancelButton:@"Cancel"
                         withAction:^{
                             [self saveCurrentWritingToDevice];
                             [self.delegate reloadData];
                             [self.navigationController popViewControllerAnimated:YES];}
                               onVC:self];
    } else if(self.isTheAuthorOfTheWriting) {
        //Show the edit screen
    } else {
        [AlertUtils showInformation:@"Are you sure you want to buy this writing?"
                      withTitle:@"Buy writing"
               withActionButton:@"Buy"
               withCancelButton:@"Cancel"
                     withAction:^{
                         [RealmUtils addWriting:self.currentWriting toUser:self.appSession.currentUser];
                         [self.delegate reloadData];
                         [self.navigationController popViewControllerAnimated:YES];}
                           onVC:self];
    }
}

- (IBAction)cancelAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveCurrentWritingToDevice {
    NSData *writingData = self.currentWriting.writingContent;
    NSString *fileName = [NSString stringWithFormat:@"%@.pdf",self.currentWriting.writingTitle];
    NSString *path = [[self applicationDocumentsDirectory].path
                      stringByAppendingPathComponent:fileName];
    NSLog(@"Save writing to path:%@", path);
    
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager createFileAtPath:path contents:writingData attributes:nil];
}

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                   inDomains:NSUserDomainMask] lastObject];
}

@end

