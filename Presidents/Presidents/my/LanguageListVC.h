//
//  LanguageListVC.h
//  Presidents
//
//  Created by apple on 2019/1/7.
//  Copyright © 2019 kenshin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DetailViewController;
@interface LanguageListVC : UITableViewController

//注意 这里使用了 weak 必须这样做才能避免【保留连环】
@property (nonatomic, weak) DetailViewController  *detailVC;

@property (nonatomic, strong) NSArray               *languageNames;
@property (nonatomic, strong) NSArray               *languageCodes;

@end

NS_ASSUME_NONNULL_END
