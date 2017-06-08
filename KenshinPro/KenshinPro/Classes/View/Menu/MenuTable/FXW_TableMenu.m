//
//  FXW_TableMenu.m
//  CleverApartment
//
//  Created by kenshin on 2017/6/8.
//  Copyright © 2017年 M2MKey. All rights reserved.
//

#import "FXW_TableMenu.h"
#import "Tools.h"
#import "CellFXWTableMenu.h"



@interface FXW_TableMenu()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UILabel                       *labTitle;

@property (nonatomic, strong) UITableView                   *tableView;
@property (nonatomic, strong) NSArray                       *arr;

@property (nonatomic, strong) UIView                        *bottomView;
@property (nonatomic, strong) UIButton                      *btnCancel;

@property (nonatomic, strong) UIView                        *mask;//半透明区域 点击后可关闭菜单
@property (nonatomic, strong) UIView                        *menu;//不透明部分
@property (nonatomic, assign) CGFloat                       heightMenu;

@property (nonatomic, strong) NSString                      *title;


@property (nonatomic, copy)   FXW_TableMenuBlock            clickCellCallback;

@end

@implementation FXW_TableMenu

+ (instancetype)fxwWithTitle:(NSString *)title array:(NSArray *)array
{
    FXW_TableMenu *menu = [[FXW_TableMenu alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)
                                                         title:title
                                                     withArray:array];
    return menu;
    
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title withArray:(NSArray *)array
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.arr = [NSArray arrayWithArray:array];
        self.title = title;
        [self setup];
    }
    return self;
}

- (void)setup
{
    //蒙版
    _mask = [[UIView alloc] initWithFrame:self.frame];
    _mask.backgroundColor = [UIColor blackColor];
    _mask.alpha = 0.3;
    [self addSubview:_mask];
    
    //内容view
    _heightMenu = screenHeight/2.0;
    _heightMenu = 30 + 45 + 40 * [_arr count];
    if (_heightMenu > screenHeight/2.0) {
        _heightMenu = screenHeight/2.0;
    }
    
    _menu = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight - _heightMenu, screenWidth, _heightMenu)];
    _menu.backgroundColor = [UIColor whiteColor];
    
    //标题
    _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 30)];
    _labTitle.backgroundColor = [UIColor whiteColor];
    _labTitle.text = _title;//@"选择房间";
    _labTitle.textColor = colorHomeBlue;
    _labTitle.textAlignment = NSTextAlignmentCenter;
    [_menu addSubview:_labTitle];
    
    //table部分
    [_menu addSubview:self.tableView];
    
    //底部 取消
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, _heightMenu - 45, screenWidth, 45)];
    _bottomView.backgroundColor = [UIColor blackColor];
    
    _btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, screenWidth, 40)];
    _btnCancel.backgroundColor = [UIColor whiteColor];
    [_btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [_btnCancel setTitleColor:colorHomeBlue forState:UIControlStateNormal];
    [_btnCancel addTarget:self action:@selector(clickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_btnCancel];
    [_menu addSubview:_bottomView];
    
    [self addSubview:_menu];
    
    //手势
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                          action:@selector(clickBackRemoveSelf)];
    _mask.userInteractionEnabled = YES;
    [_mask addGestureRecognizer:tap1];
    
    [self show];
    
}

- (void)show
{
    [[[UIApplication sharedApplication].delegate window] addSubview:self];
}

- (void)clickBackRemoveSelf
{
    [self removeFromSuperview];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - UITableViewDelegate
//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

//绘制cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellFXWTableMenu *cell = [tableView dequeueReusableCellWithIdentifier:@"CellFXWTableMenu"
                                                                 forIndexPath:indexPath];
    NSString *title = [_arr objectAtIndex:indexPath.row];
    cell.title = title;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//设置Cell选中[长按]时无颜色变化，这样自定义的分割线就不会“消失”了

    return cell;
    
}

//点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSString *title = [_arr objectAtIndex:indexPath.row];
    
    if (_clickCellCallback)
    {
        _clickCellCallback(indexPath.row);
    }
    
}

- (void)clickCellWithResultblock:(FXW_TableMenuBlock)block
{
    self.clickCellCallback = block;
}

#pragma mark - 懒加载
- (UITableView *)tableView
{
    if (_tableView == nil)
    {
        CGFloat hTable = _heightMenu - 30 - 45;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, screenWidth, hTable)];
        
        _tableView.dataSource = self;
        _tableView.delegate   = self;
//        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = NO;//隐藏cell分割线
        
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:@"CellFXWTableMenu" bundle:nil] forCellReuseIdentifier:@"CellFXWTableMenu"];
    }
    return _tableView;
    
}

- (NSArray *)arr
{
    if (_arr == nil)
    {
        _arr = [[NSArray alloc] init];
    }
    return _arr;
    
}

- (void)clickCancelBtn
{
    NSLog(@"click cancel");
    [self clickBackRemoveSelf];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}



@end
