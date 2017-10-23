//
//  FXW_DebugView.h
//  KenshinPro
//
//  Created by kenshin on 2017/10/20.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 应该具备的功能[目前还是个半成品 ]
 
 1.显示视图
 2.关闭视图
 3.查看日志
 4.清空日志
 5.调节透明度、修改大小[两指放大or缩小：没做这个]
 6.可以拖动视图[还没做 应该是用touch的代理来实现]
 
 */
@interface FXW_DebugView : UIView

@property (weak, nonatomic) IBOutlet UITextView *txtView;

- (void)fxw_show;

- (void)fxw_setMessage:(NSString *)message;

- (void)fxw_removeSelf;

@end
