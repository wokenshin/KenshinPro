//
//  IOSKFJJVC.m
//  KenshinPro
//
//  Created by apple on 2019/2/11.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "IOSKFJJVC.h"
#import "PasswordInpudWindow.h"

@interface IOSKFJJVC ()

@property (nonatomic, strong) UIWindow  *window;

@end

@implementation IOSKFJJVC

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
    
    [self addDataWithTitle:@"循环引用" andDetail:@"2019-2-12"];
    [self addDataWithTitle:@"UIWindow" andDetail:@"2019-2-12"];
    [self addDataWithTitle:@"UIWindow 密码锁功能" andDetail:@"2019-2-12"];
    
    
    
    //倒叙[这样就是时间升序啦]
    self.mArrData =  (NSMutableArray *)[[self.mArrData reverseObjectEnumerator] allObjects];
    
    
}

- (void)clickCellWithTitle:(NSString *)title{
    
    if ([title isEqualToString:@"循环引用"]) {
        NSMutableArray *firsteArray = [NSMutableArray array];
        NSMutableArray *secondArray = [NSMutableArray array];
        //相互引用了对方 构成了循环引用 可以使用Instrument->Leaks 定位循环引用
        [firsteArray addObject:secondArray];
        [secondArray addObject:firsteArray];
        return;
    }
    if ([title isEqualToString:@"UIWindow"]) {
        //UIWindow一旦被创建出来就会被添加到整个界面上去
        _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _window.windowLevel = UIWindowLevelNormal;
        _window.backgroundColor = [UIColor redColor];
        _window.hidden = NO;
        
        WS(ws);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            ws.window.hidden = YES;
            ws.window = nil;
        });
        return;
    }
    if ([title isEqualToString:@"UIWindow 密码锁功能"]) {
        [[PasswordInpudWindow shareInstance] show];
        return;
    }
    if ([title isEqualToString:@"UIWindow"]) {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    [self toast:[NSString stringWithFormat:@"未找到对应VC 点击了:%@", title]];
}

@end
