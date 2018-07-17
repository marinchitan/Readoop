//
//  PDFViewController.m
//  Readoop
//
//  Created by Marin Chitan on 01/07/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "PDFViewerVC.h"

@interface PDFViewerVC ()

@end

@implementation PDFViewerVC

- (void)viewDidLoad {
    self.backButtonEnabled = YES;
    [super viewDidLoad];
    self.webView.scalesPageToFit = YES;
    [self loadFile];
}

- (void)loadFile {
    NSLog(@"Displaying file: %@", self.filePath);
    NSLog(@"File path: %@", self.filePath);
  
    NSURL *detailURL = [NSURL fileURLWithPath:self.filePath];
    NSURLRequest *request = [NSURLRequest requestWithURL:detailURL];
    [self.webView loadRequest:request];
}

@end
