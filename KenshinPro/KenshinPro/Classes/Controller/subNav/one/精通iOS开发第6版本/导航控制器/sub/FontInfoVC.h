//
//  FontInfoVC.h
//  KenshinPro
//
//  Created by apple on 2019/1/3.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FontInfoVC : UIViewController

@property (nonatomic, strong) UIFont *font;
@property (nonatomic, assign) BOOL   isFavorites;

@end

NS_ASSUME_NONNULL_END
