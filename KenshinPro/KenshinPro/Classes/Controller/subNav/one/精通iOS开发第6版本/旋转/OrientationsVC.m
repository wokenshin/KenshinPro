//
//  OrientationsVC.m
//  KenshinPro
//
//  Created by apple on 2018/12/21.
//  Copyright © 2018 Kenshin. All rights reserved.
//

#import "OrientationsVC.h"

@interface OrientationsVC ()

@end

@implementation OrientationsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

//【注意】如果项目中 应用级 没有勾选支持的方向，那么下面返回任何方向都是无效的
//所以要优先在 项目中进行配置 选择项目[即 导航栏中的第一项]->General->Dployment Info -> Device Orientation
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    //支持 纵向 和 左旋转
//    return (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft);
//}

@end
