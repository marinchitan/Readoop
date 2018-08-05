//
//  UsersBooks.m
//  Readoop
//
//  Created by Marin Chitan on 18/07/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "UsersBooks.h"
#import "BookCell.h"
#import "Book.h"
#import "Font.h"
#import <Realm.h>

@interface UsersBooks ()

@property (nonatomic, strong) RLMArray *dataSource;

@end

@implementation UsersBooks

- (void)viewDidLoad {
    self.backButtonEnabled = YES;
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 140;
    
    [self fetchDataSource];
    UINib *nib = [UINib nibWithNibName:@"BookCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"bookCell"];
}

- (void)fetchDataSource {
    RLMArray *usersBooks = self.currentUser.books;
    self.dataSource = usersBooks;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Book *currentBook = self.dataSource[indexPath.row];
    
    BookCell *bookcell = [self.tableView dequeueReusableCellWithIdentifier:@"bookCell"];
    [bookcell setupCellWithModel:currentBook];
    bookcell.navController = self.navigationController;
    bookcell.selectionStyle = UITableViewCellSelectionStyleNone;
    return bookcell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSString *text = @"No books";
    
    
    NSDictionary *attributes = @{NSFontAttributeName: [Font getBariolwithSize:30],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"This user currently has no books in his collection";
   
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [Font getBariolwithSize:20],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}


@end
