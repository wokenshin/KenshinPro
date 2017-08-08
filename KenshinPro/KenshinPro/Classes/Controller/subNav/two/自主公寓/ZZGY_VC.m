//
//  ZZGY_VC.m
//  KenshinPro
//
//  Created by kenshin on 2017/7/31.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "ZZGY_VC.h"
#import "AddressPickerVC.h"

#import "MDButton.h"
#import "FXW_AptBtn.h"

@interface ZZGY_VC ()

@property (nonatomic, strong) MDButton                      *btnAdd;//"+"号 按钮
@property (nonatomic, strong) FXW_AptBtn                    *btnMenuAddApt;
@property (nonatomic, strong) FXW_AptBtn                    *btnMenuAddRoom;

@end

@implementation ZZGY_VC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initZZGYUI];
    
}

- (void)initZZGYUI
{
    WS(ws);
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"自主公寓";
    UILabel *labTips  = [[UILabel alloc] initWithFrame:CGRectMake(10, 74, screenWidth - 20, 50)];
    labTips.textColor = [UIColor redColor];
    labTips.numberOfLines = 0;
    labTips.text = @"注意！当自定义View添加到有xib的VC时，需要删除xib或者将自定义View添加到UIView上";
    [self.view addSubview:labTips];
    //eg [view addSubView:yourXibView];
    
    //+号按钮
    _btnAdd = [[MDButton alloc] initWithFrame:CGRectMake(screenWidth - 80, screenHeight - 80, 50, 50) type:MDButtonTypeFloatingAction rippleColor:[UIColor whiteColor]];
    [_btnAdd setType:3];
    [_btnAdd setImageNormal:[UIImage imageNamed:@"+"]];
    [_btnAdd setImageRotated:[UIImage imageNamed:@"x"]];
    _btnAdd.backgroundColor = RGB2Color(250, 58, 67);//橘色
    [_btnAdd addTarget:self action:@selector(clickAddBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnAdd];
    
    CGFloat btnW = 140;
    CGFloat btnX = screenWidth - btnW - 30;
    CGFloat btnH = 50;
    CGFloat btnY = screenHeight - 140;
    
    _btnMenuAddApt = [[FXW_AptBtn alloc] initWithFrame:CGRectMake(btnX, btnY - (btnH + 10), btnW, btnH)
                                                 title:@"地区选择器"
                                               imgName:@"btn_house_nor"];
    
    _btnMenuAddRoom = [[FXW_AptBtn alloc] initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)
                                                  title:@"录入房间"
                                                imgName:@"btn_consumer_nor"];
    
    _btnMenuAddApt.alpha  = 0.0f;
    _btnMenuAddRoom.alpha = 0.0f;
    [self.view addSubview:_btnMenuAddApt];
    [self.view addSubview:_btnMenuAddRoom];
    
#pragma mark +号按钮 菜单时间
    [_btnMenuAddApt click:^(FXW_AptBtn *cuObj) {
        AddressPickerVC *vc = [[AddressPickerVC alloc] init];
        [ws.navigationController pushViewController:vc animated:YES];
        
    }];
    
    //录入房间
    [_btnMenuAddRoom click:^(FXW_AptBtn *cuObj) {
        [ws toast:@"add room"];
    }];

}

- (void)clickAddBtn
{
    CGFloat duration = 0.5f;
    if (!_btnAdd.isRotated)//弹出
    {
        [UIView animateWithDuration:duration
                              delay:0.0
                            options: (UIViewAnimationOptionAllowUserInteraction|UIViewAnimationCurveEaseOut)
                         animations:^{
                             
                             _btnMenuAddApt.alpha = 1;
                             _btnMenuAddApt.transform = CGAffineTransformMakeScale(1.0,.7);
                             _btnMenuAddApt.transform = CGAffineTransformConcat(CGAffineTransformMakeTranslation(0, -10), CGAffineTransformMakeScale(1.0, 1.0));
                             
                             _btnMenuAddRoom.alpha = 1;
                             _btnMenuAddRoom.transform = CGAffineTransformMakeScale(1.0,.8);
                             _btnMenuAddRoom.transform = CGAffineTransformConcat(CGAffineTransformMakeTranslation(0, -10), CGAffineTransformMakeScale(1.0, 1.0));
                             
                         } completion:^(BOOL finished) {
                             
                         }];
    }
    else//关闭
    {
        [UIView animateWithDuration:duration/2
                              delay:0.0
                            options: kNilOptions
                         animations:^{
                             
                             _btnMenuAddApt.alpha = 0;
                             _btnMenuAddApt.transform = CGAffineTransformMakeTranslation(0, 0);
                             
                             _btnMenuAddRoom.alpha = 0;
                             _btnMenuAddRoom.transform = CGAffineTransformMakeTranslation(0, 0);
                             
                         } completion:^(BOOL finished) {
                             
                         }];
    }

}

@end
