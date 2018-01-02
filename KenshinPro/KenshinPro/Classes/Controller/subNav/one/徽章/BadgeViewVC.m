//
//  BadgeViewVC.m
//  KenshinPro
//
//  Created by kenshin van on 2017/12/25.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "BadgeViewVC.h"
#import "PPBadgeView.h"

/**
 参考国内三方库:https://github.com/jkpang/PPBadgeView
 */
@interface BadgeViewVC ()

@property (nonatomic, strong) UITabBarItem          *bar;
@property (nonatomic, assign) NSUInteger            badgeNum;

@end

@implementation BadgeViewVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"徽章";
    _bar = self.navigationController.tabBarItem;
    
}

//增加徽章中的条数
- (IBAction)add:(id)sender
{
    _badgeNum++;
    [self setBadgeNumWithNum:_badgeNum];
}

//减少徽章中的条数
- (IBAction)reduce:(id)sender
{
    if (_badgeNum == 0)
    {
        [self toastBottom:@"徽章已为0"];
        return;
    }
    _badgeNum--;
    [self setBadgeNumWithNum:_badgeNum];
}

//清空徽章中的条数
- (IBAction)clean:(id)sender
{
    [self setBadgeNumWithNum:0];
}

- (void)setBadgeNumWithNum:(NSUInteger )num
{
    _badgeNum = num;
    [self toastBottom:[NSString stringWithFormat:@"徽章为:%zd", _badgeNum]];
    [_bar pp_addBadgeWithNumber:_badgeNum];
//    [_bar pp_addDotWithColor:[UIColor redColor]];//小红点
//    [_bar pp_addDotWithColor:[UIColor clearColor]];//小红点
}

- (void)dealloc
{
    NSLog(@"——————————————%s 已释放", object_getClassName(self));
}

@end
