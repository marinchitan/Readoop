//
//  WritingCommentsVC.m
//  Readoop
//
//  Created by Marin Chitan on 04/07/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "WritingCommentsVC.h"
#import "Essentials.h"
#import "FeedPostCell.h"
#import "WritingComment.h"
#import "WritingCommentCell.h"

@interface WritingCommentsVC ()

@property (nonatomic, strong) RLMArray *dataSource;

@end

@implementation WritingCommentsVC

- (void)viewDidLoad {
    self.backButtonEnabled = YES;
    [super viewDidLoad];
    [self setupUI];
    [self fetchDataSource];
}

- (void)setupUI {
    self.commentTab.backgroundColor = [Color getBariolRed];
    
    self.commentTextView.autocorrectionType = UITextAutocorrectionTypeNo;
    self.commentTextView.layer.cornerRadius = self.initialCornerRadius;
    self.commentTextView.clipsToBounds = YES;
    
    self.commentButton.backgroundColor = [Color getFeedPostGray];
    [ViewUtils setUpButton:self.commentButton withRadius:self.initialCornerRadius];
    [self.commentButton setTitleColor:[Color getBlack] forState:UIControlStateNormal];
    [self.commentButton setTitleColor:[Color getBlack] forState:UIControlStateFocused];
    
    self.tableView.bounces = NO;
    self.tableView.separatorColor = [UIColor whiteColor];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80;
    
    UINib *nib = [UINib nibWithNibName:@"WritingCommentCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"writingCommentCell"];
}

- (void)fetchDataSource {
    self.dataSource = [[WritingComment objectsWhere:@"writingId == %@", self.currentWriting.writingId] sortedResultsUsingKeyPath:@"datePosted" ascending:NO];
    [self.tableView reloadData];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    WritingCommentCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"writingCommentCell"];
    
    [cell setupCellWithModel:self.dataSource[indexPath.row]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource count];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"No comments found";
    
    NSDictionary *attributes = @{NSFontAttributeName: [Font getBariolwithSize:30],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"It seems like there are no comments yet.";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [Font getBariolwithSize:20],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (IBAction)commentTap:(id)sender {
    if(![self.commentTextView.text isEqualToString:@""]){
        [RealmUtils createWritingCommentPostByUser:self.appSession.currentUser withContent:self.commentTextView.text forWriting:self.currentWriting];
        [self fetchDataSource];
        [self.tableView reloadData];
        self.commentTextView.text = @"";
    } else {
        [AlertUtils getInfoToastPanel:@"Empty post!" withMessage:@"Your input is empty."];
    }
}

@end
