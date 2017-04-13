//
//  AppDelegate.h
//
//  Created by MCL on 16/7/13.
//  Copyright © 2016年 CHLMA. All rights reserved.
/*
    logic：就是一个UIView + 一个VC，在上面添加了Table(LeftMenuTableView) 和一些别的控件
           结合代理 和手势 来实现的
 
 */

#import <UIKit/UIKit.h>

@protocol LeftMenuViewDelegate <NSObject>

- (void)LeftMenuViewActionIndex:(NSString *)vType;

- (void)leftMenuOpenFinished;

@end

@interface LeftMenuView : UIView

@property (nonatomic, assign) BOOL isLeftViewHidden;
@property (nonatomic, weak) id<LeftMenuViewDelegate> menuViewClickActionDelegate;

@property (nonatomic, strong) UILabel               *labPhoneNo;

+ (instancetype)ShareManager;

- (instancetype)initWithContainerViewController:(UIViewController *)containerVC;

- (void)openLeftView;

- (void)closeLeftView;

@end







/*
 //单例的实现
 static HLTestObject *instance = nil;
 + (instancetype)sharedInstance
 {
 return [[self alloc] init];
 }
 - (instancetype)init
 {
 static dispatch_once_t onceToken;
 dispatch_once(&onceToken, ^{
 instance = [super init];
 instance.height = 10;
 instance.object = [[NSObject alloc] init];
 instance.arrayM = [[NSMutableArray alloc] init];
 });
 return instance;
 }
 + (instancetype)allocWithZone:(struct _NSZone *)zone
 {
 static dispatch_once_t onceToken;
 dispatch_once(&onceToken, ^{
 instance = [super allocWithZone:zone];
 });
 return instance;
 }
 - (NSString *)description
 {
 NSString *result = @"";
 result = [result stringByAppendingFormat:@"<%@: %p>",[self class], self];
 result = [result stringByAppendingFormat:@" height = %d,",self.height];
 result = [result stringByAppendingFormat:@" arrayM = %p,",self.arrayM];
 result = [result stringByAppendingFormat:@" object = %p,",self.object];
 return result;
 }
 
 {
 LeftMenuView *objct1 = [LeftMenuView ShareManager];
 NSLog(@"----LeftMenuView1---- %@",objct1);
 LeftMenuView *objc2 = [[LeftMenuView alloc] init];
 NSLog(@"----LeftMenuView2---- %@",objc2);
 LeftMenuView *objc3 = [LeftMenuView new];
 NSLog(@"----LeftMenuView3---- %@",objc3);
 }
 */
