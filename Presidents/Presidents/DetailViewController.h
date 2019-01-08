//
//  DetailViewController.h
//  Presidents
//
//  Created by apple on 2019/1/4.
//  Copyright © 2019 kenshin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LanguageListVC.h"

@interface DetailViewController : UIViewController<UISplitViewControllerDelegate, UIPopoverControllerDelegate>

@property (nonatomic, strong) UIBarButtonItem *languageBtn;
@property (nonatomic, strong) UIPopoverController *languagePopVC;//在iOS9之后就不推荐使用了
@property (nonatomic, copy) NSString *languageString;

@property (nonatomic, copy) NSString *detailItem;
- (void)setDetailItem:(NSString *)urlStr;

@end

