//
//  AddWritingVC.m
//  Readoop
//
//  Created by Marin Chitan on 02/07/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "AddWritingVC.h"
#import "Color.h"
#import <Foundation/Foundation.h>
#import "Writing.h"
#import "RealmUtils.h"
#import "Essentials.h"

@interface AddWritingVC ()

@property (strong, nonatomic) NSData *currentFile;

@end

@implementation AddWritingVC

- (void)viewDidLoad {
    self.backButtonEnabled = YES;
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    [ViewUtils setUpButton:self.uploadButton withRadius:self.initialCornerRadius];
    [ViewUtils setUpButton:self.cancelButton withRadius:self.initialCornerRadius];
    [ViewUtils setUpButton:self.chooseFileButton withRadius:self.initialCornerRadius];
    [ViewUtils setUpCancelActiveBUtton:self.cancelButton];
    [ViewUtils setUpStandardActiveButton:self.uploadButton];
    self.chooseFileButton.backgroundColor = [Color getLightGray];

    [ViewUtils setUpField:self.titleField withRadius:self.initialCornerRadius];
    [ViewUtils setUpField:self.priceField withRadius:self.initialCornerRadius];
    [ViewUtils setUpTextView:self.descriptionTextView withRadius:self.initialCornerRadius];
}

- (IBAction)chooseFileAction:(id)sender {
    UIDocumentPickerViewController *documentPicker = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:@[@"public.data"]
                                                                                                            inMode:UIDocumentPickerModeImport];
    documentPicker.delegate = self;
    documentPicker.allowsMultipleSelection = NO;
    
    documentPicker.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:documentPicker animated:YES completion:nil];
}


- (IBAction)uploadAction:(id)sender {
    if(self.currentFile){
        [self addNewWritingWithValidaitons];
    } else {
        [AlertUtils showInformation:@"You must add a file first."
                          withTitle:@"No files"
                   withCancelButton:@"Got it"
                               onVC:self];
    }
}

- (IBAction)cancelAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray <NSURL *>*)urls {
    @weakify(self)
    NSURL *fileURL = urls[0];
    if([fileURL.absoluteString containsString:@".pdf"]){
        NSLog(@"URL string:%@", fileURL);
        NSData *fileData = [NSData dataWithContentsOfURL:fileURL];
        self.currentFile = fileData;
        self.fileNameLabel.text = [self getNameOfFile:fileURL];
        [self getNameOfFile:fileURL];
    } else {
        @strongify(self)
        [AlertUtils showInformation:@"Only PDF files are allowed."
                          withTitle:@"Wrong file format"
                   withCancelButton:@"Got it"
                               onVC:self];
    }
}

- (NSString *)getNameOfFile:(NSURL *)url {
    NSString *urlString = url.absoluteString;
    NSArray *subString = [urlString componentsSeparatedByString:@"/"];
    NSString *fileName = [subString lastObject];
    NSString *formattedFileName = [fileName stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
    return formattedFileName;
}

- (void)documentPickerWasCancelled:(UIDocumentPickerViewController *)controller {
    
}

- (void)addNewWritingWithValidaitons {
    if([self.titleField.text isEqualToString:@""]) {
        [AlertUtils showInformation:@"Supply a title for your writing."
                          withTitle:@"Incorrect input"
                   withCancelButton:@"Got it"
                               onVC:self];
    } else if([self.descriptionTextView.text isEqualToString:@""]) {
        [AlertUtils showInformation:@"Supply a description for your writing."
                          withTitle:@"Incorrect input"
                   withCancelButton:@"Got it"
                               onVC:self];
    } else if([self.priceField.text isEqualToString:@""]) {
        [AlertUtils showInformation:@"Supply a price for your writing."
                          withTitle:@"Incorrect input"
                   withCancelButton:@"Got it"
                               onVC:self];
    } else if([self.priceField.text rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].location == NSNotFound) {
        [AlertUtils showInformation:@"The price should be a numeric value."
                          withTitle:@"Incorrect input"
                   withCancelButton:@"Got it"
                               onVC:self];
    } else {
        Writing *newWriting = [Writing new];
        NSInteger maxprimaryKey = [[Writing allObjects] maxOfProperty:@"writingId"];
        newWriting.writingId = [NSNumber numberWithInteger:maxprimaryKey + 1];
        newWriting.authorId = self.appSession.currentUser.userId;
        newWriting.writingTitle = self.titleField.text;
        newWriting.writingDescription = self.descriptionTextView.text;
        NSInteger price = [self.priceField.text integerValue];
        newWriting.writingPrice = [NSNumber numberWithInteger:price];
        newWriting.writingContent = self.currentFile;
     
        [RealmUtils insertWriting:newWriting];
        [self.delegate reloadData];
    }
    
}

@end
