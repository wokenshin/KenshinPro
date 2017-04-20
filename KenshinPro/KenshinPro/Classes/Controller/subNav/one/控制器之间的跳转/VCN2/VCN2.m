//
//  VCN2.m
//  KenshinPro
//
//  Created by kenshin on 17/4/18.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "VCN2.h"
#import "MainVC.h"
#import "VCN3.h"

@interface VCN2 ()

@end

@implementation VCN2

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initVCN2UI];
    
    if (_pushFrom)
    {
        [self toast:[NSString stringWithFormat:@"push from %@", _pushFrom]];
    }
    
}

- (void)initVCN2UI
{
    self.navigationItem.title = @"VCN2";
    
}

- (IBAction)popPreVC:(id)sender
{
    //这里的作用和点击导航栏的返回按钮效果一样
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)popSetPreVCValue:(id)sender
{
    //逐级Pop是很简单，但是要往回传参就没Push那样方便了，
    //你需要去self.navigationController.viewControllers 中去找到你要跳达的VC，然后设置其参数

//    [self popWayOne];//该方式适用于已知pop的VC在栈中的位置 这里的栈 其实就是一个数组
    
    [self popWayTwo];//该方式适用于任何情况，推荐使用此方式
    
    //做了以上的跳跃式Pop后，self.navigationController.viewControllers 这个栈中所有在 VCN1 上面的 VC 都会被弹出。
    //既： [navHome,VCN1,VCN2]-->[navHome,VCN1]
    //通过这种方式，可以跳到栈中任意的页面
}

- (void)popWayOne
{
    //这里的栈低才是跟控制器，而本项目中的上一级VC是在数组的第1个位置，0是栈底
    if([[self.navigationController.viewControllers objectAtIndex:1] isKindOfClass:[MainVC class]])
    {
        MainVC *vcn1 =(MainVC*)[self.navigationController.viewControllers objectAtIndex:1];
        vcn1.popFrom =@"VCN2";//传参
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)popWayTwo
{
    //还有种方法是通过循环遍历self.navigationController.viewControllers 找到自己想要pop的vc，然后pop过去
    NSInteger len = [self.navigationController.viewControllers count];
    for (int i = 0; i < len; i++)
    {
        if([[self.navigationController.viewControllers objectAtIndex:i] isKindOfClass:[MainVC class]])
        {
            MainVC *vcn1 =(MainVC*)[self.navigationController.viewControllers objectAtIndex:i];
            vcn1.popFrom =@"VCN2";//传参
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
    }
    [self toast:@"并没有找到像要pop的VC"];
    
}

//pop到根VC
- (IBAction)popToRootVC:(id)sender
{
    //同样 也可以通过这里的 popWayTwo pop到根控制器 并传值
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (IBAction)pushVCN3:(id)sender
{
    VCN3 *vc = [[VCN3 alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
