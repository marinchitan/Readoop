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
#import <ReactiveObjC/ReactiveObjC.h>
#import "RealmUtils.h"

@interface BookDetailsVC ()

@property (assign, nonatomic) BOOL alreadyHasCurrentBook;

@end

@implementation BookDetailsVC

- (void)viewDidLoad {
    self.backButtonEnabled = YES;
    [super viewDidLoad];
    self.alreadyHasCurrentBook = [RealmUtils user:self.appSession.currentUser hasBook:self.currentBook];
    [self setupUI];
    [self setUpVCWithBookData];
    [self initialRateCheck];
}

- (void)setupUI {
   
    [ViewUtils setUpButton:self.cancelButton withRadius:5.0];
    [ViewUtils setUpButton:self.addToMyBooksButton withRadius:5.0];
    [ViewUtils setUpCancelActiveBUtton:self.cancelButton];
    [ViewUtils setUpStandardActiveButton:self.addToMyBooksButton];
    [ViewUtils setUpButton:self.rateButton withRadius:7.0];
    [ViewUtils setUpStandardActiveButton:self.rateButton];
    
    [self initialSliderUISetup:[self getInitialSliderColor]];
    
    self.titleContents.textColor = [Color getSubTitleGray];
    self.authorContents.textColor = [Color getSubTitleGray];
    self.publisherContents.textColor = [Color getSubTitleGray];
    self.yearContents.textColor = [Color getSubTitleGray];
    self.pagesContents.textColor = [Color getSubTitleGray];
    self.avgRatingContents.textColor = [Color getSubTitleGray];
    self.yourRatingContenes.textColor = [Color getSubTitleGray];
    
    
    RAC(self.sliderValue, textColor) = [[self.ratingSlider rac_signalForControlEvents:UIControlEventValueChanged] map:^id _Nullable(id _Nullable value) {
        if(((UISlider*)value).value < 2) {
            return [Color getBariolRed];
        } else if(((UISlider*)value).value > 4) {
            return [Color getValidGreen];
        } else {
            return [Color getNeutralYellow];
        }
    }];
    
    RAC(self.ratingSlider, minimumTrackTintColor) = [[self.ratingSlider rac_signalForControlEvents:UIControlEventValueChanged] map:^id _Nullable(id _Nullable value) {
        if(((UISlider*)value).value < 2) {
            return [Color getBariolRed];
        } else if(((UISlider*)value).value > 4) {
            return [Color getValidGreen];
        } else {
            return [Color getNeutralYellow];
        }
    }];
    
    RAC(self.rateButton, backgroundColor) = [[self.ratingSlider rac_signalForControlEvents:UIControlEventValueChanged] map:^id _Nullable(id _Nullable value) {
        if(((UISlider*)value).value < 2) {
            return [Color getBariolRed];
        } else if(((UISlider*)value).value > 4) {
            return [Color getValidGreen];
        } else {
            return [Color getNeutralYellow];
        }
    }];
    
    [self actionButtonCheck];
}

- (void)actionButtonCheck {
    if(self.alreadyHasCurrentBook){
        [self.addToMyBooksButton setTitle:@"Remove book" forState:UIControlStateNormal];
        [self.addToMyBooksButton setTitle:@"Remove book" forState:UIControlStateFocused];
    } else {
        [self.addToMyBooksButton setTitle:@"Add to my books" forState:UIControlStateNormal];
        [self.addToMyBooksButton setTitle:@"Add to my books" forState:UIControlStateFocused];
    }
}

- (void)initialSliderUISetup:(UIColor*)color {
    self.sliderValue.text = [NSString stringWithFormat:@"%1.1f",self.ratingSlider.value];
    self.sliderValue.textColor = color;
    self.ratingSlider.minimumTrackTintColor = color;
    self.rateButton.backgroundColor = color;
}

- (UIColor*)getInitialSliderColor {
    float yourInitialRating = [[self getYourRating] floatValue];
    if(yourInitialRating < 2){
        return [Color getBariolRed];
    } else if (yourInitialRating > 4) {
        return [Color getValidGreen];
    } else {
        return [Color getNeutralYellow];
    }
}

- (void)initialRateCheck {
    self.ratingSlider.value = [RealmUtils getInitialRatingForBook:self.currentBook forUser:self.appSession.currentUser];
    self.sliderValue.text = [NSString stringWithFormat:@"%1.1f", self.ratingSlider.value];
}

- (void)setUpVCWithBook:(Book*)book {
    self.currentBook = book;
}

- (void)setUpVCWithBookData {
    self.titleContents.text = self.currentBook.bookTitle;
    self.authorContents.text = self.currentBook.bookAuthor;
    self.publisherContents.text = self.currentBook.bookPublisher;
    self.yearContents.text = self.currentBook.bookPublishedYear;
    self.pagesContents.text = [NSString stringWithFormat:@"%@",self.currentBook.pages];
    
    if(!self.currentBook.bookPublisher || [self.currentBook.bookPublisher isEqualToString:@""]) {
        self.publisherContents.text = @" - ";
    }
    
    if(!self.currentBook.bookPublishedYear || [self.currentBook.bookPublishedYear isEqualToString:@""]) {
        self.yearContents.text = @" - ";
    }
    
    self.avgRatingContents.text = [self getAverageRating];
    self.yourRatingContenes.text = [self getYourRating];
}

- (NSString*)getAverageRating {
    return [RealmUtils getAvgRatingOfBook:self.currentBook];
}

- (NSString*)getYourRating {
    return [RealmUtils getRatingOfUser:self.appSession.currentUser ofBook:self.currentBook];
    
}

- (IBAction)rateTap:(id)sender {
    [RealmUtils setRatingForBook:self.currentBook rating:self.ratingSlider.value byUser:self.appSession.currentUser];
    self.yourRatingContenes.text = [NSString stringWithFormat:@"%1.1f",self.ratingSlider.value];
    self.avgRatingContents.text = [self getAverageRating];
}

- (IBAction)addToMyBooks:(id)sender {
    if(self.alreadyHasCurrentBook) {//already has book action = remove book
        [RealmUtils removeBook:self.currentBook fromUser:self.appSession.currentUser];
        self.alreadyHasCurrentBook = NO;
        [self actionButtonCheck];
    } else { //doesn't have book in colleciton action = add book
        [RealmUtils addBook:self.currentBook toUser:self.appSession.currentUser];
        self.alreadyHasCurrentBook = YES;
        [self actionButtonCheck];
    }
}

- (IBAction)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)sliderChanged:(id)sender {
    self.sliderValue.text = [NSString stringWithFormat:@"%1.1f",self.ratingSlider.value];
}

@end
