//
//  OneVC.m
//  KenshinPro
//
//  Created by kenshin on 17/3/16.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "OneVC.h"
#import "NSString+FXW.h"
#import "BaseFunctionVC.h"
#import "AFNManagerVC.h"
#import "GetContactsVC.h"
#import "SendSMSVC.h"
#import "TableViewCellsVC.h"
#import "MenusVC.h"
#import "AllUISizeVC.h"
#import "CommonUIVC.h"
#import "CustomNavVC.h"
#import "DicAndModelVC.h"
#import "TableViewBuJuVC.h"
#import "ADVC.h"
#import "MainVC.h"
#import "MBProgressVC.h"
#import "NSStringVC.h"
#import "ArrayVC.h"
#import "CountDownVC.h"
#import "BigSmallVC.h"
#import "TextContentVC.h"
#import "AddBorderVC.h"
#import "PushModelStyleVC.h"
#import "NotifiVC.h"
#import "YinDaoVC.h"
#import "FXW_GuidePage.h"


@interface OneVC ()

@end

@implementation OneVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    [self initOneVCUI];
    //fucked a dog 2017-09-05
}


#pragma mark 加载数据
- (void)loadData
{
    [self addDataWithTitle:@"UITextField+自定义" andDetail:@"数据存储到内存地址中的顺序"];
    [self addDataWithTitle:@"网络状态实时监听" andDetail:@"通过AFN 在AppDelegate中实现"];
    [self addDataWithTitle:@"BaseVC" andDetail:@"包含BaseVC的全部功能演示"];
    [self addDataWithTitle:@"控制器之间的跳转" andDetail:@"push、pop、present、dismiss"];
    [self addDataWithTitle:@"TableView布局控制器" andDetail:@"全部内容都方到tableView中展示"];
    [self addDataWithTitle:@"各种UITableViewCell" andDetail:@"基本上包含了目前项目中使用的所有的cell"];
    [self addDataWithTitle:@"字符串" andDetail:@"字符串的基本操作"];
    [self addDataWithTitle:@"时间" andDetail:@"时间的基本操作"];
    [self addDataWithTitle:@"数组" andDetail:@"系统自带的排序方法等"];
    [self addDataWithTitle:@"AFN封装" andDetail:@"针对所在公司进行的封装"];
    [self addDataWithTitle:@"麻痹进度" andDetail:@"有些进度条出现的时候，nav返回按钮会失效哟"];
    [self addDataWithTitle:@"字典与模型的转换" andDetail:@"用到了MJExtension"];
    [self addDataWithTitle:@"各种菜单" andDetail:@"基本上包含了目前项目中使用的所有的菜单"];
    [self addDataWithTitle:@"广告-滚动视图" andDetail:@"MC的项目中使用到"];
    [self addDataWithTitle:@"各种UI的尺寸" andDetail:@"AppIcon，屏幕快照，导航栏、状态栏、tabBar等"];
    [self addDataWithTitle:@"自定义导航栏" andDetail:@"添加导航栏按钮，titleView，或者隐藏导航栏等"];
    [self addDataWithTitle:@"常用封装UI" andDetail:@"封装的按钮，UIControl，弹框的"];
    [self addDataWithTitle:@"通讯录" andDetail:@"获取系统通讯录，和自定义通讯录"];
    [self addDataWithTitle:@"发送短信-打电话" andDetail:@"发送短信-进入系统短信编辑界面"];
    [self addDataWithTitle:@"倒计时按钮" andDetail:@"按钮内部判断时间"];
    [self addDataWithTitle:@"高位补0" andDetail:@"C里面的方法"];
    [self addDataWithTitle:@"大小端转换" andDetail:@"数据存储到内存地址中的顺序"];
    [self addDataWithTitle:@"生成随机数" andDetail:@"随机数字"];
    [self addDataWithTitle:@"UIView 指定方向添加边框" andDetail:@"2017-08-10"];
    [self addDataWithTitle:@"push时modal跳转动画" andDetail:@"从下往上推上"];
    [self addDataWithTitle:@"通知" andDetail:@""];
    [self addDataWithTitle:@"引导页1" andDetail:@"比较low的方式 用控制器"];
    [self addDataWithTitle:@"引导页2" andDetail:@"比较好的方式 直接用view 放在window上"];
    
}

#pragma mark 初始化UI
- (void)initOneVCUI
{
    self.navigationItem.title = @"基础+封装";
    [self.view addSubview:self.tableView];
    
}

- (void)clickCellWithTitle:(NSString *)title
{
    
    if ([title isEqualToString:@"引导页1"])
    {
        YinDaoVC *vc = [[YinDaoVC alloc] init];
        BOOL isOK = [vc initGuidePageWithImgNames:@[@"yinDaoYe1", @"yinDaoYe2", @"yinDaoYe3"]
               pageControlColorNormal:nil
             pageControlColorSelected:nil
                       finishBtnTitle:@"立即体验"];
        
        if(isOK)
        {
            //要用模态的方式切换控制器 目的是隐藏导航栏 其实push过去再隐藏也可以的
            [self.navigationController presentViewController:vc animated:NO completion:nil];
        }
        else
        {
            [self toast:@"加载启动页失败 请查看控制台"];
        }
        return;
    }
     if ([title isEqualToString:@"引导页2"])
     {
         BOOL isOK = [FXW_GuidePage fxw_showGuidePageWithImgNames:@[@"yinDaoYe1", @"yinDaoYe2", @"yinDaoYe3"]
                           pageControlColorNormal:nil
                         pageControlColorSelected:nil
                                   finishBtnTitle:nil];
         if (!isOK) {
             [self toast:@"加载引导页失败"];
         }
         return;
     }
    if ([title isEqualToString:@"通知"])
    {
        NotifiVC *vc = [[NotifiVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"push时modal跳转动画"])
    {
        PushModelStyleVC *vc = [[PushModelStyleVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        
        //核心代码。。。
        vc.view.backgroundColor  = [UIColor whiteColor];
        CATransition* transition = [CATransition animation];
        transition.duration      = 0.2f;
        transition.type          = kCATransitionMoveIn;
        transition.subtype       = kCATransitionFromTop;
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        
        //注意 这里的动画要写成NO 不然就没有想要的效果了
        [self.navigationController pushViewController:vc animated:NO];
        //核心代码。。。
        
        return;
    }
    if ([title isEqualToString:@"生成随机数"])
    {
        [self toast:[NSString fxw_randomNumberWithLength:8]];
        return;
    }
    if ([title isEqualToString:@"UIView 指定方向添加边框"])
    {
        AddBorderVC *vc = [[AddBorderVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"大小端转换"])
    {
        BigSmallVC *vc = [[BigSmallVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"UITextField+自定义"])
    {
        TextContentVC *vc = [[TextContentVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"高位补0"])
    {
        for (int i = 0; i < 1000; i++)
        {
            NSString *testStr = [NSString stringWithFormat:@"%08zd",i];
            NSLog(@"%@", testStr);
        }
        return;
    }
    if([title isEqualToString:@"网络状态实时监听"])
    {
        switch (AppDel.netStatus)
        {
            case AppNetStatusUnknown:
                [self toast:@"当前网络状态未知"];
                break;
            case AppNetStatusNotReachable:
                [self toast:@"当前网络不可用"];
                break;
            case AppNetStatusViaWWAN:
                [self toast:@"当前网络状态为流量"];
                break;
            case AppNetStatusWiFi:
                [self toast:@"当前网络状态为Wifi连接"];
                break;
                
            default:[self toast:@"当前网络状态未知 default"];
                break;
        }
        return;
    }
    if ([title isEqualToString:@"BaseVC"])
    {
        BaseFunctionVC *vc = [[BaseFunctionVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if([title isEqualToString:@"控制器之间的跳转"])
    {
        MainVC *vc = [[MainVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if([title isEqualToString:@"TableView布局控制器"])
    {
        TableViewBuJuVC *vc = [[TableViewBuJuVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"字符串"])
    {
        NSStringVC *vc = [[NSStringVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"数组"])
    {
        ArrayVC *vc = [[ArrayVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"AFN封装"])
    {
        AFNManagerVC *vc = [[AFNManagerVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"麻痹进度"])
    {
        MBProgressVC *vc = [[MBProgressVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"字典与模型的转换"])
    {
        DicAndModelVC *vc = [[DicAndModelVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"各种UITableViewCell"])
    {
        TableViewCellsVC *vc = [[TableViewCellsVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"各种菜单"])
    {
        MenusVC *vc = [[MenusVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"各种UI的尺寸"])
    {
        AllUISizeVC *vc = [[AllUISizeVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"常用封装UI"])
    {
        CommonUIVC *vc = [[CommonUIVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"通讯录"])
    {
        GetContactsVC *vc = [[GetContactsVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"发送短信-打电话"])
    {
        SendSMSVC *vc = [[SendSMSVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"自定义导航栏"])
    {
        CustomNavVC *vc = [[CustomNavVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"广告-滚动视图"])
    {
        ADVC *vc = [[ADVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"倒计时按钮"])
    {
        CountDownVC *vc = [[CountDownVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    [self toast:[NSString stringWithFormat:@"未找到对应VC 点击了:%@", title]];
    
}


- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}


@end
