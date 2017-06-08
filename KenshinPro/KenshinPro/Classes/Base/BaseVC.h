//
//  BaseVC.h
//  KenshinPro
//
//  Created by kenshin on 17/3/16.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FXW_Define.h"
#import "Tools.h"
#import "RegexUtil.h"
#import "ImageUtil.h"
#import "FXWUD.h"

//我的UI
#import "FXWUI.h"

//三方库
#import "Masonry.h"
#import "MDToast.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "MJExtension.h"
#import "MJRefresh.h"//table 上下拉 刷新

/**
 将最常用的功能集成到这里 比如 菊花、吐司等
 */
@interface BaseVC : UIViewController


/**
 初始化方法 可以让子类继承父类的xibVC

 @return VC实例
 */
- (instancetype)initWithNib;

/**
 定义一个代码块类型 类型为 void
 */
typedef void(^VoidBlock) ();


#pragma mark - 关闭软键盘
/**
 关闭软键盘[点击空白处时会触发该方法]
 */
- (void)closeKeyBoard;

#pragma mark - 获取指定的控制器 从控制器数组中

/**
 获取指定的控制器 从控制器数组中 【该方法可以用在pop到制定的vc时，也可以在pop时传值】

 @param vcClass 需要获取的控制器的Class
 @return 控制器实例，如果没有 返回 nil
 */
- (UIViewController *)getViewControllerWithClass:(Class)vcClass;

#pragma mark - 导航栏右边按钮
/**
 设置导航栏右边的按钮 以及点击回调
 
 @param imgName 按钮图片
 @param block   回调block
 */
- (void)setNavRightBtnWithImg:(NSString *)imgName
          andClickResultblock:(VoidBlock )block;


/**
 设置导航栏右边的按钮 以及点击回调
 
 @param btnName 按钮文本
 @param block   回调block
 */
- (void)setNavRightBtnWithName:(NSString *)btnName
          andClickResultblock:(VoidBlock )block;


/**
 设置导航栏右边的按钮 以及点击回调 可设置文本颜色
 
 @param btnName 按钮文本
 @param color 文本颜色
 @param block 回调block
 */
- (void)setNavRightBtnWithName:(NSString *)btnName
                andTitleColor:(UIColor *)color
          andClickResultblock:(VoidBlock )block;

#pragma mark - 导航栏左边按钮
/**
 设置导航栏左边的按钮 以及点击回调
 
 @param imgName 按钮图片
 @param block   回调block
 */
- (void)setNavLeftBtnWithImg:(NSString *)imgName
         andClickResultblock:(VoidBlock )block;

/**
 设置导航栏左边的按钮 以及点击回调
 
 @param btnName 按钮文本
 @param block   回调block
 */
- (void)setNavLeftBtnWithName:(NSString *)btnName
         andClickResultblock:(VoidBlock )block;

/**
 设置导航栏左边的按钮 以及点击回调 可设置文本颜色
 
 @param btnName 按钮文本
 @param color   文本颜色
 @param block   回调block
 */
- (void)setNavLeftBtnWithName:(NSString *)btnName
                andTitleColor:(UIColor *)color
          andClickResultblock:(VoidBlock )block;

#pragma mark - 吐司
/**
 * 吐司 中央显示
 */
- (void)toast:(NSString *)message;

/**
 *吐司 底部显示
 */
- (void)toastBottom:(NSString *)message;

#pragma mark - 菊花
/**
加载菊花    MBProgressHUD

@param message 内容
*/
-(void)showJuHua:(NSString *)message;

/**
 隐藏菊花   MBProgressHUD
 */
-(void)hideJuHua;

#pragma mark - 提示
/**
 错误提示 带X图标   MBProgressHUD MJ 包里面的方法
 
 @param message 内容
 */
-(void)showError:(NSString *)message;

/**
 提示信息 一行  MBProgressHUD
 
 @param msg 内容
 */
- (void)showMessage:(NSString *)msg;


/**
  提示信息 可多行  MBProgressHUD

 @param message 内容
 */
- (void)showMessageMLine:(NSString *)message;
#pragma mark 系统弹框
/**
 系统弹框 [好的]
 
 @param title   标题
 @param message 内容
 */
- (void)alertSystemTitle:(NSString *)title
                 message:(NSString *)message
                      OK:(VoidBlock)okBlock;

/**
 系统弹框 [确定 & 取消]
 
 @param title       标题
 @param message     内容
 @param okBlock     确定的回调
 @param cancelBlock 取消的回调
 */
- (void)alertSystemTitle:(NSString *)title
                 message:(NSString *)message
                      OK:(VoidBlock)okBlock
                  Cancel:(VoidBlock)cancelBlock;


typedef void (^PhoneNoBlock)(NSString *phoneNo);

#pragma mark - 通讯录 进入通讯录点击手机号 获取号码
/**
 通过查看系统通讯录 选择手机号码
 
 @param block 选择手机号码后的回调
 */
- (void)selectPhoneNoByContactsWithResultPhoneNo:(PhoneNoBlock)block;

#pragma mark - 发短信

typedef void (^MSMNoBlock)(BOOL sendSuccess);

/**
 发短信

 @param phoneNos    手机号码 数组
 @param title       标题 这个标题好像没有用
 @param content     短信内容
 @param block BOOL  是否发送成功
 */
- (void)sendMSMPhoneNos:(NSArray *)phoneNos
                 title:(NSString *)title
               content:(NSString *)content
           resultBlock:(MSMNoBlock)block;

#pragma mark - 打电话
/**
 拨号 会有系统弹框提示 是否呼叫 点击呼叫后出发

 @param no 拨号号码
 */
- (void)callNo:(NSString *)no;

@end
