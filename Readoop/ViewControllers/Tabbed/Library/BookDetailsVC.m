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
#import "AlertUtils.h"

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
    
    float yourInitialRating;
    if([[self getYourRating] isEqualToString:@" - "]){//didn't had an rating set yet
        yourInitialRating = 2.5;
    } else {//get your rating
        yourInitialRating = [[self getYourRating] floatValue];
    }
    NSLog(@"Your rating: %@", [self getYourRating]);
    
    
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
    if([self.currentBook.imageWithURL isEqualToString:@""]) {
        self.coverImageView.image = [UIImage imageNamed:self.currentBook.imageName];
    } else {
        self.coverImageView.image = [UIImage imageWithData:self.currentBook.coverImage];
    }
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
        [AlertUtils showInformation:@"Are you sure you want to remove this book from your collection?"
                          withTitle:@"Remove from collection"
                   withActionButton:@"Remove"
                   withCancelButton:@"Cancel"
                         withAction:^{
                             [RealmUtils removeBook:self.currentBook fromUser:self.appSession.currentUser];
                             [self.delegate reloadData];
                             [self.navigationController popViewControllerAnimated:YES];
                         }
                               onVC:self];
    } else { //doesn't have book in colleciton action = add book
        [AlertUtils showInformation:@"Are you sure you want to add this book to your collection?"
                          withTitle:@"Add to collection"
                   withActionButton:@"Add"
                   withCancelButton:@"Cancel"
                         withAction:^{
                             [RealmUtils addBook:self.currentBook toUser:self.appSession.currentUser];
                             [self.delegate reloadData];
                             [self.navigationController popViewControllerAnimated:YES];
                         }
                               onVC:self];
    }
}

- (IBAction)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)sliderChanged:(id)sender {
    self.sliderValue.text = [NSString stringWithFormat:@"%1.1f",self.ratingSlider.value];
}

@end
