//
//  TextContentVC.m
//  KenshinPro
//
//  Created by kenshin on 2017/8/8.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "TextContentVC.h"
#import "TextImgVC.h"

@interface TextContentVC ()

@end

@implementation TextContentVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    [self initTextContentVCUI];
    
}

- (void)initTextContentVCUI
{
    self.navigationItem.title = @"文本框";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    
    
}

- (void)loadData
{
    [self addDataWithTitle:@"带图片的文本框" andDetail:@""];

}

- (void)clickCellWithTitle:(NSString *)title
{
    if ([title isEqualToString:@"带图片的文本框"])
    {
        TextImgVC *vc = [[TextImgVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
