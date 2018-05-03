//
//  FXWMenuScrollView.h
//  KenshinPro
//
//  Created by apple on 2018/4/12.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelYY.h"

@interface FXWMenuScrollView : UIView


+ (FXWMenuScrollView *)fxw_menuWithFrame:(CGRect)frame andData:(NSArray<ModelYY*> *)arrData;


typedef void (^BlockFXWMenuScrollView)(ModelYY *model);

//点击事件回调
- (void)clickItem:(BlockFXWMenuScrollView)resultBlock;

@end
