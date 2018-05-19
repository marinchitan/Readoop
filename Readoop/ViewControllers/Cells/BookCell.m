//
//  BookCell.m
//  Readoop
//
//  Created by Marin Chitan on 13/05/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "BookCell.h"
#import "Color.h"
#import "Book.h"

@implementation BookCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupUI];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setupUI{
    self.separatorView.backgroundColor = [Color getUltraLightGray];
    self.authorLabel.textColor = [Color getSubTitleGray];
    self.titleLabel.textColor = [Color getSubTitleGray];
    self.publisherLabel.textColor = [Color getSubTitleGray];
    self.pagesLabel.textColor = [Color getSubTitleGray];
    self.ratingLabel.textColor = [Color getSubTitleGray];
    
    //Setup image placeholder for book
    self.bookImage.image = [UIImage imageNamed:@"defaultLoadBook"];
    //self.bookImage.image = [UIImage animatedImageNamed:@"frame-" duration:2.0];
}

- (void)setupCellWithModel:(Book*)book {
    self.currentBook = book;
    self.authorContents.text = book.bookAuthor;
    self.titleContents.text = book.bookTitle;
    self.pagesContents.text = [NSString stringWithFormat:@"%@",book.pages];
    self.ratingContents.text = @"-"; //TODO: implement
    
    //Fire async call to load from url
    
    /*
     NSString *imageUrl = @"http://www.foo.com/myImage.jpg";
     [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
     myImageView.image = [UIImage imageWithData:data];
     }];*/
}

- (IBAction)tapAction:(id)sender {

}

@end
