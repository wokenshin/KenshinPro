//
//  MainVC.m
//  KenshinPro
//
//  Created by kenshin on 17/4/18.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

//本文件夹下的内容 主要参考 http://blog.csdn.net/wokenshin/article/details/50989690
#import "MainVC.h"
#import "VCN2.h"
#import "VCN3.h"
#import "VCM1.h"



@interface MainVC ()

@end

@implementation MainVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initMainVCUI];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (_popFrom)
    {
        [self toast:[NSString stringWithFormat:@"pop from %@", _popFrom]];
    }
    
}

- (void)initMainVCUI
{
    self.navigationItem.title = @"控制器之间的切换";
    
}

#pragma mark push->VCN2
- (IBAction)pushVCN2:(id)sender
{
    //导航式 push 控制器的传至很简单，因为在push之前会去创建push的VC，所以这里直接给push的VC属性赋值就可以传值了
    
    // 这里的self.navigationController就是MainNavigationController。
    //[由于本项目结构的原因，这里的self.navigationController其实是 tabBarVC下的第一个控制器:navHome]
    
    VCN2 *vc = [[VCN2 alloc] init];
    vc.pushFrom = @"MainVC";
    [self.navigationController pushViewController:vc animated:YES];
    
//    在做了以上Push后，VCN2 就会被压到由MainNavigationController管理的栈的栈顶。这个栈就是 self.navigationController.viewControllers。
//    Push动作是很简单的，基本上所有的Push代码都类似上面这样写
    
}

#pragma mark push->VCN3
- (IBAction)pushVCN3:(id)sender
{
    VCN3 *vc = [[VCN3 alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark Present一个Modal的页面
- (IBAction)modalVC:(id)sender
{
    //Navigation页面流中的某个页面Present一个Modal的页面
    VCM1* vcm1 =[[VCM1 alloc] init];
    [vcm1 setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    vcm1.modalFrom =@"MainVC";// 传参
    [self.navigationController presentViewController:vcm1 animated:YES completion:nil];
    //这里用 self.navigationController present 和 用 self present 的效果都是一样的。但是倾向与用前者
    //因为：其实这里不管用 self.navigationController present... 还是用 self present...，到VCM1后，VCM1的presentingViewController都是MainNavigationVC，只是这里这样写 更能表明presentingViewController是谁
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
