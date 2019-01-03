//
//  FontsVC.m
//  KenshinPro
//
//  Created by apple on 2019/1/2.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "FontsVC.h"
#import "FavoritesList.h"
#import "FontListVC.h"

static NSString *FamilyNameCell = @"FamilyName";
static NSString *FavoritesCell  = @"Favorites";
@interface FontsVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView   *tableView;

//这里使用copy的意义 书中的解释我并不太理解 page214
@property (nonatomic, copy)   NSArray        *familyNames;//所有字体

@property (nonatomic, assign) CGFloat        cellPointSize;//字体大小
@property (nonatomic, strong) FavoritesList  *favoritesList;

@end

@implementation FontsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Fonts";
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate   = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:FamilyNameCell];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:FavoritesCell];
    
    //获取UIFont中所有字体的名称，并排序
    _familyNames = [[UIFont familyNames] sortedArrayUsingSelector:@selector(compare:)];
    
    //获取来在标题处使用的字体
    UIFont *preferredTableViewFont = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    
    //获取字体大小
    _cellPointSize = preferredTableViewFont.pointSize;
    
    //获取收藏列表
    _favoritesList = [FavoritesList sharedFavoritesList];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_tableView reloadData];
    
}

//计算出表单元中需要显示哪种字体
- (UIFont *)fontForDisplayIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NSString *familyName = _familyNames[indexPath.row];
        NSString *fontName = [[UIFont fontNamesForFamilyName:familyName] firstObject];
        return [UIFont fontWithName:fontName size:_cellPointSize];
    } else {
        return nil;
    }
}

#pragma mark - 表代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //返回分区数
    if ([_favoritesList.favorites count] >0) {
        return 2;//当有收藏字体的时候
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //返回分区中的行数
    if (section == 0) {
        return [_familyNames count];
    } else {
        return 1;
    }
}

//指定分区标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    //根据分区索引 设置标题
    if (section == 0) {
        return @"All Font Familys";
    } else {
        return @"MY Favorite Fonts";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = nil;
    
    //配置表单元
    if (indexPath.section == 0) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:FamilyNameCell];
        cell.textLabel.font = [self fontForDisplayIndexPath:indexPath];
        cell.textLabel.text = _familyNames[indexPath.row];
        cell.detailTextLabel.text = _familyNames[indexPath.row];
    } else {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FavoritesCell];
        cell.textLabel.text = @"我收藏的字体";
    }
    
    return cell;
}

//为每个单元指定不通的高度【在当前的环境中其实不用写，也完美适配来】
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 0) {
//        UIFont *font = [self fontForDisplayIndexPath:indexPath];
//        return 25 + font.ascender - font.descender;
//    } else {
//        return tableView.rowHeight;
//    }
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    FontListVC *vc = [[FontListVC alloc] init];
    
    if (indexPath.section == 0) {
        NSString *familyName = self.familyNames[indexPath.row];
        vc.fontNames = [[UIFont fontNamesForFamilyName:familyName] sortedArrayUsingSelector:@selector(compare:)];
        vc.navigationItem.title = familyName;
        vc.showsFavorites = NO;
        
        
    } else {
        vc.fontNames = self.favoritesList.favorites;
        vc.navigationItem.title = @"Favorites";
        vc.showsFavorites = YES;//标记push过去显示的是收藏列表
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
