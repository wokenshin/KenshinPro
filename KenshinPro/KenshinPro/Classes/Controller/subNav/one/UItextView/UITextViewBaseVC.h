//
//  UITextViewBaseVC.h
//  KenshinPro
//
//  Created by apple on 2018/3/22.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import "BaseVC.h"

//通过点击按钮 删除 指定焦点处左边的第一个字符
@interface UITextViewBaseVC : UIViewController//这里不继承父vc 是因为 点击按钮的时候 事件还会传递到父vc 导致键盘关闭

@end
