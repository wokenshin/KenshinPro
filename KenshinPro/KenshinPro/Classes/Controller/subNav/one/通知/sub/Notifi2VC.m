//
//  Notifi2VC.m
//  KenshinPro
//
//  Created by kenshin on 2017/8/11.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "Notifi2VC.h"

@interface Notifi2VC ()

@property (weak, nonatomic) IBOutlet UITextField *txtKey;

@property (weak, nonatomic) IBOutlet UITextField *txtValue;


@end

@implementation Notifi2VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"通知";
}

- (IBAction)clickBtnSendNotifiOne:(id)sender
{
    NSNotification *notification = [NSNotification notificationWithName:NOTIFI_ONE object:@"我顶你个肺" userInfo:[self dic]];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
}

- (IBAction)clickBtnSendNotifiTwo:(id)sender
{
    //同步使用宏来实现 可以省去很多代码
    FXW_NOTIF_POST(NOTIFI_TWO, [self dic]);
    
}

- (NSDictionary *)dic
{
    NSString *key   = _txtKey.text;
    NSString *value = _txtValue.text;
    
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
    [mDic setObject:value forKey:key];
    
    return mDic;
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
