//
//  WritingCell.m
//  Readoop
//
//  Created by Marin Chitan on 13/05/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "WritingCell.h"
#import "Color.h"

@implementation WritingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI {
    self.ratingLabel.textColor = [Color getSubTitleGray];
    self.priceLabel.textColor = [Color getSubTitleGray];
    self.titleLabel.textColor = [Color getSubTitleGray];
    self.authorLabel.textColor = [Color getSubTitleGray];
    self.separatorView.backgroundColor = [Color getUltraLightGray];
}

- (void)setupCellWithModel:(Writing*)writing {
    self.currentWriting = writing;
    self.ratingContents.text = @"-"; //implement rating calculator
    self.priceContents.text = [NSString stringWithFormat:@"%@ €",writing.writingPrice];
    self.priceContents.textColor = [Color getValidGreen];
    self.titleContents.text = writing.writingTitle;
    self.authorContents.text = writing.writingAuthor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)tapAction:(id)sender {
    
}

@end
