//
//  PuerTCellVC.m
//  KenshinPro
//
//  Created by apple on 2018/5/3.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import "PuerTCellVC.h"
#import "CellJJFriend.h"
#import "JJCircleView.h"

@interface PuerTCellVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) NSMutableArray *mArrTabData;
@property (nonatomic, strong) JJCircleView   *tableHeader;
@end

@implementation PuerTCellVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initUI];
}

- (void)initData
{
    _mArrTabData = [[NSMutableArray alloc] init];
    JJModelFriend * m1 = [self createModelWithImgName:@"jjsj_1" title:@"1"];
    JJModelFriend * m2 = [self createModelWithImgName:@"jjsj_2" title:@"2"];
    JJModelFriend * m3 = [self createModelWithImgName:@"jjsj_3" title:@"3"];
    JJModelFriend * m4 = [self createModelWithImgName:@"jjsj_4" title:@"4"];
    JJModelFriend * m5 = [self createModelWithImgName:@"jjsj_5" title:@"6"];
    JJModelFriend * m6 = [self createModelWithImgName:@"jjsj_6" title:@"7"];
    JJModelFriend * m7 = [self createModelWithImgName:@"jjsj_7" title:@"8"];
    JJModelFriend * m8 = [self createModelWithImgName:@"jjsj_gx" title:@"9"];
    JJModelFriend * m9 = [self createModelWithImgName:@"jjsj_more" title:@"9"];
//    JJModelFriend * m10 = [self createModelWithImgName:@"baiDuBottomMenu1" title:@"10"];
//    JJModelFriend * m11 = [self createModelWithImgName:@"baiDuBottomMenu2" title:@"11"];
//    JJModelFriend * m12 = [self createModelWithImgName:@"baiDuBottomMenu3" title:@"12"];
//    JJModelFriend * m13 = [self createModelWithImgName:@"baiDuBottomMenu4" title:@"13"];
//    JJModelFriend * m14 = [self createModelWithImgName:@"baiDuBottomMenu5" title:@"14"];
//    JJModelFriend * m15 = [self createModelWithImgName:@"baiDuBottomMenu6" title:@"15"];
//    JJModelFriend * m16 = [self createModelWithImgName:@"baiDuBottomMenu7" title:@"16"];
//    JJModelFriend * m17 = [self createModelWithImgName:@"baiDuBottomMenu8" title:@"17"];
//
    [_mArrTabData addObject:m1];
    [_mArrTabData addObject:m2];
    [_mArrTabData addObject:m3];
    [_mArrTabData addObject:m4];
    [_mArrTabData addObject:m5];
    [_mArrTabData addObject:m6];
    [_mArrTabData addObject:m7];
    [_mArrTabData addObject:m8];
    [_mArrTabData addObject:m9];
//    [_mArrTabData addObject:m10];
//    [_mArrTabData addObject:m11];
//    [_mArrTabData addObject:m12];
//    [_mArrTabData addObject:m13];
//    [_mArrTabData addObject:m14];
//    [_mArrTabData addObject:m15];
//    [_mArrTabData addObject:m16];
//    [_mArrTabData addObject:m17];
    
}

- (JJModelFriend *)createModelWithImgName:(NSString *)imgName title:(NSString *)title{
    JJModelFriend *model = [[JJModelFriend alloc] init];
    model.imgName        = imgName;
    model.title          = title;
    return model;
}

- (void)initUI
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    _tableView.dataSource = self;
    _tableView.delegate   = self;
    //设置表组->这样可以隐藏多余的分割线
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 20)];
    [self.view addSubview:_tableView];
    
    _tableHeader = [JJCircleView jjsj_createJJCircleView];
    
    [_tableHeader clickGroupCell:^(JJCircleView *view) {
        NSLog(@"click group");
    }];
    
    [_tableHeader clickRoomCell:^(JJCircleView *view) {
        NSLog(@"click room");
    }];
    
    _tableView.tableHeaderView = _tableHeader;
    
}

#pragma mark - UITableViewDataSource
#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mArrTabData.count;
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellJJFriend";
    CellJJFriend *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[CellJJFriend alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    JJModelFriend *model = _mArrTabData[indexPath.row];
    cell.model = model;
    return cell;
    
}

#pragma mark - UITableViewDelegate
#pragma mark 重新设置单元格高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"click cell %ld", indexPath.row);
}

@end
