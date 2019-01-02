//
//  CustomTCellVC.m
//  KenshinPro
//
//  Created by apple on 2018/12/28.
//  Copyright © 2018 Kenshin. All rights reserved.
//

#import "CustomTCellVC.h"
#import "CellCus.h"


static NSString *CellCusID = @"CellCus";
@interface CustomTCellVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray   *arrData;

@end


@implementation CustomTCellVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"制定表视图单元-code";
    _arrData = @[@{@"Name":@"利奥",@"Color":@"红色"},
                 @{@"Name":@"小当家",@"Color":@"红色"},
                 @{@"Name":@"犬夜叉",@"Color":@"红色"},
                 @{@"Name":@"达也",@"Color":@"白色"},
                 @{@"Name":@"金米",@"Color":@"红色"},
                 @{@"Name":@"健次郎",@"Color":@"肉色"},
                 @{@"Name":@"樱木",@"Color":@"红色"},
                 @{@"Name":@"鸣人",@"Color":@"黄色"},
                 @{@"Name":@"路飞",@"Color":@"黄色"},
                 @{@"Name":@"孙悟空",@"Color":@"黄色"}];
    
    UITableView *tableView = [self.view viewWithTag:1];
    //注册Cell
    [tableView registerClass:[CellCus class] forCellReuseIdentifier:CellCusID];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_arrData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CellCus *cell = [tableView dequeueReusableCellWithIdentifier:CellCusID forIndexPath:indexPath];
    NSDictionary *dic = _arrData[indexPath.row];
    cell.name  = [dic objectForKey:@"Name"];
    cell.color = [dic objectForKey:@"Color"];
    
    return cell;
    
    
}

@end
