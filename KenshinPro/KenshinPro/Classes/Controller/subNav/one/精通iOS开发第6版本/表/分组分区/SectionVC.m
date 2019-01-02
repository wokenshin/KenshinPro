//
//  SectionVC.m
//  KenshinPro
//
//  Created by apple on 2018/12/29.
//  Copyright © 2018 Kenshin. All rights reserved.
//

#import "SectionVC.h"

static NSString *CellSectionCellId = @"CellSectionCellId";
@interface SectionVC ()<UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate>

@property (nonatomic, strong) NSDictionary *dicName;
@property (nonatomic, strong) NSArray      *arrKey;

//搜索
@property (nonatomic, strong) NSMutableArray *filteredNames;
@property (nonatomic, strong) UISearchDisplayController *searchVC;//iOS8之后已经不推荐使用了
//应使用 UISearchController

@end

@implementation SectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分区，索引";
    
    UITableView *tableView = [self.view viewWithTag:1];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellSectionCellId];
    
    //获取数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sortednames" ofType:@"plist"];
    _dicName = [NSDictionary dictionaryWithContentsOfFile:path];
    _arrKey  = [[_dicName allKeys] sortedArrayUsingSelector:@selector(compare:)];//排序
    
    
    //搜索
    _filteredNames = [NSMutableArray array];//用来保存基于搜索条件过滤出后的结果
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 44)];
    tableView.tableHeaderView = searchBar;
    _searchVC = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    _searchVC.delegate = self;
    _searchVC.searchResultsDataSource = self;
    
    //修改分区索引的颜色
    //下面的代码在当前环境下有bug，索引变成黑色了
//    tableView.sectionIndexBackgroundColor = [UIColor blackColor];
//    tableView.sectionIndexTrackingBackgroundColor = [UIColor blackColor];
//    tableView.sectionIndexColor = [UIColor blackColor];
    
}


#pragma mark -
#pragma mark 数据源
//分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (tableView.tag == 1) {//区分是当前表 还是搜索后的结果表
        return [_arrKey count];//分区数
    } else {
        return 1;
    }
    
}

//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView.tag == 1) {//区分是当前表 还是搜索后的结果表
        NSString *key = _arrKey[section];//获取当前分区【因为属性列表有做排序 所以这里的section对应的字母A～Z】
        NSArray *arrName = _dicName[key];//拿到 A～Z 中的一个 key 然后获取字典中对应的数组
        return [arrName count];
    } else {
        return [_filteredNames count];
    }
    
}

//分区标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (tableView.tag == 1) {//区分是当前表 还是搜索后的结果表
        return _arrKey[section];
    } else {
        return nil;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellSectionCellId forIndexPath:indexPath];
    
    if (tableView.tag == 1) {//区分是当前表 还是搜索后的结果表
        NSString *key = _arrKey[indexPath.section];//获取当前分组索引对应的key
        NSArray *arrNameSection = _dicName[key];//获取字典中对应key的数组
        cell.textLabel.text = arrNameSection[indexPath.row];//获取当前行「数组中对应的值」
        
    } else {
        cell.textLabel.text = _filteredNames[indexPath.row];
    }
    
    return cell;
}

//普通模式 table style = Plain
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if (tableView.tag == 1) {//区分是当前表 还是搜索后的结果表
        return _arrKey;
    } else {
        return nil;
    }
}

#pragma mark 搜索
- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView{
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellSectionCellId];
    
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(nullable NSString *)searchString{
    
    [_filteredNames removeAllObjects];//清空上一次的搜索结果
    
    if (searchString.length > 0) {//判断 搜索条件是否为空
        
        //定义一个谓词，用于判断 名字 与 搜索字符串 是否匹配
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            NSRange rang = [evaluatedObject rangeOfString:searchString options:NSCaseInsensitiveSearch];
            return rang.location != NSNotFound;
        }];
        for (NSString *key in _arrKey) {
            NSArray *matches = [_dicName[key] filteredArrayUsingPredicate:predicate];
            [_filteredNames addObjectsFromArray:matches];
        }
    }
    return YES;
}
@end
