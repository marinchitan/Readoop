//
//  PDFViewController.h
//  Readoop
//
//  Created by Marin Chitan on 01/07/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContainerViewController.h"

@interface PDFViewerVC : ContainerViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSString *filePath;
@end
