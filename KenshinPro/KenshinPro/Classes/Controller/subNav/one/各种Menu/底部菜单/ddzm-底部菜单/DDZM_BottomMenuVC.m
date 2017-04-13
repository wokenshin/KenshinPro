//
//  DDZM_BottomMenuVC.m
//  KenshinPro
//
//  Created by kenshin on 17/4/5.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "DDZM_BottomMenuVC.h"
#import "DeviceMenuView.h"

@interface DDZM_BottomMenuVC ()<DeviceMenuViewDelegate>

@property (nonatomic, strong) FXW_Control                           *maskView;
@property (nonatomic, strong) DeviceMenuView                        *menuView;
@property (nonatomic, assign) CGFloat                               menuHeight;//220

@end

@implementation DDZM_BottomMenuVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"ddzm-底部菜单";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _menuHeight = 190;
    WS(ws);
    [self setNavRightBtnWithName:@"底部菜单" andClickResultblock:^{
        [ws openBottomMenu];
    }];
    
}

- (void)openBottomMenu
{
    self.menuView.frame = CGRectMake(0, screenHeight, screenWidth, _menuHeight);
    
    //标题
    self.menuView.title.text = @"黄金锁";
    //蓝牙地址
    self.menuView.blueToothAddress.text = @"12:34:56:78";
    
    WS(ws);
    //将蒙版添加到window
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    [window addSubview:self.maskView];
    [window addSubview:self.menuView];
    
    //[显示菜单]修改菜单 frame 到可视位置
    [UIView animateWithDuration:0.3 animations:^{
        ws.menuView.frame = CGRectMake(0, screenHeight - ws.menuHeight, screenWidth, ws.menuHeight);
        ws.maskView.hidden = NO;
    } completion:^(BOOL finished) {

    }];
    
    //[关闭菜单]修改菜单 frame 到不可视位置
    [self.maskView clickControlWithResultBlock:^(FXW_Control *control) {
        [UIView animateWithDuration:0.3 animations:^{
            ws.menuView.frame = CGRectMake(0, screenHeight, screenWidth, ws.menuHeight);
            ws.maskView.hidden = YES;
        } completion:^(BOOL finished) {
            
        }];
    }];

}

#pragma mark - 设备菜单代理
//设置常用按钮
-(void)deviceMenuSetCommon:(DeviceMenuView *)itemView;
{
    //状态取反，更新数据
    itemView.btnCommon.selected = !itemView.btnCommon.selected;
    
}

//快捷开锁
-(void)deviceMenuSetQuick:(DeviceMenuView *)itemView
{
    //状态取反，更新数据
    itemView.btnQuick.selected = !itemView.btnQuick.selected;
    
}

//编辑设备名称
-(void)deviceMenuSetName:(DeviceMenuView *)itemView;
{
    [self toast:@"编辑按钮被你点了"];
    
}

//删除设备
-(void)deviceMenuDelete:(DeviceMenuView *)itemView
{
    [self toast:@"删除按钮被你点了"];
}

- (FXW_Control *)maskView
{
    if (_maskView == nil)
    {
        _maskView = [[FXW_Control alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0.2;
    }
    return _maskView;
    
}

- (DeviceMenuView *)menuView
{
    if (_menuView == nil)
    {
        _menuView = [[DeviceMenuView alloc] initWithFrame:CGRectMake(0, screenHeight, screenWidth, _menuHeight)];
        _menuView.delegate = self;
    }
    return _menuView;
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
