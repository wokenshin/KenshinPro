//
//  TableViewCellsVC.m
//  KenshinPro
//
//  Created by kenshin on 17/3/22.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "TableViewCellsVC.h"

@interface TableViewCellsVC ()

@end

@implementation TableViewCellsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    [self initTableViewCellsUI];
    
}

- (void)loadData
{
    //博文软件[其中有意个可扩展的Cell]
    [self addDataWithTitle:@"CellType1" andDetail:@"博文软件"];
    
    //母亲电商
    [self addDataWithTitle:@"CellType2" andDetail:@"母亲电商"];
    
    //丁丁掌门
    [self addDataWithTitle:@"CellType3" andDetail:@"丁丁掌门"];
    
}

- (void)initTableViewCellsUI
{
    self.navigationItem.title = @"各种UITableViewCell";
    [self.view addSubview:self.tableView];
    
}

- (void)clickCellWithTitle:(NSString *)title
{
    if ([title isEqualToString:@"系统通讯录"])
    {
        
        
    }
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}
@end
