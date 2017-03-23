//
//  FXW_Define.h
//  KenshinPro
//
//  Created by kenshin on 17/3/16.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define AppDel    ((AppDelegate *)[UIApplication sharedApplication].delegate)

//获取手机屏幕的宽、高
#define screenWidth  [[UIScreen mainScreen] bounds].size.width
#define screenHeight [[UIScreen mainScreen] bounds].size.height

//获取状态栏高度 貌似都是20
#define statusHeight [[UIApplication sharedApplication] statusBarFrame].size.height

//导航条高度 44
#define navBarHeight self.navigationController.navigationBar.frame.size.height


//各个手机型号的尺寸
#define screenWith4 320
#define screenHeight4 480

#define screenWith5 320
#define screenHeight5 568

#define screenWith6 375
#define screenHeight6 667

#define screenWith6p 414
#define screenHeight6p 736

//适配系数 适配所有手机 根据屏幕的宽度来做适配 UI的 frame参数都乘以这个系数就可以了  下面的参数是以6s的宽度来做适配的
#define coefficient (screenWidth/375.f)

//全部按钮的背景
#define imgBtnHighlighted [UIImage imageNamed:@"buddy_header_bg_highlighted"]

//normalHeight
#define height_normal 44
#define heightMText 40

//normalSize
#define size_normal 44

//开关 字体大小
#define switchFontSize [UIFont systemFontOfSize:14]

#define FontK(i) ([UIFont systemFontOfSize:i])

//母亲电商 字体大小


#define Font4      [UIFont fontWithName:@"Helvetica" size:11]
#define Font5      [UIFont fontWithName:@"Helvetica" size:12]
#define Font5h     [UIFont fontWithName:@"Helvetica" size:13]
#define Font6      [UIFont fontWithName:@"Helvetica" size:15]
#define Font6i     [UIFont fontWithName:@"Helvetica" size:14]
#define Font7      [UIFont fontWithName:@"Helvetica" size:16]

#define Font8      [UIFont fontWithName:@"Helvetica" size:17]

#define FontSearch [UIFont fontWithName:@"Helvetica" size:14]

#define Font6Bold  [UIFont fontWithName:@"Helvetica-Bold" size:16]

//支付页面的字体大小
#define FontPay [UIFont systemFontOfSize:14]

//weakSelf 定义一个self的弱引用  等同于 __weak typeof(self) weakSelf = self;
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//RBG转化为UIColor
#define RGB2Color(r,g,b) ([UIColor colorWithRed:(r * 1.0 /255) green:g * 1.0/255 blue:b * 1.0/255 alpha:1.0])
#define RGBA2Color(r,g,b,a) ([UIColor colorWithRed:(r * 1.0 /255) green:g * 1.0/255 blue:b * 1.0/255 alpha:a])

#define backgroundColor_VC RGB2Color(246, 246, 246)

//设备名称【如果你登录了apple账号 那这里的名称就是那个 而不是 iPhoneX】
#define iPhoneName ([UIDevice currentDevice].name)

//系统版本
#define SystemVersion ([UIDevice currentDevice].systemVersion)

//系统名称
#define SystemName ([UIDevice currentDevice].systemName)


//三禾项目 贵州华尚高科         主色 蓝色
#define colorBlueNavBar     RGB2Color(17, 103, 172)
#define colorBlueHome       RGB2Color(68, 140, 202)
#define colorBlueBackgroud  RGB2Color(68, 140, 202)
#define colorBlueButton     RGB2Color(13, 111, 183)
#define colorGrayTxt        RGB2Color(222, 223, 224)//灰色
#define colorLene           RGB2Color(230, 230, 230)
#define colorBtnHighlight   RGB2Color(225, 81, 73)//淡红

//16进制取色
#define UIColorFrom16(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface FXW_Define : NSObject

@end
