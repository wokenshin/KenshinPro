//
//  OCFSJZVC.m
//  KenshinPro
//
//  Created by apple on 2019/3/1.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "OCFSJZVC.h"


/**
 说明
 前三个按钮方法知识点来自：https://www.cnblogs.com/lltcom/p/5893738.html 【感觉太浅显了】
 第四个按钮方法只是点来自：https://www.cnblogs.com/goodboy-heyang/p/5080901.html【内容偏向实战一些】
 最后来自：             https://www.jianshu.com/p/5bbde2480680【最佳】
 */
@interface OCFSJZVC ()<UITableViewDelegate>

@end

@implementation OCFSJZVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"OC反射机制";
}

- (IBAction)clickBtn_getClass:(id)sender {
    
    // 1.通过字符串来获得Class
    Class className = NSClassFromString(@"OCFSJZVC");
    NSLog(@"%@", className);
    
    // 2.直接使用Class来创建 一般情况之下我们都用这种方式创建对象
    OCFSJZVC *p = [[OCFSJZVC alloc] init];
    NSLog(@"%@", p);
    
    // 通过实例对象获得Class
    NSLog(@"%@", [p class]);
    
    // 3.通过类来获得Class
    NSLog(@"OCFSJZVC.Class = %@", [OCFSJZVC class]);
    
}

- (IBAction)clickBtn_checkExtendsRelationship:(id)sender {
    
    // NSObject提供的了一下几个方法可供一般（继承于NSObject）的对象直接调用
    // 通过对象来判断该对象的Class
    OCFSJZVC *p = [[OCFSJZVC alloc] init];
    NSLog(@"[p class] =  %@", [p class]);
    
    // 判断对象是否为某个类的实例对象
    NSLog(@"p是否是OCFSJZVC的实例对象：%d", [p isMemberOfClass:OCFSJZVC.class]);
    
    // 判断实例对象是都为某个类及其子类的实例
    NSLog(@"[person isKindOfClass:[OCFSJZVC class]] = %d ", [p isKindOfClass:[OCFSJZVC class]]);
    
    // 判断的实例对象是否实现了指定的协议
    NSLog(@"判断的实例对象是否实现了指定的协议:%d", [p conformsToProtocol:@protocol(UITableViewDelegate)]);
    
}

- (IBAction)clickBtn_dynamicFunc:(id)sender {
    
    // 此处希望能动态的调用move方法
    // 使用 performSelector: withObject: 动态的调用move:方法
    
    [self performSelector:@selector(move:) withObject:@"kenshin"];
    
    [self performSelector:NSSelectorFromString(@"move:") withObject:@"Toma"];
    
    
    
    // 使用objc_msgSend 进行实现方法
    objc_msgSend(self, @selector(move:), @"Fantasy");
    
    objc_msgSend(self, @selector(test:andNum:), @"孙悟空", @"布玛");
}

- (void)move:(NSString *)str{
    NSLog(@"moveFunction:%@",str);
}

- (void)test:(NSString *)a andNum:(NSString *)b{
    NSLog(@"test:%@, andNum:%@", a, b);
}

#pragma mark -
- (IBAction)clickBtnFirstOCReflection:(id)sender {
    
    //可以验证，当不存在这个FXW类时，创建的Class是null
    Class FXW = NSClassFromString(@"FXW");
    NSLog(@"因为没有FXW类，所以fxw是:%@", FXW);
    
    //使用这个null创建的id对象也是null
    id noFXW = [[FXW alloc] init];
    if (noFXW == nil) {
        NSLog(@"因为没有FXW类，null对象是:%@", noFXW);
    }
    
    //动态编译使用存在的类创建Class和对象
    //注意本类并未导入 FSJZ_Person.h
    Class clazz = NSClassFromString(@"FSJZ_Person");
    NSLog(@"FSJZ_Person存在，所以clazz是:%@", clazz);
    
    id c = [[clazz alloc] init];
    NSLog(@"用FSJZ_Person Class创建的对象:%@", c);
    
    //动态调用其方法，而且是所谓的“私有”方法
    //仅仅在@implementation中实现了此方法，没有在@interface中声明该方法
    //但是可以动态的使用该方法，验证得到：OC中没有绝对的私有方法
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wundeclared-selector"
    if ([c respondsToSelector:@selector(fxw_private_function)]) {
        [c performSelector:@selector(fxw_private_function) withObject:nil];
    }
    #pragma clang diagnostic pop
    
    /*
     提醒：
     关于那个黄色字体"#pragma......"是用于让相关的警告不显示，因为在这里我没有导入Person类，
     就用了Person类的say方法，当然会提示没有这个方法的警告，这个请参考我的另一篇博文摘抄笔记：
     《让编译器对一些警告闭嘴》。地址：http://www.cnblogs.com/goodboy-heyang/p/5097595.html
     */
    
}

//2、获取Class，并用这个Class创建对象的应用实例：封装XML的SAX解析
- (IBAction)clickBtn_SAX:(id)sender {
    //略
}

- (IBAction)clickHigh:(id)sender {
    NSLog(@"方法调用class方法，打印的都是类对象的isa指针 所以地址相同");
    NSLog(@"%p, %p", [OCFSJZVC class], [self class]);
    
    // 假设从服务器获取JSON串，通过这个JSON串获取需要创建的类为FSJZ_Person，并且调用这个类的fxw_private_function方法。
    Class class = NSClassFromString(@"FSJZ_Person");
    id vc = [[class alloc] init];
    SEL selector = NSSelectorFromString(@"fxw_private_function");//这里fxw_private_function还是个私有方法
    [vc performSelector:selector];
    
    
    
}

@end
