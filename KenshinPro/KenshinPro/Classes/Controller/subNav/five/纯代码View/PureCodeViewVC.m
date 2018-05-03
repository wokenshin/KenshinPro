//
//  PureCodeViewVC.m
//  KenshinPro
//
//  Created by apple on 2018/5/3.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import "PureCodeViewVC.h"
#import "FriendSectionView.h"

@interface PureCodeViewVC ()

@property (nonatomic, strong) FriendSectionView *view1;

@end

@implementation PureCodeViewVC

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self test1];
    [self test2];
    
}

//JJSJIMUI 中的 分组UI
- (void)test1
{
    _view1 = [FriendSectionView jjsj_create];
    _view1.backgroundColor = [UIColor redColor];
    _view1.frame = CGRectMake(0, 60, screenWidth, 40);
    [self.view addSubview:_view1];
}

//JJSJIMUI 中的 键盘工具UI
- (void)test2
{
    
}

@end
