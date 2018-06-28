//
//  WritingDetailsVC.m
//  Readoop
//
//  Created by Marin Chitan on 19/05/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "WritingDetailsVC.h"
#import "Essentials.h"

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
   // [self setupWritingWithData];
}

- (void)setupInitialFlags {
    
}

- (IBAction)cancelTap:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupUI {
    
    [ViewUtils setUpButton:self.buyButton withRadius:5.0];
    [ViewUtils setUpButton:self.cancelButton withRadius:5.0];
    [ViewUtils setUpCancelActiveBUtton:self.cancelButton];
    [ViewUtils setUpStandardActiveButton:self.buyButton];

    self.titleContents.textColor = [Color getSubTitleGray];
    self.authorContents.textColor = [Color getSubTitleGray];
    self.authorUsernameContents.textColor = [Color getSubTitleGray];
    self.shortDescriptionContents.textColor = [Color getSubTitleGray];
    self.addedDateLabel.textColor = [Color getSubTitleGray];
    
    //use raccommand for buy button
}

- (void)setupWritingWithData {
}


@end
