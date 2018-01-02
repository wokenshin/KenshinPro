//
//  Tools.h
//  KenshinPro
//
//  Created by kenshin on 17/3/16.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FXW_Define.h"
#import "AppDelegate.h"
#import "sys/utsname.h"
#import <AVFoundation/AVFoundation.h>
#import "HDeviceIdentifier.h"//获取设备唯一标识
#import<SystemConfiguration/CaptiveNetwork.h>//获取自身连接的wify名称

@interface Tools : NSObject

//单例 demoCodes
+ (Tools *)shareTools;

//输出提示
+ (void)NSLogMyFunction:(NSString *)content;

//输出当前释放类 类名
+ (void)NSLogClassDestroy:(id)cuSelf;


/**
 设置圆角

 @param view 设置圆角的UI
 @param angle 圆角大小
 */
+ (void)setCornerRadiusWithView:(UIView *)view andAngle:(CGFloat)angle;

//同上
+ (void)setFilletWithView:(UIView *)view andAngle:(CGFloat)angle;

//设置边框
+ (void)setBorder:(UIView *)view andColor:(UIColor *)backColor andWeight:(CGFloat)weight;

//显示吐司
+ (void)toast:(NSString *)content andCuView:(UIView *)cuView;

//多行文本 demoCode
+ (UILabel *)manyLineLab:(NSString *)contents andTextFount:(UIFont *)font;

//错误提示[和吐司一样 只是多张图片]//暂时没实现 其实很简单
+ (void)toastImage:(NSString *)content andImgName:(NSString *)imgName andCuView:(UIView *)cuView;

//吐司 带高度
+ (void)toast:(NSString *)content andCuView:(UIView *)cuView andHeight:(CGFloat)height;

//弹出框
+ (void)alertDemoCode;

+ (void)TipsAlertWithTitle:(NSString *)title andContent:(NSString *)content andCu:(id)ws;

+ (void)UIAlertViewDemoCode;

//注册远程推送
+ (void)registerRemoteNotification;

//本地通知 demo
+ (void)localNotice;

//监测网络状况 AFN
+ (void)checkNetStatus;//建议将监听网络的行为 在AppDelegate 中执行

//简单动画[位移 渐变 旋转]
+ (void)animationDemoCode;

//旋转ui
+ (void)transformWithView:(UIView *)view andWithDegrees:(CGFloat)degrees;

//设备功能[禁止休眠, 靠近听筒休眠, 震动]
+ (void)deviceFunctionOfBalaBala;

//隐藏软键盘 demoCodes
+ (void)hiddenKeyboard;

//限制文本输入类型 demoCodes
+ (void)setTextFieldInputType;
/**
 *  计算文字尺寸
 *
 *  @param text    需要计算尺寸的文字
 *  @param font    文字的字体
 *  @param maxSize 文字的最大尺寸 注意此参数的用法 不然会影响返回值的大小
 */
//获取文本的size
+ (CGSize)sizeOfTheText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;

//获取文本的宽度
+ (CGFloat) widthWithTheText:(NSString *)text andFont:(UIFont *)font;

//定时器
+ (void)nstimerDemoCode;

#pragma mark - table
//默认选中某行cell 并滚动到该行
+(void)selectedCellWith:(UITableView *) table andIndex:(NSInteger)index andSection:(NSInteger)section;

//隐藏／显示 table滚动条
+ (void)setTableViewScrollBarVisible:(UITableView *)table scrollBarVisible:(BOOL)visible;

//隐藏tableview 分割线
+ (void)hiddenTableViewCellSeparateLine:(UITableView *)table;

//局部刷新 cell  或 分区
+ (void)juBuRefreshCellOrSectionDemoCodes;

#pragma mark - 导航控制器
//设置导航条样式
+ (void)setNavigationBarBackgroundColor:(UIColor *)backColor andTextColor:(UIColor *)textColor;

//添加导航栏按钮 demoCodes
+ (void)addNavigationBarButton;

//是否隐藏导航条
//+ (void)setNavgationBarHiddenDemoCodes;


#pragma mark - UIImageView
/**
 毛玻璃效果 分类来实现

 @param image 需要设置毛玻璃的图片
 @param value 模糊度 推荐设置为5 or 10
 @return 返回模糊化的图片
 */
+ (UIImage *)setMaoBoLi:(UIImage *)image andValue:(CGFloat )value;

//裁剪图片[获取图片顶部的内容]
+ (UIImage *)handleImage:(UIImage *)originalImage withCutSize:(CGSize)size;

//获取属性列表中的数据
+ (NSArray *)plistArrayTypeWithName:(NSString *)plistName;
+ (NSDictionary *)plistDicTypeWithName:(NSString *)plistName;

+ (NSString *)filePathWithDocuments:(NSString *)fileName;

//为视图添加手势 demoCodes
+ (void)setTapAction:(UIView *)tapView;

//获取随机数的代码
+ (void)randomNumDomoCodes;

#pragma mark - UIApplocation
//打电话
+ (void)tellPhoneWithNo:(NSString *)phoneNun;

//发短信 不管用
//+ (void)sendMessageWith:(NSString *)contents;

//发邮件
+ (void)sendEmailWith:(NSString *)emailAddress;

//打开网页
+ (void)openSafariWith:(NSString *)url;

//设置听筒模式
+ (void)setTingTongMode;

//设置扬声器模式
+ (void)setYangShengQiMode;

//设置 状态栏 是否可见
+ (void)setStaturBarHidden:(BOOL)hidden andIsAnimation:(BOOL)animation;

#pragma mark 获取缓存大小 demoCodes
+ (CGFloat)cachesSizeDemoCodes;

#pragma mark 清空缓存 demoCodes
+ (void)clearCachesDemoCodes;

#pragma mark 设置app通知数
+ (void)setAppNoticeNum:(NSInteger) noticesNum;

#pragma mark 清空app通知数
+ (void)clearAppAPNSNum;



#pragma mark - MC 项目中的方法
#pragma mark 加载头像 返回UIImage
+ (UIImage *)loadHeadImage;

//返回虚线view
/** 注意 view的高度就是虚线的高度
 
 ** lineView:	   需要绘制成虚线的view
 ** lineLength:	   虚线的宽度
 ** lineSpacing:   虚线的间距
 ** lineColor:	   虚线的颜色
 **/
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;

/**
 *讲json字符串转成字典
 */
+ (NSDictionary *)JsonStringToDictionaryWith:(NSString *)jsonString;

//自定义push
+ (void)pushCuVC:(UINavigationController *)cuNav toNextVC:(UIViewController *)nextVC andCuNetState:(BOOL)state;

//判断字符串是否为纯数字
//判断字符串是否是纯数字
+ (BOOL)isPureInt:(NSString *)string;

/*
 删除字符串两端的空格
 */
+ (NSString *)deleteSpaceStrHeadAndEnd:(NSString *)str;

/**
 * 获取唯一标识 UUID
 */
+ (NSString *)UUID;

/**
 * 获取栈顶控制器 就是获取当前app正在显示的那个控制器
 */
+ (UIViewController *)getCurrentShowVC;

//————————————————————————————————————————关于时间——————————————————————————————————————
/**
 * 将date转成long
 */
+ (long)longLongFromDate:(NSDate*)date;

/**
 * 传入long 返回 年:月:日
 */
+ (NSString *)longToStringYMD:(long)times;

//数组转Json字符串        Json字符串 转数组或字典
+ (NSString *)arrayToJsonStrWithArr:(NSArray *)arr;

+ (instancetype)jsonStrToArrOrDic:(NSString *)jsonStr;


/**
 获取当前手机连接wifi的名称
 
 @return 如果没有获取到的话返回nil
 */
+ (NSString *)getWifiName;

//获取设备型号 例如 iPhone6s
+ (NSString *)getDeviceName;

//判断当前传入的值是否为 nil 或者 null
+ (BOOL)isKongWithObj:(id)isKong;

- (void)swiftCallObjFunc;
+ (void)swiftCallClassFunc;

//获取沙盒路径
+ (NSString *)fxw_getPathDoc;
@end
