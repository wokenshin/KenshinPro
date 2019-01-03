//
//  FontListVC.m
//  KenshinPro
//
//  Created by apple on 2019/1/3.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "FontListVC.h"
#import "FavoritesList.h"
#import "FontSizeVC.h"
#import "FontInfoVC.h"

@interface FontListVC ()


@end

@implementation FontListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //将下面代码注释掉 以便保留显示选择
    //self.clearsSelectionOnViewWillAppear = NO;
    
    //如果是收藏列表 就显示编辑按钮
    if (_showsFavorites) {
        self.navigationItem.rightBarButtonItem = self.editButtonItem;//点击该按钮的时候 表会进去编辑状态
    }
    
    UIFont *preferredTableViewFont = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    self.cellPointSize = preferredTableViewFont.pointSize;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.showsFavorites) {
        self.fontNames = [FavoritesList sharedFavoritesList].favorites;
        [self.tableView reloadData];
    }
}

- (UIFont *)fontForDisplayIndexPath:(NSIndexPath *)indexPath{
    NSString *fontName = self.fontNames[indexPath.row];
    return [UIFont fontWithName:fontName size:_cellPointSize];
    
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.fontNames count];//分区行数
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellID = @"FontName";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellID];
    //配置表单元
    cell.textLabel.font = [self fontForDisplayIndexPath:indexPath];
    cell.textLabel.text = self.fontNames[indexPath.row];
    cell.detailTextLabel.text = self.fontNames[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;//cell右边的按钮
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIFont *font = [self fontForDisplayIndexPath:indexPath];
    
    FontSizeVC *vc = [[FontSizeVC alloc] init];
    vc.font = font;
    vc.navigationItem.title = font.fontName;
    [self.navigationController pushViewController:vc animated:YES];
}

//辅助按钮事件
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    
    UIFont *font = [self fontForDisplayIndexPath:indexPath];
    
    FontInfoVC *vc = [[FontInfoVC alloc] init];
    vc.font = font;
    
    //判断当前 字体 是否包含在收藏列表中
    vc.isFavorites = [[FavoritesList sharedFavoritesList].favorites containsObject:font.fontName];
    
    vc.navigationItem.title = font.fontName;
    [self.navigationController pushViewController:vc animated:YES];
    
}

//左滑删除手势 开关
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return _showsFavorites;//如果这里显示的是收藏列表 就会返回YES
}

//左滑删除监听
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_showsFavorites == NO) return;
    
    //判断是否是删除事件
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //从数据源中删除该行
        NSString *favorite = self.fontNames[indexPath.row];
        [[FavoritesList sharedFavoritesList] removeFavorite:favorite];
        self.fontNames = [FavoritesList sharedFavoritesList].favorites;
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}

//移动行 在用户完成一行的拖动时调用
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    [[FavoritesList sharedFavoritesList] moveItemAtIndex:sourceIndexPath.row
                                                 toIndex:destinationIndexPath.row];
    
}


@end
