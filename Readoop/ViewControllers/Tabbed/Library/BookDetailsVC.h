//
//  BookDetailsVC.h
//  Readoop
//
//  Created by Marin Chitan on 19/05/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContainerViewController.h"
#import "Book.h"

@interface BookDetailsVC : ContainerViewController

@property (nonatomic, strong) Book* currentBook;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleContents;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorContents;
@property (weak, nonatomic) IBOutlet UILabel *publisherLabel;
@property (weak, nonatomic) IBOutlet UILabel *publisherContents;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearContents;
@property (weak, nonatomic) IBOutlet UILabel *pagesLabel;
@property (weak, nonatomic) IBOutlet UILabel *pagesContents;
@property (weak, nonatomic) IBOutlet UILabel *avgRatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *avgRatingContents;
@property (weak, nonatomic) IBOutlet UILabel *yourRatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *yourRatingContenes;
@property (weak, nonatomic) IBOutlet UISlider *ratingSlider;
@property (weak, nonatomic) IBOutlet UIButton *rateButton;

@property (weak, nonatomic) IBOutlet UIButton *addToMyBooksButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (weak, nonatomic) IBOutlet UILabel *sliderValue;

- (void)setUpVCWithBook:(Book*)book;

@end
