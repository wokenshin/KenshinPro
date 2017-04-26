//
//  NavBarCustomVC.m
//  GYBase
//
//  Created by kenshin on 16/8/25.
//  Copyright © 2016年 kenshin. All rights reserved.
//

#import "NavBarCustomVC.h"
#import "MCNavBarVC.h"

@interface NavBarCustomVC ()
@property (nonatomic, assign) BOOL          isChangeTitle;
@property (nonatomic, strong) UITextField   *txtSearch;
@end

@implementation NavBarCustomVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"自定义导航栏";
    _txtSearch = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 36)];
    _txtSearch.backgroundColor = [UIColor blackColor];
    _txtSearch.textColor = [UIColor whiteColor];
    _txtSearch.text = @"输入关键字进行搜索";
    
}

- (void)closeKeyBoardWhenTouchBackView
{
    [_txtSearch resignFirstResponder];
    
}

#pragma mark 修改导航条标题
- (IBAction)btnChangeNavTitle:(id)sender
{
    self.navigationItem.titleView = nil;
    if (_isChangeTitle)
    {
        _isChangeTitle = NO;
        self.navigationItem.title = @"自定义导航栏标题";
    }
    else
    {
        _isChangeTitle = YES;
        self.navigationItem.title = @"自定义";
    }
}

#pragma mark 自定义搜索栏【这里完全可以实现 MC项目里面的效果 此处就简单实现了】
- (IBAction)btnSearchNav:(id)sender
{
    self.navigationItem.titleView = _txtSearch;
}

- (IBAction)btnNavBtn:(id)sender
{
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                  target:self
                                  action:@selector(clickBtnNavRight)];
    NSArray *arrBtns = @[btnItem];
    self.navigationItem.rightBarButtonItems = arrBtns;
    
}

- (void)clickBtnNavRight
{
    [Tools toast:@"导航栏按钮被点击" andCuView:self.view];
    
}

#pragma mark 自定义导航栏按钮
- (IBAction)btnNavBtnCustom:(id)sender
{
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    
    [rightBtn setTitle:@"窝草" forState:UIControlStateNormal];
    [rightBtn setTitleColor:RGB2Color(251, 93, 95) forState:UIControlStateNormal];
    [rightBtn setTitleColor:RGB2Color(251, 251, 251) forState:UIControlStateHighlighted];
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    rightBtn.titleLabel.font = Font7;
    
    //事件
    [rightBtn addTarget:self action:@selector(clickBtnNavRight) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* rightBtnItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [self.navigationItem setRightBarButtonItem:rightBtnItem];
    
}

#pragma mark 自定义导航栏按钮 图片
- (IBAction)btnNavBtnCustomImg:(id)sender
{
    
    UIImage *image = [UIImage imageNamed:@"defaultPic"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//IOS 7以上要设置图片渲染模式
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(clickBtnNavRight)];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
}

#pragma mark 母亲电商 搜索栏 自定义导航栏
- (IBAction)btnCustomNavBar:(id)sender
{
    MCNavBarVC *vc = [MCNavBarVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
