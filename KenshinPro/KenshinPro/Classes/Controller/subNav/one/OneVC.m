//
//  OneVC.m
//  KenshinPro
//
//  Created by kenshin on 17/3/16.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "OneVC.h"

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


@interface OneVC ()

@end

@implementation OneVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    [self initOneUI];
    
}

#pragma mark 加载数据
- (void)loadData
{
    [self addDataWithTitle:@"BaseVC" andDetail:@"包含BaseVC的全部功能演示"];
    [self addDataWithTitle:@"AFN封装" andDetail:@"针对所在公司进行的封装"];
    [self addDataWithTitle:@"字典与模型的转换" andDetail:@"用到了MJExtension"];
    [self addDataWithTitle:@"各种UITableViewCell" andDetail:@"基本上包含了目前项目中使用的所有的cell"];
    [self addDataWithTitle:@"各种菜单" andDetail:@"基本上包含了目前项目中使用的所有的菜单"];
    [self addDataWithTitle:@"各种UI的尺寸" andDetail:@"AppIcon，屏幕快照，导航栏、状态栏、tabBar等"];
    [self addDataWithTitle:@"自定义导航栏" andDetail:@"添加导航栏按钮，titleView，或者隐藏导航栏等"];
    [self addDataWithTitle:@"常用封装UI" andDetail:@"封装的按钮，UIControl，弹框的"];
    [self addDataWithTitle:@"通讯录" andDetail:@"获取系统通讯录，和自定义通讯录"];
    [self addDataWithTitle:@"发送短信-打电话" andDetail:@"发送短信-进入系统短信编辑界面"];
    
}


#pragma mark 初始化UI
- (void)initOneUI
{
    self.navigationItem.title = @"one";
    [self.view addSubview:self.tableView];
    
}

- (void)clickCellWithTitle:(NSString *)title
{
    if ([title isEqualToString:@"BaseVC"])
    {
        BaseFunctionVC *vc = [[BaseFunctionVC alloc] init];
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
    [self toast:[NSString stringWithFormat:@"未找到对应VC 点击了:%@", title]];
    
}


- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}


@end
