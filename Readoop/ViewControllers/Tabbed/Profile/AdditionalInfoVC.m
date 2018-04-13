//
//  AdditionalInfoVC.m
//  Readoop
//
//  Created by Marin Chitan on 06/04/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "AdditionalInfoVC.h"
#import "Essentials.h"

@interface AdditionalInfoVC ()

@end

@implementation AdditionalInfoVC

- (void)viewDidLoad {
    self.backButtonEnabled = YES;
    [super viewDidLoad];
    
    
    [self setupUI];
    [self setupSignals];
    [self populateDataIfNeccessary];
}

- (void)populateDataIfNeccessary {
    NSString *currentCountry = self.appSession.currentUser.country;
    NSString *currentCity = self.appSession.currentUser.city;
    NSDate *currentDate = self.appSession.currentUser.dateOfBirth;
    
    if(currentCountry){
        self.countryField.text = currentCountry;
    }
    if(currentCity) {
        self.cityField.text = currentCity;
    }
    if(currentDate){
        self.datePicker.date = currentDate;
    }
    
    //In case the user want to only change the date he should not rely on the text signals
    self.doneButton.enabled = YES;
    self.doneButton.backgroundColor = [Color getBariolRed];
    
}

- (void)setupUI {
    [ViewUtils setUpField:self.cityField withRadius:self.initialCornerRadius];
    [ViewUtils setUpField:self.countryField withRadius:self.initialCornerRadius];
    
    [ViewUtils setUpButton:self.doneButton withRadius:self.initialCornerRadius];
    [ViewUtils setUpButton:self.cancelButton withRadius:self.initialCornerRadius];
    
    [ViewUtils setUpCancelActiveBUtton:self.cancelButton];
    [ViewUtils setUpStandardInactiveButton:self.doneButton];
    [self setupDatePicker];
}

- (void)setupSignals {
    RACSignal *countryTextSignal = [[self.countryField rac_textSignal] map:^id (NSString *value) {
        return @(value.length > 0);
    }];
    RACSignal *cityTextSignal = [[self.cityField rac_textSignal] map:^id (NSString *value) {
        return @(value.length > 0);
    }];
    
    RAC(self.doneButton, enabled) = [[RACSignal merge:@[countryTextSignal, cityTextSignal]] map:^id (NSNumber *value) {
                                        return @([value boolValue]);
    }];
    
    RAC(self.doneButton, backgroundColor) = [[RACSignal merge:@[countryTextSignal, cityTextSignal]] map:^id (NSNumber *value) {
                                                return [value boolValue] ? [Color getBariolRed] : [Color getPassiveBariolRed];
    }];
}

- (void)setupDatePicker {
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    self.datePicker.date = [NSDate dateWithTimeIntervalSince1970:631200000]; //1 Jan 1990
}

- (BOOL)validateCountrySpaces {
    NSRange whiteSpaceRange = [self.countryField.text rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];
    return whiteSpaceRange.location == NSNotFound ? YES : NO;
}

- (BOOL)validateCitySpaces {
    NSRange whiteSpaceRange = [self.cityField.text rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];
    return whiteSpaceRange.location == NSNotFound ? YES : NO;
}

- (BOOL)validateNoNum {
    return [self.countryField.text rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].location == NSNotFound &&
    [self.cityField.text rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].location == NSNotFound;;
}

- (IBAction)saveData:(id)sender {
    NSMutableString *errorString = [NSMutableString new];
    
    if(![self validateNoNum]) {
        [errorString appendString:[AppLabels getCountryNumError]];
        [errorString appendString:@"\n\n"];
    }
    
    if(![self validateCitySpaces]) {
        [errorString appendString:[AppLabels getSpaceError:@"City"]];
        [errorString appendString:@"\n\n"];
    }
    
    if(![self validateCountrySpaces]) {
        [errorString appendString:[AppLabels getSpaceError:@"Country"]];
        [errorString appendString:@"\n\n"];
    }
    
    __weak AdditionalInfoVC *weakSelf = self;
    if([errorString isEqualToString:@""]){
        //success
        //MONGOPUT
        [RealmUtils changeCountryForUser:self.appSession.currentUser newCountry:self.countryField.text];
        [RealmUtils changeCityForUser:self.appSession.currentUser newCity:self.cityField.text];
        [RealmUtils changeDateForUser:self.appSession.currentUser newDate:self.datePicker.date];
        
        [AlertUtils showSuccess:@"Data supplied"
                      withTitle:@"Success!"
               withActionButton:@"Ok"
                     withAction:^{[self.navigationController popViewControllerAnimated:YES];}
                           onVC:weakSelf];
    } else {
        //errors
        [AlertUtils showAlertModal:errorString
                         withTitle:@"Wrong data supplied"
                  withCancelButton:@"Got it!"
                              onVC:weakSelf];
    }
    
}

- (IBAction)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
