//
//  ExtensibleTableVC.m
//  KenshinPro
//
//  Created by kenshin van on 2018/2/12.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import "ExtensibleTableVC.h"
#import "FXW_Define.h"
#import "CellJJSJ.h"
#import "ModelJJSJ.h"

//参考 https://github.com/CoderJackyHuang/SectionAnimation
@interface ExtensibleTableVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic, strong) NSMutableArray        *mArrSection;
@property (nonatomic, strong) NSMutableArray        *mArrData;


@end

@implementation ExtensibleTableVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"可扩展的UITableView";
    
    _mArrData = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < 10; ++i)
    {
        ModelJJSJ *sectionModel = [[ModelJJSJ alloc] init];
        sectionModel.isExpanded = NO;
        sectionModel.sectioonName = [NSString stringWithFormat:@"  section: %ld", i];
        
        NSMutableArray *itemArray = [[NSMutableArray alloc] init];
        for (NSUInteger j = 0; j < 10; ++j)
        {
            NSString *cellName = [NSString stringWithFormat:@"  section=%ld, row=%ld", i, j];
            [itemArray addObject:cellName];
        }
        sectionModel.models = itemArray;
        
        [_mArrData addObject:sectionModel];
    }
    
    [self.view addSubview:self.tableView];
    
}

#pragma mark 懒加载
- (UITableView *)tableView
{
    if (_tableView == nil)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, screenWidth, screenHeight - 44)];
        _tableView.dataSource     = self;
        _tableView.delegate       = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//隐藏系统分割线
        //注册Cell
        [_tableView registerNib:[UINib nibWithNibName:@"CellJJSJ" bundle:nil] forCellReuseIdentifier:@"CellJJSJ"];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ModelJJSJ *model = [_mArrData objectAtIndex:section];
    if (model.isExpanded)
    {
        return [model.models count];
    }
    else
    {
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_mArrData count];
}

#pragma mark - UITableViewDelegate
//每一个分组头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

//每一个分组足的高度
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

//返回每一个分组UI
- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ModelJJSJ *model = [_mArrData objectAtIndex:section];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 40)];
    lab.text = model.sectioonName;
    lab.backgroundColor = [UIColor yellowColor];
    UITapGestureRecognizer *clickTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickSection)];
    lab.userInteractionEnabled = YES;
    [lab addGestureRecognizer:clickTap];
    return lab;
}

//点击分组 这里写死了 响应的是 第一个分组的内容
- (void)clickSection
{
    ModelJJSJ *model = [_mArrData objectAtIndex:0];
    model.isExpanded = !model.isExpanded;
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    
}

//每一个cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //创建cell
    CellJJSJ *cell = [tableView dequeueReusableCellWithIdentifier:@"CellJJSJ" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//设置Cell选中[长按]时无颜色变化，这样自定义的分割线就不会“消失”了
    return cell;
    
}

//点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"click CellJJSJ");
}


- (void)dealloc
{
    NSLog(@"——————————————%s 已释放", object_getClassName(self));
}



@end
