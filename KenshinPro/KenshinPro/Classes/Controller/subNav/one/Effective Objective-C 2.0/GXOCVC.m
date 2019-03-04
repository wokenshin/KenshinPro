//
//  GXOCVC.m
//  KenshinPro
//
//  Created by apple on 2019/2/15.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "GXOCVC.h"
#import "NSString+FXW.h"
#import "NSTimer+FXW.h"

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

@property (nonatomic, strong) NSString  *blockPro;
@property (nonatomic, strong) NSTimer   *timer;
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
    [self addDataWithTitle:@"block" andDetail:@"2019-2-26"];
    [self addDataWithTitle:@"多用块枚举，少用for循环" andDetail:@"这里有OC 1.0的枚举器遍历"];
    [self addDataWithTitle:@"快速遍历 即 for in" andDetail:@"这里有OC 2.0的快速遍历"];
    [self addDataWithTitle:@"基于块的遍历方式" andDetail:@"2019-2-27"];
    [self addDataWithTitle:@"无缝桥接" andDetail:@"2019-2-27"];
    [self addDataWithTitle:@"NSTimer 块实现 防止保留环" andDetail:@"2019-2-28"];
    //倒叙[这样就是时间升序啦]
    self.mArrData =  (NSMutableArray *)[[self.mArrData reverseObjectEnumerator] allObjects];
    
    
}

- (void)fxw_timerFunction{
    NSLog(@"我是timer触发的重复任务 哈哈哈哈!!! dealloc时会弄死我");
}

- (void)clickCellWithTitle:(NSString *)title{
    
    if ([title isEqualToString:@""]) {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if ([title isEqualToString:@"NSTimer 块实现 防止保留环"]) {
        __weak GXOCVC *weakSelf = self;
        _timer = [NSTimer fxw_timerWithInterval:3.0 block:^{
            //不知道为什么要多此一步 书上是这么写的，但是实际测试 直接用weakSelf也是OK的
            //原因：
            //__weak 本身是可以避免循环引用的问题的，但是其会导致外部对象释放了之后，block 内部也访问不到这个对象的问题，我们可以通过在 block 内部声明一个 __strong 的变量来指向 weakObj，使外部对象既能在 block 内部保持住，又能避免循环引用的问题。
            //但是个人觉得 只要保证weak修饰的内容释放后block不会触发，那么是可以只需要使用weak的
            GXOCVC *strogSelf = weakSelf;
//            [weakSelf fxw_timerFunction];
            [strogSelf fxw_timerFunction];
        } repeats:YES];
        return;
    }
    if ([title isEqualToString:@"无缝桥接"]) {
        NSArray *anNSArray = @[@1, @2, @3, @4, @5];
        CFArrayRef aCFArray = (__bridge CFArrayRef)anNSArray;
        NSLog(@"Size of array = %li", CFArrayGetCount(aCFArray));
        return;
    }
    if ([title isEqualToString:@"基于块的遍历方式"]) {
        //oc中国最新引入的一种便利方式[2017年时]
        NSArray *arr = @[@"hong", @"xu", @"ting", @"ling", @"li"];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"%@", obj);
            if (stop) {
                *stop = YES;
            }
        }];
        //NSSet 和NSDictionary 中也有类似的方法
        return;
    }
    if ([title isEqualToString:@"快速遍历 即 for in"]) {
        NSArray *arr = @[@"hong", @"xu", @"ting", @"ling", @"li"];
        for (NSString *str in arr) {
            NSLog(@"%@", str);
        }
        
        //遍历字典 和 set也很简单
        NSDictionary *dic = @{@"name":@"kenshin",
                              @"age":@"29",
                              @"money":@"15w",
                              @"salary":@"2w"};
        for (id key in dic) {
            NSLog(@"%@", dic[key]);
        }
        
        
        return;
    }
    if ([title isEqualToString:@"多用块枚举，少用for循环"]) {
        NSArray *anArray = @[@"9", @"5", @"2", @"7"];
        NSEnumerator *enumerator = [anArray objectEnumerator];
        NSString *num;
        while ((num = [enumerator nextObject])!= nil) {
            NSLog(@"%@", num);
        }
        
        //上面是 枚举器 的写法，它的真正优势在于无论便利哪种集合都可以采用这套相似的语法
        //比如字典、set
        NSDictionary *dic = @{@"name":@"kenshin",
                              @"age":@"29",
                              @"money":@"15w",
                              @"salary":@"2w"};
        
        NSEnumerator *eDic = [dic keyEnumerator];//注意这里是 keyEnumerator
        NSString *key = nil;
        while ((key = [eDic nextObject]) != nil) {
            NSLog(@"%@=%@", key, dic[key]);
        }
        return;
    }
    if ([title isEqualToString:@"block"]) {
        //block
        ^{
            NSLog(@"这就是一个block 为什么不会执行呢？");
        };
        
        void (^someBlock) () = ^{
            NSLog(@"这也是一个block");
        };
        
        someBlock();
        
        //block类型的语法结构如下
        //return_type (^block_name)(parameters)
        
        //如下 返回值 int 并且接受两个int参数
        int (^addBlock)(int a, int b) = ^(int a, int b){
            //在块中默认可以访问实例变量，但是不能直接访问，那样会发生循环引用
            self->_blockPro = @"kenshin";
            
            return a+b;
        };
        
        int sum = addBlock(100, 200);
        NSLog(@"addBlock(100, 200) == %d", sum);
        
        //使用块以外的变量
        int additional = 5;
        
        //修改块以外的变量
        __block int x = 5;
        
        int (^addBlock2)(int a, int b) = ^(int a, int b){
            //additional = 15; 默认是不允许修改块以外的变量的 如果要修改需要在变量前面加上 __block修饰
            x = 0;
            return a + b + additional + x;
        };
        
        int sum2 = addBlock2(100, 200);
        NSLog(@"addBlock2(100, 200) == %d", sum2);
        
        
        NSArray *array = @[@0, @1, @2, @3, @4, @5];
        __block NSInteger count = 0;
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj compare:@2] == NSOrderedAscending) {
                count++;
            }
        }];
        NSLog(@"数组中小于2的个数 count == %ld", (long)count);
        
        //全局块、栈块及堆块
        
        
        void (^block)(void);
        if (_blockPro == nil) {
            block = ^{
                NSLog(@"Block A");
            };
        } else {
            block = ^{
                NSLog(@"Block B");
            };
        }
        
        block();
        NSLog(@"《Effectivc Objective-C 2.0》153页 说的可能会崩溃 但是测试的时候没有崩溃 或许是伪代码不够垃圾");
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

- (void)dealloc
{
    [_timer invalidate];
    NSLog(@"GXOCVC释放🐦!");
}
@end
