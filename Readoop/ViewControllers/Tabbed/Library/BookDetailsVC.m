//
//  BookDetailsVC.m
//  Readoop
//
//  Created by Marin Chitan on 19/05/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "BookDetailsVC.h"
#import "Color.h"
#import "ViewUtils.h"

@interface BookDetailsVC ()

@property (assign, nonatomic) BOOL alreadyHasCurrentBook;

@end

@implementation BookDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButtonEnabled = YES;
    [self setupUI];
}

- (void)setupUI {
    [ViewUtils setUpButton:self.cancelButton withRadius:5.0];
    [ViewUtils setUpButton:self.addToMyBooksButton withRadius:5.0];
    [ViewUtils setUpCancelActiveBUtton:self.cancelButton];
    [ViewUtils setUpStandardActiveButton:self.addToMyBooksButton];
    
    self.titleContents.textColor = [Color getSubTitleGray];
    self.authorContents.textColor = [Color getSubTitleGray];
    self.publisherContents.textColor = [Color getSubTitleGray];
    self.yearContents.textColor = [Color getSubTitleGray];
    self.pagesContents.textColor = [Color getSubTitleGray];
    self.avgRatingContents.textColor = [Color getSubTitleGray];
    self.yourRatingContenes.textColor = [Color getSubTitleGray];
    
}

- (void)setUpVCWithBook:(Book*)book {
    self.currentBook = book;
    
}

- (IBAction)rateTap:(id)sender {
}

- (IBAction)addToMyBooks:(id)sender {
}

- (IBAction)cancel:(id)sender {
}

@end
