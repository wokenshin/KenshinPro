//
//  ViewControllerThree.m
//  KenshinPro
//
//  Created by kenshin on 17/3/24.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "ViewControllerThree.h"
#import "ViewControllerOne.h"

@interface ViewControllerThree ()

@property (nonatomic, strong) FXW_Button                    *btnPop;
@property (nonatomic, strong) FXW_TextField                 *text;

@end

@implementation ViewControllerThree

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"第三个VC";
    
    _text = [[FXW_TextField alloc] initWithFrame:CGRectMake(30, 100, screenWidth - 60, 36)];
    _text.backgroundColor = [UIColor yellowColor];
    _text.placeholder = @"请输入pop传值类容";
    
    _btnPop = [[FXW_Button alloc] initWithFrame:CGRectMake(30, 156, screenWidth - 60, 36)];
    _btnPop.backgroundColor = colorDdzmBlueBtn;
    [_btnPop setTitle:@"popToViewControloerOne" forState:UIControlStateNormal];
    
    [self.view addSubview:_text];
    [self.view addSubview:_btnPop];
    
    WS(ws);
    [_btnPop clickButtonWithResultBlock:^(FXW_Button *button) {
        ViewControllerOne *vc = (ViewControllerOne *)[ws getViewControllerWithClass:[ViewControllerOne class]];
        if (vc)
        {
            vc.lab.text = ws.text.text;
            [ws.navigationController popToViewController:vc animated:YES];
        }
        else
        {
            [ws toast:@"pop失败"];
        }
    }];
    
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
