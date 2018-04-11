//
//  FXW_Define.h
//  KenshinPro
//
//  Created by kenshin on 17/3/16.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import <Foundation/Foundation.h>

//意思是:只在debug的时候输出, release的时候不输出
#ifdef DEBUG
//输出 当前 类名 方法名 行数
#define KLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define KLog(...)
#endif

#define AppDel    ((AppDelegate *)[UIApplication sharedApplication].delegate)

//获取手机屏幕的宽、高
#define screenWidth  [[UIScreen mainScreen] bounds].size.width
#define screenHeight [[UIScreen mainScreen] bounds].size.height

//获取状态栏高度 20pt or 44pt
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

#ifdef DEBUG
#define FXWLog(...) NSLog(__VA_ARGS__)// 调试状态
#else
#define FXWLog(...)// 发布状态
#endif



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

//mqds 字体大小


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

//获取沙盒Document路径
#define PathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

//获取沙盒Cache路径
#define PathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

//通知
//发送通知
#define FXW_NOTIF_POST(n, o) [[NSNotificationCenter defaultCenter] postNotificationName:n object:o]
//订阅通知
#define FXW_NOTIF_ADD(n, f)  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(f) name:n object:nil]
//删除订阅
#define FXW_NOTIF_REMV(n)    [[NSNotificationCenter  defaultCenter] removeObserver:self name:n object:nil]



//三禾项目 贵州华尚高科         主色 蓝色
#define colorDdzmBlueNavBar     RGB2Color(17, 103, 172)
#define colorDdzmBlueBtn        RGB2Color(68, 140, 202)
#define colorDdzmBlueBackgroud  RGB2Color(68, 140, 202)
#define colorDdzmBlueButton     RGB2Color(13, 111, 183)
#define colorDdzmGrayTxt        RGB2Color(222, 223, 224)//灰色
#define colorDdzmLene           RGB2Color(230, 230, 230)
#define colorDdzmBtnHighlight   RGB2Color(225, 81, 73)//淡红
#define colorGraySearch         RGB2Color(250, 250, 250)
//16进制取色
#define HexColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


//锁匠端颜色
#define colorNavBarBlue     HexColor(0x0FB7DB)//导航栏颜色-天蓝色
#define colorTabBar_normal  HexColor(0x8F8B8B)//tabBar默认字色-灰色
#define colorBackground     HexColor(0xF4F4F4)//背景色-灰色
#define colorTextBlack      HexColor(0x333333)//黑色字
#define colorTextGray       HexColor(0x8F8B8B)//灰色字
#define colorTextOrange     HexColor(0xFF5000)//橘色字
#define colorLine           HexColor(0xD9D9D9)//分割线颜色-灰色
#define colorBtnOrange      HexColor(0xFF5000)//橘色按钮

//主色调
#define colorHomeBlue       HexColor(0x0FB7DB)//天蓝色
#define colorHomeOrange     HexColor(0xFF5000)//橘黄色

@interface FXW_Define : NSObject

@end
