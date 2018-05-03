//
//  FXWMenuGridView.h
//  KenshinPro
//
//  Created by apple on 2018/4/11.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelItem.h"

@interface FXWMenuGridView : UIView



/**
 唯一初始化方法 返回表格视图

 @param arrModel 表格数据
 @param origin   xy坐标
 @return 表格视图，并返回视图的 frame「即传入的 xy和根据数据 生成的 width height」
 */
+ (FXWMenuGridView *)fxw_gridViewWithData:(NSArray<ModelItem*> *)arrModel point:(CGPoint)origin;

typedef void (^BlockFXWMenuGridView)(ModelItem *model);

//点击事件回调
- (void)clickItem:(BlockFXWMenuGridView)resultBlock;

@end
