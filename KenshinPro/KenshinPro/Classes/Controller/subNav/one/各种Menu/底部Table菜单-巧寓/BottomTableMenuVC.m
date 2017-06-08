//
//  BottomTableMenuVC.m
//  KenshinPro
//
//  Created by kenshin on 2017/6/8.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "BottomTableMenuVC.h"
#import "FXW_TableMenu.h"
@interface BottomTableMenuVC ()

@end

@implementation BottomTableMenuVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"公寓锁项目";
    
}

- (IBAction)clickOne:(id)sender
{
    FXW_TableMenu *menu = [FXW_TableMenu fxwWithTitle:@"选择性别" array:@[@"男", @"女"]];
    [menu clickCellWithResultblock:^(NSInteger index) {
        NSLog(@"%ld", index);
    }];
}

- (IBAction)clickTwo:(id)sender
{
    FXW_TableMenu *menu = [FXW_TableMenu fxwWithTitle:@"选择房间" array:@[@"1", @"2",@"3",@"4"]];
    [menu clickCellWithResultblock:^(NSInteger index) {
        NSLog(@"%ld", index);
    }];
    
}
- (IBAction)clickThree:(id)sender
{
    FXW_TableMenu *menu = [FXW_TableMenu fxwWithTitle:@"选择数字"
                                                array:@[@"1",@"2",@"3",@"4",@"5",
                                                                      @"6",@"7",@"8",@"9",@"10",
                                                                      @"11",@"12",@"13",@"14",@"15",
                                                                      @"16",@"17",@"18",@"19",@"20"]];
    [menu clickCellWithResultblock:^(NSInteger index) {
        NSLog(@"%ld", index);
    }];
    
}

@end
