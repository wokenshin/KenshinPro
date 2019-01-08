//
//  DetailViewController.m
//  Presidents
//
//  Created by apple on 2019/1/4.
//  Copyright © 2019 kenshin. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation DetailViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.languageBtn = [[UIBarButtonItem alloc] initWithTitle:@"Choose Language"
                                                        style:UIBarButtonItemStyleBordered//过时Style
                                                       target:self
                                                       action:@selector(toggleLanguagePopovew)];
    
    self.navigationItem.rightBarButtonItem = self.languageBtn;
}

- (void)toggleLanguagePopovew{
    if (self.languagePopVC == nil) {
        LanguageListVC *listVC = [[LanguageListVC alloc] init];
        listVC.detailVC = self;
        UIPopoverController *poc = [[UIPopoverController alloc] initWithContentViewController:listVC];
        [poc presentPopoverFromBarButtonItem:self.languageBtn
                    permittedArrowDirections:UIPopoverArrowDirectionAny
                                    animated:YES];
        self.languagePopVC = poc;
    } else {
        if (self.languagePopVC != nil) {
            [self.languagePopVC dismissPopoverAnimated:YES];
            self.languagePopVC = nil;
        }
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
    if (popoverController == self.languagePopVC) {
        self.languagePopVC = nil;
    }
}

#pragma mark - Managing the detail item
//方法
- (void)setDetailItem:(NSString *)strUrl {
    
    //应该是和生命周期有关 这里延迟执行 webView 才不是nil
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSURL *url = [NSURL URLWithString:strUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self->_webView loadRequest:request];
        self -> _detailItem = modifyUrlForLanguage(strUrl, self -> _languageString);
    });
    
}

//函数
static NSString *modifyUrlForLanguage(NSString *url, NSString *lang){
    if (!lang) {
        return url;
    }
    
    //下面的代码很脆弱，因为它依赖于特定的维基百科URL格式
    NSRange codeRange = NSMakeRange(7, 2);
    if ([[url substringWithRange:codeRange] isEqualToString:lang]) {
        return url;
    } else {
        NSString *newUrl = [url stringByReplacingCharactersInRange:codeRange withString:lang];
        return newUrl;
    }
    
}

- (void)setLanguageString:(NSString *)newString{
    if (![newString isEqualToString:self.languageString]) {
        _languageString = [newString copy];
        self.detailItem = modifyUrlForLanguage(_detailItem, self.languageString);
    }
    if (self.languagePopVC != nil) {
        [self.languagePopVC dismissPopoverAnimated:YES];
        self.languagePopVC = nil;
    }
}

@end
