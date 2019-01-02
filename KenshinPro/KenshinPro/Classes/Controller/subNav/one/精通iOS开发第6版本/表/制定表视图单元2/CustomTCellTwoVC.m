//
//  CustomTCellTwoVC.m
//  KenshinPro
//
//  Created by apple on 2018/12/29.
//  Copyright © 2018 Kenshin. All rights reserved.
//

#import "CustomTCellTwoVC.h"
#import "CellCusTwo.h"

//注意 这里的id 是 xib 中 cell的 唯一标识 即 Identifier
static NSString *CellCusTwoID = @"CellCusTwoID";

@interface CustomTCellTwoVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray   *arrData;

@end

@implementation CustomTCellTwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"制定表视图单元-xib";
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
    tableView.rowHeight = 65;
    //注册Cell
    UINib *nib = [UINib nibWithNibName:@"CellCusTwo" bundle:nil];
    
    [tableView registerNib:nib forCellReuseIdentifier:CellCusTwoID];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_arrData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CellCusTwo *cell = [tableView dequeueReusableCellWithIdentifier:CellCusTwoID forIndexPath:indexPath];
    NSDictionary *dic = _arrData[indexPath.row];
    cell.name  = [dic objectForKey:@"Name"];
    cell.color = [dic objectForKey:@"Color"];
    
    return cell;
    
    
}

@end
