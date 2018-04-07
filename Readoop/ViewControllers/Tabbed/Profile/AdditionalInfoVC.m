//
//  AdditionalInfoVC.m
//  Readoop
//
//  Created by Marin Chitan on 06/04/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "AdditionalInfoVC.h"

@interface AdditionalInfoVC ()

@end

@implementation AdditionalInfoVC

- (void)viewDidLoad {
    self.backButtonEnabled = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.test.datePickerMode = UIDatePickerModeDate;
    self.test.date = [NSDate dateWithTimeIntervalSince1970:631200000];
    
}

@end
