//
//  LibraryVC.m
//  Readoop
//
//  Created by Marin Chitan on 01/05/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "LibraryVC.h"
#import "Essentials.h"
#import "LibraryTVCDataSource.h"
#import "BookModel.h"
#import "BookCell.h"
#import "WritingCell.h"
#import "ViewUtils.h"
#import "StatusManager.h"
#import "AddWritingVC.h"

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

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation LibraryVC

- (void)viewDidLoad {
    self.backButtonEnabled = NO;
    [super viewDidLoad];
    
    [self setupUI];
    [self initialFlagSetup];
    [self setUpTabs];
    [self fetchDataSource];
    [self setupFieldSignal];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 140;
}

- (void)viewWillAppear:(BOOL)animated {
    [self hideSearch]; //When entering VC hide search by default
    self.isSearchViewExpanded = NO;
    self.isSecondTabsViewExpanded = YES;
}

- (void)setupFieldSignal {
    RACSignal *fieldSignal = [self.searchField rac_textSignal];
    [fieldSignal subscribeNext:^(id  _Nullable x) {
        [self filterCurrentDataSource:x];
    }];
}

- (void)filterCurrentDataSource:(NSString*)wildCard {
    if([wildCard isEqualToString:@""]) {
        if(self.isLibraryEnabled && self.isAllBooksEnabled) {
            self.dataSource = [LibraryTVCDataSource getAllBooks];
        } else if(self.isLibraryEnabled && self.isMyBooksEnabled) {
            self.dataSource = [LibraryTVCDataSource getBooksForCurrentUser];
        } else if(self.isShopEnabled && self.isAllWritingsEnabled) {
            self.dataSource = [LibraryTVCDataSource getAllWritings];
        } else if(self.isShopEnabled && self.isMyWritingsEnabled) {
            self.dataSource = [LibraryTVCDataSource getWritingsForCurrentUser];
        }
    } else {//Filter data source
        if(self.isLibraryEnabled && self.isAllBooksEnabled) {
            self.dataSource = [LibraryTVCDataSource getAllBooksWithWildCard:wildCard];
        } else if(self.isLibraryEnabled && self.isMyBooksEnabled) {
            self.dataSource = [LibraryTVCDataSource getBooksForCurrentUserWithWildCard:wildCard];
        } else if(self.isShopEnabled && self.isAllWritingsEnabled) {
            self.dataSource = [LibraryTVCDataSource getAllWritingsWithWildCard:wildCard];
        } else if(self.isShopEnabled && self.isMyWritingsEnabled) {
            self.dataSource = [LibraryTVCDataSource getWritingsForCurrentUserWithWildCard:wildCard];
        }
    }
    
    [self.tableView reloadData];
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
    
    [self setupAddWritingButton];

    self.tableView.bounces = NO;
    self.tableView.separatorColor = [UIColor whiteColor];
    
    UINib *nib = [UINib nibWithNibName:@"BookCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"bookCell"];
    UINib *nib2 = [UINib nibWithNibName:@"WritingCell" bundle:nil];
    [self.tableView registerNib:nib2 forCellReuseIdentifier:@"writingCell"];
}

- (void)setupAddWritingButton {
    self.addNewWritingLabel.hidden = YES;
    self.addNewWritingButton.hidden = YES;
    [ViewUtils setUpIconLabel:self.addNewWritingLabel withSize:20];
    self.addNewWritingLabel.text = [NSString fontAwesomeIconStringForEnum:FAPlus];
    self.addNewWritingLabel.textColor = [UIColor whiteColor];
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
    
    if(!self.isSecondTabsViewExpanded){
        [self showSecondaryTab];
    }
    
    [self setUpTabs];
    [self fetchDataSource];
    
    [self hideAddWritingButton];
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
    
    if(!self.isSecondTabsViewExpanded){
        [self showSecondaryTab];
    }
    
    [self setUpTabs];
    [self fetchDataSource];
    
    [self showAddWritingButton];
}

- (IBAction)firstTabTap:(id)sender {
    if(self.isLibraryEnabled){ //Library secondary tabs
        self.isAllBooksEnabled = YES;
        self.isMyBooksEnabled = NO;
        self.isAllWritingsEnabled = NO;
        self.isMyWritingsEnabled = NO;
    } else {
        self.isAllBooksEnabled = NO;
        self.isMyBooksEnabled = NO;
        self.isAllWritingsEnabled = YES;
        self.isMyWritingsEnabled = NO;
    }
    
    [self setUpTabs];
    [self fetchDataSource];
}

- (IBAction)secondTabTap:(id)sender {
    if(self.isLibraryEnabled){ //Library secondary tabs
        self.isAllBooksEnabled = NO;
        self.isMyBooksEnabled = YES;
        self.isAllWritingsEnabled = NO;
        self.isMyWritingsEnabled = NO;
    } else {
        self.isAllBooksEnabled = NO;
        self.isMyBooksEnabled = NO;
        self.isAllWritingsEnabled = NO;
        self.isMyWritingsEnabled = YES;
    }
    
    [self setUpTabs];
    [self fetchDataSource];
}

- (void)fetchDataSource {
    //Get all data necessary according to flags
    self.dataSource = [NSArray new]; //clear dataSource
    if(self.isLibraryEnabled && self.isAllBooksEnabled) {//Get all books datasource
        self.dataSource = [LibraryTVCDataSource getAllBooks];
    } else if(self.isLibraryEnabled && self.isMyBooksEnabled) {
        self.dataSource = [LibraryTVCDataSource getBooksForCurrentUser];
    } else if(self.isShopEnabled && self.isAllWritingsEnabled) {
        self.dataSource = [LibraryTVCDataSource getAllWritings];
    } else if(self.isShopEnabled && self.isMyWritingsEnabled) {
        self.dataSource = [LibraryTVCDataSource getWritingsForCurrentUser];
    }
    
    [self.tableView reloadData];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    BookModel *currentModel = self.dataSource[indexPath.row];
    
    if([currentModel.reuseIdentifier isEqualToString:@"bookCell"]) { //Book cell
        BookCell *bookcell = [self.tableView dequeueReusableCellWithIdentifier:currentModel.reuseIdentifier];
        [bookcell setupCellWithModel:currentModel.object];
        bookcell.navController = self.navigationController;
        bookcell.delegate = self;
        bookcell.selectionStyle = UITableViewCellSelectionStyleNone;
        return bookcell;
        
    } else { //Writing cell
        WritingCell *writingcell = [self.tableView dequeueReusableCellWithIdentifier:currentModel.reuseIdentifier];
        [writingcell setupCellWithModel:currentModel.object];
        writingcell.delegate = self;
        writingcell.navController = self.navigationController;
        writingcell.selectionStyle = UITableViewCellSelectionStyleNone;
        return writingcell;
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSString *text = @"";
    if(self.isLibraryEnabled){
        text = @"No books";
    } else {
        text = @"No writings";
    }
    
    NSDictionary *attributes = @{NSFontAttributeName: [Font getBariolwithSize:30],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"";
    if(self.isLibraryEnabled){
        text = @"It seems like there are no books for your selection.";
    } else {
        text = @"It seems like there are no writings for your selection.";
    }
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [Font getBariolwithSize:20],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (void)reloadData {
    [self fetchDataSource];
    [self.tableView reloadData];
}

- (IBAction)addWritingAction:(id)sender {
    AddWritingVC *newWritingVC = [ViewController getAddWritingVC];
    newWritingVC.delegate = self;
    [self.navigationController pushViewController:newWritingVC animated:YES];
}

- (void)hideAddWritingButton {
    self.addNewWritingLabel.hidden = YES;
    self.addNewWritingButton.hidden = YES;
}

- (void)showAddWritingButton {
    if([StatusManager getStatusForUser:self.appSession.currentUser] != Beginner) { //if user is not Beginner he can add new writings
        self.addNewWritingLabel.hidden = NO;
        self.addNewWritingButton.hidden = NO;
    } else {
        self.addNewWritingLabel.hidden = YES;
        self.addNewWritingButton.hidden = YES;
    }
}

@end
