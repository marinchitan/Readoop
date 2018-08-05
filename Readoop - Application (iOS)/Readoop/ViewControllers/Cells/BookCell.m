//
//  BookCell.m
//  Readoop
//
//  Created by Marin Chitan on 13/05/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "BookCell.h"
#import "Color.h"
#import "Book.h"
#import "ViewController.h"
#import "BookDetailsVC.h"
#import "RealmUtils.h"

@implementation BookCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupUI];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setupUI{
    self.separatorView.backgroundColor = [Color getUltraLightGray];
    self.authorLabel.textColor = [Color getSubTitleGray];
    self.titleLabel.textColor = [Color getSubTitleGray];
    self.publisherLabel.textColor = [Color getSubTitleGray];
    self.pagesLabel.textColor = [Color getSubTitleGray];
    self.ratingLabel.textColor = [Color getSubTitleGray];
    self.bookImage.image = [UIImage imageNamed:@"defaultLoadBook"];

}

- (void)setupCellWithModel:(Book*)book {
    self.currentBook = book;
    self.authorContents.text = book.bookAuthor;
    self.titleContents.text = book.bookTitle;
    
    if([book.pages isEqualToString:@"(null)"]){
        self.pagesContents.text = @"-";
    } else {
        self.pagesContents.text = book.pages;
    }
    
    self.publisherContents.text = book.bookPublisher;
    
    self.ratingContents.text = [RealmUtils getAverageRatingOfBook:book]; 
    if([book.imageWithURL isEqualToString:@""]) {
        self.bookImage.image = [UIImage imageNamed:book.imageName];
    } else {
        self.bookImage.image = [UIImage imageWithData:book.coverImage];
    }

}

- (IBAction)tapAction:(id)sender {
    BookDetailsVC *bookDetailsVC = [ViewController getBookDetailsVC];
    [bookDetailsVC setUpVCWithBook:self.currentBook];
    bookDetailsVC.delegate = self.delegate;
    [self.navController pushViewController:bookDetailsVC animated:YES];
}

@end
