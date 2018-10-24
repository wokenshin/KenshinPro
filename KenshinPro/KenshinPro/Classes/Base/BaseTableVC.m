//
//  BaseTableVC.m
//  KenshinPro
//
//  Created by kenshin on 17/3/16.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "BaseTableVC.h"

@interface BaseTableVC ()

@end

@implementation BaseTableVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)addDataWithTitle:(NSString *)title andDetail:(NSString *)detail
{
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
    [mDic setObject:title  forKey:@"title"];
    [mDic setObject:detail forKey:@"detail"];
    [self.mArrData addObject:mDic];
    
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
    NSDictionary *dic     = [self.mArrData objectAtIndex:indexPath.row];
    
    
    cell.textLabel.text       = [dic objectForKey:@"title"];
    cell.detailTextLabel.text = [dic objectForKey:@"detail"];
    
    cell.textLabel.textColor       = [UIColor redColor];
    cell.detailTextLabel.textColor = [UIColor blueColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//设置箭头
    
    return cell;
    
}

#pragma mark - 点击——Cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.mArrData objectAtIndex:indexPath.row];
    NSString *title   = [dic objectForKey:@"title"];
//    NSLog(@"click %@", title);
    
    [self clickCellWithTitle:title];
}

//cell 被点击的时候会调用该方法
- (void)clickCellWithTitle:(NSString *)title{}

#pragma mark 懒加载
- (UITableView *)tableView
{
    if (_tableView == nil)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, screenWidth, screenHeight - 64 - 49)];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate   = self;
        
        //隐藏多余遇分割线【注释掉 可看效果】
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

- (void)fxw_pushVC:(UIViewController *)pushVC
{
    pushVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pushVC animated:YES];
}

@end
