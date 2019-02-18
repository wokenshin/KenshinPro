//
//  IOSKFJJVC.m
//  KenshinPro
//
//  Created by apple on 2019/2/11.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "IOSKFJJVC.h"
#import "PasswordInpudWindow.h"
#import "CoreTextVCV.h"
#import <objc/runtime.h>
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
    [self addDataWithTitle:@"CoreText排版引擎" andDetail:@"2019-2-13"];
    [self addDataWithTitle:@"动态创建对象 runtime" andDetail:@"点一次看日志|点两次会崩溃"];
    [self addDataWithTitle:@"Targed Pointer" andDetail:@"2019-2-15"];
    
    
    
    //倒叙[这样就是时间升序啦]
    self.mArrData =  (NSMutableArray *)[[self.mArrData reverseObjectEnumerator] allObjects];
    
    
}

- (void)clickCellWithTitle:(NSString *)title{
    if ([title isEqualToString:@"Targed Pointer"]) {
        @autoreleasepool {
            NSNumber *number1 = @1;
            NSNumber *number2 = @2;
            NSNumber *number3 = @3;
            NSNumber *numberFFFF = @(0xFFFF);
            
            NSLog(@"number1 point is %p", number1);
            NSLog(@"number2 point is %p", number2);
            NSLog(@"number3 point is %p", number3);
            NSLog(@"numberffff point is %p", numberFFFF);
        }
        
        return;
    }
    if ([title isEqualToString:@"动态创建对象 runtime"]) {
        //import #import <objc/runtime.h>
        //创建一个名为 HAHAView 的类，它是UIView的子类
        Class newClass = objc_allocateClassPair([UIView class], "HAHAView", 0);
        //为该类增加一个名为report的方法 这里的 ReportFunction 本类底部有定义
        class_addMethod(newClass, @selector(report), (IMP)ReportFunction, "v@:");
        //注册该类
        objc_registerClassPair(newClass);
        
        //创建一个类的实例
        id instanceOfNewClass = [[newClass alloc] init];
        
        //调用 report方法
        [instanceOfNewClass performSelector:@selector(report)];
        
        return;
    }
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
    if ([title isEqualToString:@"CoreText排版引擎"]) {
        CoreTextVCV *vc = [[CoreTextVCV alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    [self toast:[NSString stringWithFormat:@"未找到对应VC 点击了:%@", title]];
}

void ReportFunction(id self, SEL _cmd){
    NSLog(@"This object is %p.", self);
    NSLog(@"Class is %@, and super is %@.", [self class], [self superclass]);
    
    Class currentClass = [self class];
    for (int i = 1; i < 5; i++) {
        NSLog(@"Following the isa pointer %d times gives %p", i, currentClass);
        currentClass = object_getClass(currentClass);
    }
    NSLog(@"NSObject's class is %p", [NSObject class]);
    NSLog(@"NSObject's meta class is %p", object_getClass([NSObject class]));
}

@end

