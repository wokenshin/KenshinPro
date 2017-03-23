//
//  OneVC.m
//  KenshinPro
//
//  Created by kenshin on 17/3/16.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "OneVC.h"

#import "BaseFunctionVC.h"
#import "GetContactsVC.h"
#import "SwitchModeVC.h"
#import "ControlMenuVC.h"
#import "SendSMSVC.h"
#import "XibSelectedBtnImgVC.h"
#import "TableViewCellsVC.h"
#import "MenusVC.h"
#import "AllUISizeVC.h"

@interface OneVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView                   *tableView;
@property (nonatomic, strong) NSMutableArray                *mArrData;

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
    [self addDataWithTitle:@"各种UITableViewCell" andDetail:@"基本上包含了目前项目中使用的所有的cell"];
    [self addDataWithTitle:@"各种菜单" andDetail:@"基本上包含了目前项目中使用的所有的菜单"];
    [self addDataWithTitle:@"各种UI的尺寸" andDetail:@"AppIcon，屏幕快照，导航栏、状态栏、tabBar等"];
    [self addDataWithTitle:@"自定义导航栏" andDetail:@"添加导航栏按钮，titleView，或者隐藏导航栏等"];
    [self addDataWithTitle:@"常用封装UI" andDetail:@"封装的按钮，UIControl，弹框的"];
    [self addDataWithTitle:@"通讯录" andDetail:@"获取系统通讯录，和自定义通讯录"];
    [self addDataWithTitle:@"发送短信-打电话" andDetail:@"发送短信-进入系统短信编辑界面"];
    [self addDataWithTitle:@"界面-情景模式" andDetail:@"ddzm - Masonry 布局 模态显示 "];
    [self addDataWithTitle:@"菜单-CollectionVew" andDetail:@"ddzm - 控制页面底部菜单"];
    [self addDataWithTitle:@"xib-按钮设置选中状态时的图片" andDetail:@"ddzm - 切换电子锁体"];
}

- (void)addDataWithTitle:(NSString *)title andDetail:(NSString *)detail
{
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
    [mDic setObject:title forKey:@"title"];
    [mDic setObject:detail forKey:@"detail"];
    [self.mArrData addObject:mDic];
    
}

#pragma mark 初始化UI
- (void)initOneUI
{
    self.navigationItem.title = @"one";
    [self.view addSubview:self.tableView];
    
}



#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.mArrData count];
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
    
}

#pragma mark 绘制cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"kenshin"];
    NSDictionary *dic = [self.mArrData objectAtIndex:indexPath.row];
    
    
    cell.textLabel.text  = [dic objectForKey:@"title"];
    cell.detailTextLabel.text = [dic objectForKey:@"detail"];
    
    cell.textLabel.textColor = [UIColor redColor];
    cell.detailTextLabel.textColor = [UIColor blueColor];
    //UITableViewCellAccessoryNone 默认样式  啥都没有
    //UITableViewCellAccessoryCheckmark 钩钩
    //UITableViewCellAccessoryDisclosureIndicator 箭头
    //UITableViewCellAccessoryDetailButton 信息符号的 圆形按钮
    //UITableViewCellAccessoryDisclosureIndicator 箭头
    //UITableViewCellAccessoryDetailDisclosureButton 圆形按钮 + 箭头
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//设置箭头
    
    return cell;
    
}

#pragma mark - 点击——Cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.mArrData objectAtIndex:indexPath.row];
    NSString *title = [dic objectForKey:@"title"];
    NSLog(@"click %@", title);
    
    if ([title isEqualToString:@"BaseVC"])
    {
        BaseFunctionVC *vc = [[BaseFunctionVC alloc] init];
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
    if ([title isEqualToString:@"界面-情景模式"])
    {
        SwitchModeVC *vc = [[SwitchModeVC alloc] init];
        
//        [vc setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        //vcm1.stringPara =@"value";// 传参
        [self.navigationController presentViewController:vc animated:YES completion:nil];
        return;
    }
    if ([title isEqualToString:@"菜单-CollectionVew"])
    {
        ControlMenuVC *vc = [[ControlMenuVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"xib-按钮设置选中状态时的图片"])
    {
        XibSelectedBtnImgVC *vc = [[XibSelectedBtnImgVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    [self toast:[NSString stringWithFormat:@"未找到对应VC 点击了:%@", title]];
    
}

#pragma mark 懒加载
- (UITableView *)tableView
{
    if (_tableView == nil)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
        _tableView.dataSource = self;
        _tableView.delegate   = self;
        
        //隐藏都偶遇分割线【注释掉 可看效果】
        UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
        [_tableView setTableFooterView:v];
        
    }
    return _tableView;
    
}

- (NSMutableArray *)mArrData
{
    if (_mArrData == nil)
    {
        _mArrData = [[NSMutableArray alloc] init];
        
    }
    return _mArrData;
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}


@end
