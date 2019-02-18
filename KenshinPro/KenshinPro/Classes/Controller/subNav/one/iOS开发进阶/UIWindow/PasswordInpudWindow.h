//
//  PasswordInpudWindow.h
//  KenshinPro
//
//  Created by apple on 2019/2/12.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PasswordInpudWindow : UIWindow

+ (PasswordInpudWindow *)shareInstance;

- (void)show;

@end

NS_ASSUME_NONNULL_END
