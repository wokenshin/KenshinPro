//
//  JJSJVC.m
//  KenshinPro
//
//  Created by kenshin van on 2018/1/18.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import "JJSJVC.h"
#import "JJSJRecodeVoiceVC.h"
#import "GYZJVC.h"
@interface JJSJVC ()

@end

@implementation JJSJVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"JJSJ";
    
}

#pragma mark 获取图片
- (IBAction)clickBtnGetPic:(id)sender
{
    GYZJVC *vc = [[GYZJVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 录音工具 格式转换
- (IBAction)clickBtnRecodeVoiceToolsShow:(id)sender
{
    JJSJRecodeVoiceVC *vc = [[JJSJRecodeVoiceVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)dealloc
{
    NSLog(@"——————————————%s 已释放", object_getClassName(self));
}

@end
