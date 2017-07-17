//
//  ThreeVC.m
//  KenshinPro
//
//  Created by kenshin on 17/3/16.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "ThreeVC.h"
#import "OCAndVC.h"
#import "OCCallThirdSwiftLibVC.h"
#import "SetUICornerRadiusVC.h"
#import "JSContentVC.h"
#import "BaseRichTextVC.h"
#import "DataBaseVC.h"
#import "ImgScanPickerVC.h"
#import "ThemeVC.h"
#import "JWTVC.h"
#import "CRC32VC.h"
#import "RegexVC.h"
#import "SocketVC.h"
#import "NSDataUtilsVC.h"

@interface ThreeVC ()

@end

@implementation ThreeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    [self initThreeVCUI];
    
}

- (void)loadData
{
    [self addDataWithTitle:@"数据存储" andDetail:@"沙盒、数据库、归档、属性列表等"];
    [self addDataWithTitle:@"OC+Swift 混编" andDetail:@"OC下调用Swift，Swift下调用OC"];
    [self addDataWithTitle:@"OC调用Swift三方库" andDetail:@"这个就爽了"];
    [self addDataWithTitle:@"在Xib或者故事版中为UI设置圆角" andDetail:@"通过分类 UIView+FXW 实现"];
    [self addDataWithTitle:@"OC与网页JS的交互" andDetail:@"MC时期做的东东"];
    [self addDataWithTitle:@"富文本-基础" andDetail:@"AttributedString"];
    [self addDataWithTitle:@"富文本-高级" andDetail:@"三方库 YYText 其实就是前者的封装"];
    [self addDataWithTitle:@"图片浏览器-MC期间" andDetail:@"http url 需要设置 App Transport Security Settings"];
    [self addDataWithTitle:@"App主题切换" andDetail:@"实现方式其实并不好"];
    [self addDataWithTitle:@"JWT" andDetail:@"关于这货是什么 自己百度去"];
    [self addDataWithTitle:@"CRC校验" andDetail:@"关于这货是什么 自己百度去"];
    [self addDataWithTitle:@"正则表达式" andDetail:@"常用正则表达式，以及自定义正则表达式"];
    [self addDataWithTitle:@"Socket" andDetail:@"AnsycSocket"];
    [self addDataWithTitle:@"NSData常用工具" andDetail:@"主要用于发送蓝牙消息等场景"];
    
}

- (void)initThreeVCUI
{
    self.navigationItem.title = @"进阶";
    [self.view addSubview:self.tableView];
    
}

- (void)clickCellWithTitle:(NSString *)title
{
    
    if ([title isEqualToString:@"NSData常用工具"])
    {
        NSDataUtilsVC *vc = [[NSDataUtilsVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"Socket"])
    {
        SocketVC *vc = [[SocketVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"数据存储"])
    {
        DataBaseVC *vc = [[DataBaseVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"OC+Swift 混编"])
    {
        OCAndVC *vc = [[OCAndVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"OC调用Swift三方库"])
    {
        OCCallThirdSwiftLibVC *vc = [[OCCallThirdSwiftLibVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"在Xib或者故事版中为UI设置圆角"])
    {
        SetUICornerRadiusVC *vc = [[SetUICornerRadiusVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"OC与网页JS的交互"])
    {
        JSContentVC *vc = [[JSContentVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"富文本-基础"])
    {
        BaseRichTextVC *vc = [[BaseRichTextVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"图片浏览器-MC期间"])
    {
        ImgScanPickerVC *vc = [[ImgScanPickerVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"App主题切换"])
    {
        ThemeVC *vc = [[ThemeVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"JWT"])
    {
        JWTVC *vc = [[JWTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"CRC校验"])
    {
        CRC32VC *vc = [[CRC32VC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"正则表达式"])
    {
        RegexVC *vc = [[RegexVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    [self toastBottom:@"没有实现该功能"];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
