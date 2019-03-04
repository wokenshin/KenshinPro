//
//  MSVC.m
//  KenshinPro
//
//  Created by apple on 2019/3/1.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "MSVC.h"
#import "OCFSJZVC.h"

@interface MSVC ()

@end

@implementation MSVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self initJTiOSDevVCUI];
}

- (void) initJTiOSDevVCUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"面试";
    [self.view addSubview:self.tableView];
    //因为底部短啦 所以修改下
    self.tableView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
}


- (void)loadData{
    
    [self addDataWithTitle:@"说一下OC的反射机制" andDetail:@"2019-3-1"];
    
    //倒叙[这样就是时间升序啦]
    self.mArrData =  (NSMutableArray *)[[self.mArrData reverseObjectEnumerator] allObjects];
    
}

- (void)clickCellWithTitle:(NSString *)title{
    
    if ([title isEqualToString:@"说一下OC的反射机制"]) {
        OCFSJZVC *vc = [[OCFSJZVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    [self toast:[NSString stringWithFormat:@"未找到对应VC 点击了:%@", title]];
}

@end
