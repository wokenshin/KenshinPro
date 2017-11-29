//
//  RuntimeVC.m
//  KenshinPro
//
//  Created by kenshin on 2017/11/8.
//  Copyright © 2017年 Kenshin. All rights reserved.
/*
 本文资源来自：http://www.jianshu.com/p/19f280afcb24 【iOS 模块详解—「Runtime面试、工作」看我就 🐒 了 ^_^.】
 
 另外资源：http://www.jianshu.com/p/6b905584f536 【Runtime完整总结】
 
 */

#import "RuntimeVC.h"
#import <objc/message.h>//导入系统的头文件，一般用尖括号
//消息机制方法提示默认是没有的 需要进行配置【查找build setting -> 搜索msg -> objc_msgSend（YES --> NO）】
#import "Person.h"
#import "UIImage+Runtime.h"
#import "NSObject+Runtime.h"
#import "ModelRuntime.h"
#import "CodingRuntime.h"

@interface RuntimeVC ()<UITableViewDelegate>//这里的协议仅仅是为了让 runtime获取当亲类的协议而设置

@end

@implementation RuntimeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Runtime";
    
}

#pragma mark runtime调用私有方法
- (IBAction)clickCallPrivateFunction:(id)sender
{
    [self callPrivateFunctionByRuntime];
    
}

#pragma mark runtime交换方法
- (IBAction)clickCallExchangeFunction:(id)sender
{
    [self exchangeFunctionByRuntime];
    
}

#pragma mark runtime 给分类动态添加属性
- (IBAction)clickRuntimeDynamicAddPro:(id)sender
{
    [self runtimeDynamicAddPro];
    
}

#pragma mark runtime 字典转模型
- (IBAction)clickDicToModelByRuntime:(id)sender
{
    [self runtimeDicToModel];
    
}

#pragma mark runtime 自动归档
- (IBAction)clickGDByRuntime:(id)sender
{
    [self runtimeGD];
}

#pragma mark runtime 自动解档
- (IBAction)clickJDByRuntime:(id)sender
{
    [self runtimeJD];
}

#pragma mark runtime 获取类的属性名称列表
- (IBAction)clickGetPropertyListInClass:(id)sender
{
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (unsigned int i = 0; i<count; i++)
    {
        const char *propertyName = property_getName(propertyList[i]);
        NSLog(@"property---->%@", [NSString stringWithUTF8String:propertyName]);
    }
    
}

#pragma mark 获取方法列表
- (IBAction)clickgetFunctionList:(id)sender
{
    //如果方法没有实现，那么及时声明了 runtime也获取不到该方法【都没实现 获取来有毛用】
    unsigned int count;
    Method *methodList = class_copyMethodList([self class], &count);
    for (unsigned int i; i<count; i++)
    {
        Method method = methodList[i];
        NSLog(@"method---->%@", NSStringFromSelector(method_getName(method)));
    }
    
}

#pragma mark 获取成员变量列表
- (IBAction)clickget_proList:(id)sender
{
    unsigned int count;
    Ivar *ivarList = class_copyIvarList([self class], &count);
    for (unsigned int i; i<count; i++)
    {
        Ivar myIvar = ivarList[i];
        const char *ivarName = ivar_getName(myIvar);
        NSLog(@"Ivar---->%@", [NSString stringWithUTF8String:ivarName]);
    }
    
}

#pragma mark 获取协议列表
- (IBAction)clickgetProtocolList:(id)sender
{
    unsigned int count;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([self class], &count);
    
    for (unsigned int i; i<count; i++)
    {
        Protocol *myProtocal     = protocolList[i];
        const char *protocolName = protocol_getName(myProtocal);
        NSLog(@"protocol---->%@", [NSString stringWithUTF8String:protocolName]);
    }

}

#pragma mark - 调用私有函数
- (void)callPrivateFunctionByRuntime
{
    //说明: fxw_eat(无参) 和 fxw_run(有参) 是 Person类中的私有方法「可以帮我调用私有方法」；
    // Person *p = [Person alloc];
    // 底层的实际写法
    
    //注意下面的代码在调用之前 需要做xcode 进行配置 【查找build setting -> 搜索msg -> objc_msgSend（YES --> NO）】因为xcode 默认不允许程序员这么干
    Person *p = objc_msgSend(objc_getClass("Person"), sel_registerName("alloc"));
    
    // p = [p init];
    p = objc_msgSend(p, sel_registerName("init"));
    
    // 调用对象方法（本质：向对象发送消息）
    //[p fxw_eat];
    
    // 本质：向类对象发送消息
    objc_msgSend(p, @selector(fxw_eat));
    
    ((void (*) (id, SEL, NSString *)) (void *)objc_msgSend)(p, sel_registerName("fxw_run:"), @"你大爷");
    
    
    // 默认person，没有实现fxw_run:方法，可以通过performSelector调用
    [p performSelector:@selector(fxw_run:) withObject:@"你妹"];
    
}

#pragma mark 交换方法
- (void)exchangeFunctionByRuntime
{
//    实现步骤：
//
//    1.给系统的方法添加分类-----------> UIImage+Runtime
//    2.自己实现一个带有扩展功能的方法
//    3.交换方法,只需要交换一次,
    NSLog(@"可以查看 UIImage+Runtime 分类 了解 交换方法的实现");
    UIImage *img  = [UIImage imageNamed:@"launch_baidu"];
    UIImage *img2 = [UIImage imageNamed:@"没有这张图"];
    
}

#pragma mark 给分类动态添加属性
- (void)runtimeDynamicAddPro
{
    /*
     原理：给一个类声明属性，其实本质就是给这个类添加关联，并不是直接把这个值的内存空间添加到类存空间。
     
     应用场景：给系统的类添加属性的时候,可以使用runtime动态添加属性方法。
     注解：系统 NSObject 添加一个分类，我们知道在分类中是不能够添加成员属性的，虽然我们用了@property，
     但是仅仅会自动生成get和set方法的声明，并没有带下划线的属性和方法实现生成。但是我们可以通过runtime就可以做到给它方法的实现。【可以将分类中的实现注释掉来测试 会运行时崩溃】
     
     需求：给系统 NSObject 类动态添加属性 name 字符串。
     */
    // 调用
    NSObject *objc = [[NSObject alloc] init];
    objc.name = @"123";
    NSLog(@"runtime动态添加属性name==%@",objc.name);
    
    /*
     总结：其实，给属性赋值的本质，就是让属性与一个对象产生关联，所以要给NSObject的分类的name属性赋值就是让name和NSObject产生关联，而runtime可以做到这一点
     */
}

#pragma mark 字典转模型
- (void)runtimeDicToModel
{
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
    [mDic setObject:@"kenshin"    forKey:@"name"];
    [mDic setObject:@"boy"        forKey:@"gender"];
    [mDic setObject:@"basketball" forKey:@"没有这个key"];
    
    
    //简单的 字典转模型
    ModelRuntime *model = [ModelRuntime modelWithDict:mDic];
    
    //字典嵌套字典
    NSMutableDictionary *subMDic = [[NSMutableDictionary alloc] init];
    [subMDic setObject:@"wlsx" forKey:@"big"];
    [subMDic setObject:@"xyjy" forKey:@"midel"];
    [subMDic setObject:@"bjqs" forKey:@"three"];
    
    [mDic setObject:subMDic forKey:@"wife"];
    //字典转模型 字典中还嵌套有字典
    ModelRuntime *model2 = [ModelRuntime modelWithDict2:mDic];
    NSLog(@"");
    
    //还有其他嵌套的情况 这里就不做详细介绍了
    model  = nil;
    model2 = nil;
    
}

#pragma mark 自动归档
- (void)runtimeGD
{
    CodingRuntime *model = [[CodingRuntime alloc] init];
    model.name   = @"きぼう";
    model.gender = @"男";
    model.age    = 18;
    
    // 2.归档模型对象
    // 2.1.获得Documents的全路径
    NSString *doc  = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [doc stringByAppendingPathComponent:@"CodingRuntime.data"];// 2.2.获得文件的全路径
    BOOL flag      = [NSKeyedArchiver archiveRootObject:model toFile:path];// 2.3.将对象归档
    if (flag)
    {
        [self toastBottom:@"归档成功"];
    }
    else
    {
        [self toastBottom:@"归档失败"];
    }
}

#pragma mark 自动解档
- (void)runtimeJD
{
    NSString     *doc  = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];// 1.获得Documents的全路径
    NSString     *path = [doc stringByAppendingPathComponent:@"CodingRuntime.data"];// 2.获得文件的全路径
    CodingRuntime *stu = [NSKeyedUnarchiver unarchiveObjectWithFile:path];// 3.从文件中读取CusModel对象
    if (stu)
    {
        [self toastBottom:stu.name];
        NSLog(@"%@", stu.name);
    }
    else
    {
        [self toastBottom:@"请先归档后再解档"];
    }
    
}

//如果方法没有实现，那么及时声明了 runtime也获取不到该方法【都没实现 获取来有毛用】
- (void)test1{}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end

