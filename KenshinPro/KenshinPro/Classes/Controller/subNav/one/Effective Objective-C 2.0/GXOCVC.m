//
//  GXOCVC.m
//  KenshinPro
//
//  Created by apple on 2019/2/15.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "GXOCVC.h"

@interface GXOCVC ()

@end

@implementation GXOCVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self initJTiOSDevVCUI];
    
}

- (void) initJTiOSDevVCUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"iOS开发进阶";
    [self.view addSubview:self.tableView];
    //因为底部短啦 所以修改下
    self.tableView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
}


- (void)loadData{
    
    [self addDataWithTitle:@"" andDetail:@"2019-2-116"];
    //倒叙[这样就是时间升序啦]
    self.mArrData =  (NSMutableArray *)[[self.mArrData reverseObjectEnumerator] allObjects];
    
    
}

- (void)clickCellWithTitle:(NSString *)title{
    
    if ([title isEqualToString:@""]) {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    [self toast:[NSString stringWithFormat:@"未找到对应VC 点击了:%@", title]];
}




@end
