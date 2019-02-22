//
//  GXOCVC.m
//  KenshinPro
//
//  Created by apple on 2019/2/15.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "GXOCVC.h"
#import "NSString+FXW.h"

typedef NS_ENUM(NSUInteger, TestHaHa) {
    TestHaHa_A = 0,
    TestHaHa_B = 1 << 0,//1
    TestHaHa_C = 1 << 1,//2
    TestHaHa_D = 1 << 2,//4
    TestHaHa_E = 1 << 3,//8
    TestHaHa_F = 1 << 4,//18
};

@interface GXOCVC ()

@property (nonatomic, strong) NSString  *firstName;
@property (nonatomic, strong) NSString  *pro;

@end

@implementation GXOCVC
@synthesize firstName = kenshin;//将实例变量firstName重命名为 kenshin
@dynamic pro; //让编译器不生成实例变量 _pro 和对应的存取方法[书上说的是这样]，但是实际测试存取方法还是有的，只是实例变量没有了

- (NSString *)description
{
    return @"yo ho ho ho ho ho ho 我是控制器 GXOCVC";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self initJTiOSDevVCUI];
    
    //testCode
    TestHaHa e = [self getHaha];
    NSLog(@"按位或操作符 返回的结果是 或运算 后的结果 %lu", (unsigned long)e);
    
    //下行代码会报错 因为 @implementation中 通过 @synthesize firstName = kenshin;给属性重新命名了
    //_firstName = nil;
    
    //这里的 kenshin 其实就是属性 firstName
    kenshin = nil;
    
    //@dynamic pro; 相关代码
    //[self pro]; //虽然能调用 但是会崩溃
    //[self setPro:@"asd"];
    //_pro = nil;
    
    NSLog(@"description == %@", self);//这里输出的内容 是 description方法返回的内容
    NSLog(@"asd");
    
    NSArray *arr = @[@"kenshin", @"toma", @"naruto", @"hinato"];
    NSArray *arrCopy = [arr copy];
    NSMutableArray *arrMCopy = [arr mutableCopy];
    NSLog(@"原对象%p", arr);
    NSLog(@"浅拷贝%p", arrCopy);
    NSLog(@"深拷贝%p", arrMCopy);
    NSLog(@"浅拷贝%p", [arrMCopy copy]);
    
}

- (void) initJTiOSDevVCUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"iOS开发进阶";
    [self.view addSubview:self.tableView];
    //因为底部短啦 所以修改下
    self.tableView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
}


- (void)loadData{
    
    [self addDataWithTitle:@"异或运算" andDetail:@"2019-2-19"];
    [self addDataWithTitle:@"方法调配 method swizzling" andDetail:@"2019-2-20"];
    [self addDataWithTitle:@"分类 便于调试" andDetail:@"debug 看回溯"];
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
    if ([title isEqualToString:@"分类 便于调试"]) {
        NSLog(@"kenshin md5 后 == %@", [@"kenshin" fxw_md5]);
        return;
    }
    if ([title isEqualToString:@"方法调配 method swizzling"]) {
        
        NSString *strTest = @"ABC";
        NSLog(@"uppercaseString :%@", [strTest uppercaseString]);
        NSLog(@"lowercaseString :%@", [strTest lowercaseString]);
        
        //获取OC类的方法
        Method originalMethod = class_getInstanceMethod([NSString class], @selector(lowercaseString));
        Method swappedMethod  = class_getInstanceMethod([NSString class], @selector(uppercaseString));
        //方法互换
        method_exchangeImplementations(originalMethod, swappedMethod);
        
        NSLog(@"uppercaseString :%@", [strTest uppercaseString]);
        NSLog(@"lowercaseString :%@", [strTest lowercaseString]);
        
    }
    if ([title isEqualToString:@"异或运算"]) {
        NSUInteger x = 2;//0010
        NSUInteger y = 3;//0011
        //0001
        NSUInteger z = 4;//0100
        //0101 == 5
        NSUInteger r = x ^ y ^ z; //异或运算 相同为0 不同为1
        NSLog(@"%lu", r);
        
    }
    [self toast:[NSString stringWithFormat:@"未找到对应VC 点击了:%@", title]];
}

- (TestHaHa)getHaha{
    return TestHaHa_A | TestHaHa_B | TestHaHa_D | TestHaHa_E;
}

@end
