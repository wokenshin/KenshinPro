//
//  AppDelegate.h
//
//  Created by MCL on 16/7/13.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "LeftMenuTableView.h"
#import "MenuTableViewCell.h"
#import "Tools.h"
#import "MDSwitch.h"

@interface LeftMenuTableView()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *dataSourceArr;


@end

@implementation LeftMenuTableView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self =[super initWithFrame:frame];
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
//        self.rowHeight = 45;
        self.bounces = NO;
        self.scrollEnabled = YES;
//        self.separatorColor = [UIColor clearColor];
        self.separatorStyle= UITableViewCellSeparatorStyleNone;
        
        //数据源 也用与 区分事件
        self.dataSourceArr = @[@"重新绑定手机",
                               @"修改账户密码",
                               @"设置手势密码",
                               @"关于",
                               @"帮助与反馈",
                               @"退出当前账户"];
        NSString *phone = @"18385099999";
        if (phone == nil || [phone isEqualToString:@""])
        {
            self.dataSourceArr = @[@"重新绑定手机",
//                                   @"修改账户密码",
                                   @"设置手势密码",
                                   @"关于",
                                   @"帮助与反馈",
                                   @"退出当前账户"];
        }
    }
    return  self;
}

#pragma mark - UITableViewDataSource

//每个分区中返回的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSourceArr.count;
    
}

//分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
    
}


static NSString *cellID = @"menu";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[MenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
//    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.text = _dataSourceArr[indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
//    cell.textLabel.highlightedTextColor = RGB2Color(9, 235, 255);//点击cell时 文本高亮
    cell.textLabel.font = [UIFont systemFontOfSize:15];
//    cell.selectedBackgroundView = [[UIView alloc] init]; //阻挡长按变灰
    
    if (indexPath.row == 5)
    {
        cell.textLabel.textColor = [UIColor redColor];
    }
    
//    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 50, screenWidth, 1)];
//    line.backgroundColor = colorLene;
//    [cell.contentView addSubview:line];

    NSInteger cellNum = [_dataSourceArr count];
    if (cellNum == 6)//有6行 手机号登录
    {
        if (indexPath.row < 3 || indexPath.row == 4)
        {
            cell.isShowSeparatorLine = YES;
        }
        else
        {
            cell.isShowSeparatorLine = NO;
        }
    }
    else//微信登录
    {
        if (indexPath.row < 2 || indexPath.row == 3)
        {
            cell.isShowSeparatorLine = YES;
        }
        else
        {
            cell.isShowSeparatorLine = NO;
        }
    }
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"点击了 tableView的第 %ld 个cell", (long)indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *actionName = _dataSourceArr[indexPath.row];
    if (_menuActionBlock) {
        _menuActionBlock(actionName);
    }
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
}

@end
