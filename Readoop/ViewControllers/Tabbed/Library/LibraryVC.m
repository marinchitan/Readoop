//
//  LibraryVC.m
//  Readoop
//
//  Created by Marin Chitan on 01/05/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "LibraryVC.h"
#import "Essentials.h"

@interface LibraryVC ()
@property(nonatomic, assign) BOOL isSearchViewExpanded;
@property(nonatomic, assign) BOOL isSecondTabsViewExpanded;

@property (nonatomic, assign) BOOL isLibraryEnabled;
@property (nonatomic, assign) BOOL isShopEnabled;

//Flags for library
@property (nonatomic, assign) BOOL isAllBooksEnabled;
@property (nonatomic, assign) BOOL isMyBooksEnabled;
//Flags for shop
@property (nonatomic, assign) BOOL isAllWritingsEnabled;
@property (nonatomic, assign) BOOL isMyWritingsEnabled;

@end

@implementation LibraryVC

- (void)viewDidLoad {
    self.backButtonEnabled = NO;
    [super viewDidLoad];
    
    [self setupUI];
    [self initialFlagSetup];
    [self setUpTabs];
}

- (void)viewWillAppear:(BOOL)animated {
    [self hideSearch]; //When entering VC hide search by default
    self.isSearchViewExpanded = NO;
    self.isSecondTabsViewExpanded = YES;
}


- (void)setupUI {
    self.mainTabsView.backgroundColor = [Color getBariolRed];
    self.secondaryTabsView.backgroundColor = [Color getBariolRed];
    self.searchFieldView.backgroundColor = [Color getBariolRed];
    
    [ViewUtils setUpButton:self.libraryTab withRadius:self.initialCornerRadius];
    [ViewUtils setUpButton:self.shopTab withRadius:self.initialCornerRadius];
    [ViewUtils setUpButton:self.firstSecondaryTab withRadius:self.initialCornerRadius];
    [ViewUtils setUpButton:self.secondSecondaryTab withRadius:self.initialCornerRadius];
    
    [ViewUtils setUpIconLabel:self.searchExpandLabelFirst withSize:16];
    [ViewUtils setUpIconLabel:self.searchExpandLabelSecond withSize:22];
    [ViewUtils setUpIconLabel:self.secondaryTabExpandLabel withSize:22];
    
    self.searchExpandLabelFirst.text = [NSString fontAwesomeIconStringForEnum:FASearch];
    self.searchExpandLabelSecond.text = [NSString fontAwesomeIconStringForEnum:FAAngleDoubleUp];
    self.secondaryTabExpandLabel.text = [NSString fontAwesomeIconStringForEnum:FAAngleDoubleUp];
    self.searchExpandLabelFirst.textColor = [Color getWhite];
    self.searchExpandLabelSecond.textColor = [Color getWhite];
    self.secondaryTabExpandLabel.textColor = [Color getWhite];
}

- (void)initialFlagSetup {
    self.isLibraryEnabled = YES;
    self.isShopEnabled = NO;
    
    self.isAllBooksEnabled = YES;
    self.isMyBooksEnabled = NO;
    self.isAllWritingsEnabled = NO;
    self.isMyWritingsEnabled = NO;
}

- (IBAction)searchExpand:(id)sender {
    if(self.searchViewHeight.constant == 50){
        [self hideSearch];
    } else {
        [self showSearch];
    }
}

- (void)hideSearch {
    self.searchViewHeight.constant = 0;
    self.searchExpandLabelSecond.text = [NSString fontAwesomeIconStringForEnum:FAAngleDoubleDown];
    self.isSearchViewExpanded = NO;
}

- (void)showSearch {
    self.searchViewHeight.constant = 50;
    self.searchExpandLabelSecond.text = [NSString fontAwesomeIconStringForEnum:FAAngleDoubleUp];
    self.isSearchViewExpanded = YES;
}

- (IBAction)secondaryTabsExpand:(id)sender {
    if(self.secondaryTabsViewHeight.constant == 50){
        [self hideSecondaryTab];
    } else {
        [self showSecondaryTab];
    }
}

- (void)hideSecondaryTab {
    self.secondaryTabsViewHeight.constant = 0;
    self.secondaryTabExpandLabel.text = [NSString fontAwesomeIconStringForEnum:FAAngleDoubleDown];
    self.isSecondTabsViewExpanded = NO;
}

- (void)showSecondaryTab {
    self.secondaryTabsViewHeight.constant = 50;
    self.secondaryTabExpandLabel.text = [NSString fontAwesomeIconStringForEnum:FAAngleDoubleUp];
    self.isSecondTabsViewExpanded = YES;
}

- (void)setUpTabs {
    if(self.isLibraryEnabled){
        [self setupActiveTab:self.libraryTab];
        [self setupInActiveTab:self.shopTab];
        [self.firstSecondaryTab setTitle:@"All Books" forState:UIControlStateNormal];
        [self.firstSecondaryTab setTitle:@"All Books" forState:UIControlStateFocused];
        [self.secondSecondaryTab setTitle:@"My Books" forState:UIControlStateNormal];
        [self.secondSecondaryTab setTitle:@"My Books" forState:UIControlStateFocused];
    } else {
        [self setupActiveTab:self.shopTab];
        [self setupInActiveTab:self.libraryTab];
        [self.firstSecondaryTab setTitle:@"All Writings" forState:UIControlStateNormal];
        [self.firstSecondaryTab setTitle:@"All Writings" forState:UIControlStateFocused];
        [self.secondSecondaryTab setTitle:@"My Writings" forState:UIControlStateNormal];
        [self.secondSecondaryTab setTitle:@"My Writings" forState:UIControlStateFocused];
    }
    
    if(self.isAllWritingsEnabled || self.isAllBooksEnabled){
        [self setupActiveTab:self.firstSecondaryTab];
        [self setupInActiveTab:self.secondSecondaryTab];
    } else if(self.isMyWritingsEnabled || self.isMyBooksEnabled) {
        [self setupActiveTab:self.secondSecondaryTab];
        [self setupInActiveTab:self.firstSecondaryTab];
    }
    
    //BUG, FIXME: In Shop page tabs do not change position
    NSLog(@"isMyWr:%d", self.isMyWritingsEnabledboo)
}

- (void)setupActiveTab:(UIButton*)button {
    button.backgroundColor = [Color getWhite];
    button.layer.borderWidth = 1.0;
    button.layer.borderColor = [Color getWhite].CGColor;
    [button setTitleColor:[Color getBariolRed] forState:UIControlStateNormal];
    [button setTitleColor:[Color getBariolRed] forState:UIControlStateFocused];
}

- (void)setupInActiveTab:(UIButton*)button {
    button.backgroundColor = [Color getBariolRed];
    button.layer.borderWidth = 1.0;
    button.layer.borderColor = [Color getWhite].CGColor;
    [button setTitleColor:[Color getWhite] forState:UIControlStateNormal];
    [button setTitleColor:[Color getWhite] forState:UIControlStateFocused];
}

- (IBAction)libraryTap:(id)sender {
    //Reset Secondary tabs if needed, if user is on Shop Tab and taps on Library Tab
    //set first secondary tab selected
    if(!self.isLibraryEnabled){
        self.isAllBooksEnabled = YES;
        self.isMyBooksEnabled = NO;
        self.isAllWritingsEnabled = NO;
        self.isMyWritingsEnabled = NO;
    }
    
    self.isLibraryEnabled = YES;
    self.isShopEnabled = NO;
    
    [self setUpTabs];
}

- (IBAction)shopTap:(id)sender {
    //Reset Secondary tabs if needed, if user is on Library Tab and taps on Shop Tab
    //set first secondary tab selected
    if(!self.isShopEnabled){
        self.isAllBooksEnabled = NO;
        self.isMyBooksEnabled = NO;
        self.isAllWritingsEnabled = YES;
        self.isMyWritingsEnabled = NO;
    }
    
    self.isLibraryEnabled = NO;
    self.isShopEnabled = YES;
    [self setUpTabs];
}

- (IBAction)firstTabTap:(id)sender {
    if(self.isLibraryEnabled){ //Library secondary tabs
        if(self.isMyBooksEnabled){
            self.isMyBooksEnabled = NO;
            self.isAllBooksEnabled = YES;
            
            self.isMyWritingsEnabled = NO;
            self.isAllWritingsEnabled = NO;
        } else { //Shop secondary tabs
            self.isMyBooksEnabled = NO;
            self.isAllBooksEnabled = NO;
            
            self.isMyWritingsEnabled = NO;
            self.isAllWritingsEnabled = YES;
        }
    }
    
    [self setUpTabs];
}

- (IBAction)secondTabTap:(id)sender {
    if(self.isLibraryEnabled){ //Library secondary tabs
        if(self.isMyBooksEnabled){
            self.isMyBooksEnabled = YES;
            self.isAllBooksEnabled = NO;
            
            self.isMyWritingsEnabled = NO;
            self.isAllWritingsEnabled = NO;
        } else { //Shop secondary tabs
            self.isMyBooksEnabled = NO;
            self.isAllBooksEnabled = NO;
            
            self.isMyWritingsEnabled = YES;
            self.isAllWritingsEnabled = NO;
        }
    }
    
    [self setUpTabs];
}



@end
