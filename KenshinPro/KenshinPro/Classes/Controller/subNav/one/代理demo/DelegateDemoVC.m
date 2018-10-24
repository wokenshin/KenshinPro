//
//  DelegateDemoVC.m
//  KenshinPro
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import "DelegateDemoVC.h"
#import "MyDelegate.h"
#import "Tools.h"

@interface DelegateDemoVC ()<CustomNameDelegate>

@property (nonatomic, strong) MyDelegate *delDemo;

@end

@implementation DelegateDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [Tools toast:@"看控制台" andCuView:self.view andHeight:screenHeight/2];
    
    
    
    _delDemo = [MyDelegate alloc];
    _delDemo.delegate = self;//【第三部】绑定代理
    [_delDemo doSomething];

    
    [self addToolbar];
}

#pragma mark - 代理
- (void)myDelegateOptional{
    NSLog(@"触发：myDelegateOptional");
}

- (void)myDelegateRequired{
    NSLog(@"触发：myDelegateRequired");
}

-(void)addToolbar
{
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                  target:nil action:nil];
    UIBarButtonItem *customItem1 = [[UIBarButtonItem alloc]
                                    initWithTitle:@"Tool1" style:UIBarButtonItemStyleBordered
                                    target:self action:@selector(toolBarItem1:)];
    UIBarButtonItem *customItem2 = [[UIBarButtonItem alloc]
                                    initWithTitle:@"Tool2" style:UIBarButtonItemStyleDone
                                    target:self action:@selector(toolBarItem2:)];
    NSArray *toolbarItems = [NSArray arrayWithObjects:
                             customItem1,spaceItem, customItem2, nil];
    UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:
                          CGRectMake(0, screenHeight - 50, screenWidth, 50)];
    
    [toolbar setBarStyle:UIBarStyleBlackOpaque];
    [self.view addSubview:toolbar];
    [toolbar setItems:toolbarItems];
}

- (void)toolBarItem1:(id)obj{
    NSLog(@"1");
}

- (void)toolBarItem2:(id)obj{
    NSLog(@"2");
}

@end
