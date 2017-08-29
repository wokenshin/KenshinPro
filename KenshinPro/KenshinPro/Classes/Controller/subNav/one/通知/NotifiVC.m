//
//  NotifiVC.m
//  KenshinPro
//
//  Created by kenshin on 2017/8/11.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "NotifiVC.h"
#import "Notifi2VC.h"


@interface NotifiVC ()

@property (weak, nonatomic) IBOutlet UILabel *labTips;

@end

@implementation NotifiVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"通知";
    
}

//观察通知一
- (IBAction)clickBtnGC1:(id)sender
{
    [self del1];//避免重复监听 重复监听的话 接收通知也会接收多次
    
    NSString *noticeName = NOTIFI_ONE;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(NOTIFI_ONE:)
                                                 name:noticeName object:nil];
    
}

//观察通知二
- (IBAction)clickBtnGC2:(id)sender
{
    [self del2];//避免重复监听
    
    //同步使用宏来实现 可以省去很多代码
    FXW_NOTIF_ADD(NOTIFI_TWO, NOTIFI_TWO:);
    
}

//取消观察通知一
- (IBAction)clickBtnCancelGC1:(id)sender
{
    [self del1];
}

//取消观察通知二
- (IBAction)clickBtnCancelGC2:(id)sender
{
    [self del2];
}

- (void)del1
{
    [[NSNotificationCenter  defaultCenter] removeObserver:self name:NOTIFI_ONE object:nil];
}

- (void)del2
{
    //同步使用宏来实现 可以省去很多代码
    FXW_NOTIF_REMV(NOTIFI_TWO);
}

- (IBAction)clickBtnNext:(id)sender
{
    Notifi2VC *vc = [[Notifi2VC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


//接收通知一的事件
- (void)NOTIFI_ONE:(NSNotification *)info
{
    NSLog(@"点击鼠标查看 info中的内容");
}

//接收通知二的事件
- (void)NOTIFI_TWO:(NSNotification *)info
{
    NSLog(@"");
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
