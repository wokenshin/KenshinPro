//
//  NSObject+Runtime.m
//  KenshinPro
//
//  Created by kenshin on 2017/11/9.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "NSObject+Runtime.h"
#import <objc/message.h>

@implementation NSObject (Runtime)

- (void)setName:(NSString *)name
{
    
    // objc_setAssociatedObject（将某个值跟某个对象关联起来，将某个值存储到某个对象中）
    // object:给哪个对象添加属性
    // key:属性名称
    // value:属性值
    // policy:保存策略
    objc_setAssociatedObject(self, @"name", name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

- (NSString *)name
{
    return objc_getAssociatedObject(self, @"name");
}


// Runtime:根据模型中属性,去字典中取出对应的value给模型属性赋值
// 思路：遍历模型中所有属性->使用运行时
+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    // 1.创建对应的对象
    id objc = [[self alloc] init];
    
    // 2.利用runtime给对象中的属性赋值
    /**
     class_copyIvarList: 获取类中的所有成员变量
     Ivar：成员变量
     第一个参数：表示获取哪个类中的成员变量
     第二个参数：表示这个类有多少成员变量，传入一个Int变量地址，会自动给这个变量赋值
     返回值Ivar *：指的是一个ivar数组，会把所有成员属性放在一个数组中，通过返回的数组就能全部获取到。
     count: 成员变量个数
     */
    unsigned int count = 0;
    // 获取类中的所有成员变量
    Ivar *ivarList = class_copyIvarList(self, &count);
    
    // 遍历所有成员变量
    for (int i = 0; i < count; i++)
    {
        // 根据角标，从数组取出对应的成员变量
        Ivar ivar = ivarList[i];
        
        // 获取成员变量名字
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        
        // 处理成员变量名->字典中的key(去掉 _ ,从第一个角标开始截取)
        NSString *key = [ivarName substringFromIndex:1];
        
        // 根据成员属性名去字典中查找对应的value
        id value = dict[key];
        
        // 【如果模型属性数量大于字典键值对数理，模型属性会被赋值为nil】
        // 而报错 (could not set nil as the value for the key age.)
        if (value)
        {
            // 给模型中属性赋值
            [objc setValue:value forKey:key];
        }
        
    }
    
    return objc;
    /*
     注解：这里在获取模型类中的所有属性名，是采取 class_copyIvarList 先获取成员变量（以下划线开头） ，然后再处理成员变量名->字典中的key(去掉 _ ,从第一个角标开始截取) 得到属性名。
     
     原因：Ivar：成员变量,以下划线开头，Property 属性
     获取类里面属性 class_copyPropertyList
     获取类中的所有成员变量 class_copyIvarList
    
     */
}

+ (instancetype)modelWithDict2:(NSDictionary *)dict
{
    // 1.创建对应的对象
    id objc = [[self alloc] init];
    
    // 2.利用runtime给对象中的属性赋值
    unsigned int count = 0;
    // 获取类中的所有成员变量
    Ivar *ivarList = class_copyIvarList(self, &count);
    
    // 遍历所有成员变量
    for (int i = 0; i < count; i++) {
        // 根据角标，从数组取出对应的成员变量
        Ivar ivar = ivarList[i];
        
        // 获取成员变量名字
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        // 获取成员变量类型
        NSString *ivarType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        
        // 替换: @\"User\" -> User
        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"@" withString:@""];
        
        // 处理成员属性名->字典中的key(去掉 _ ,从第一个角标开始截取)
        NSString *key = [ivarName substringFromIndex:1];
        
        // 根据成员属性名去字典中查找对应的value
        id value = dict[key];
        
        //--------------------------- <#我是分割线#> ------------------------------//
        //
        // 二级转换:如果字典中还有字典，也需要把对应的字典转换成模型
        // 判断下value是否是字典,并且是自定义对象才需要转换
        if ([value isKindOfClass:[NSDictionary class]] && ![ivarType hasPrefix:@"NS"])
        {
            // 字典转换成模型 userDict => User模型, 转换成哪个模型
            // 根据字符串类名生成类对象
            Class modelClass = NSClassFromString(ivarType);
            
            if (modelClass)//有对应的模型才需要转
            {
                // 把字典转模型
                value = [modelClass modelWithDict2:value];
            }
        }
        
        // 给模型中属性赋值
        if (value)
        {
            [objc setValue:value forKey:key];
        }
    }
    return objc;
}


@end
