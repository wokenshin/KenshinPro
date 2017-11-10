//
//  CodingRuntime.m
//  KenshinPro
//
//  Created by kenshin on 2017/11/9.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "CodingRuntime.h"
#import <objc/runtime.h>


/**
 代码中利用tunrime机制 遍历了类的全部属性。
 可以把这里的代码封装到了宏里面 这样看起来就更简洁了
 如下：
 
 #import <objc/runtime.h>
 
 #define encodeRuntime(A) \
 \
 unsigned int count = 0;\
 Ivar *ivars = class_copyIvarList([A class], &count);\
 for (int i = 0; i<count; i++) {\
 Ivar ivar = ivars[i];\
 const char *name = ivar_getName(ivar);\
 NSString *key = [NSString stringWithUTF8String:name];\
 id value = [self valueForKey:key];\
 [encoder encodeObject:value forKey:key];\
 }\
 free(ivars);\
 \
 
 #define initCoderRuntime(A) \
 \
 if (self = [super init]) {\
 unsigned int count = 0;\
 Ivar *ivars = class_copyIvarList([A class], &count);\
 for (int i = 0; i<count; i++) {\
 Ivar ivar = ivars[i];\
 const char *name = ivar_getName(ivar);\
 NSString *key = [NSString stringWithUTF8String:name];\
 id value = [decoder decodeObjectForKey:key];\
 [self setValue:value forKey:key];\
 }\
 free(ivars);\
 }\
 return self;\
 \
 
 @implementation Movie
 
 - (void)encodeWithCoder:(NSCoder *)encoder
 
 {
    encodeRuntime(Movie)
 }
 
 - (id)initWithCoder:(NSCoder *)decoder
 {
    initCoderRuntime(Movie)
 }
 
 */

@implementation CodingRuntime

- (void)encodeWithCoder:(NSCoder *)aCoder
{
//    最原始的写法
//    [aCoder encodeObject:_country forKey:@"country"];
//    [aCoder encodeObject:_name    forKey:@"name"];
//    [aCoder encodeObject:_gender  forKey:@"gender"];
    
//    借助runtime机制的写法
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([CodingRuntime class], &count);
    
    for (int i = 0; i<count; i++)
    {
        Ivar ivar = ivars[i];// 取出i位置对应的成员变量
        
        const char *name = ivar_getName(ivar);// 查看成员变量
        NSString *key    = [NSString stringWithUTF8String:name];// 归档
        id value         = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    free(ivars);
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
//    最原始的写法
//    if (self = [super init])
//    {
//        self.country = [aDecoder decodeObjectForKey:@"country"];
//        self.name    = [aDecoder decodeObjectForKey:@"name"];
//        self.gender  = [aDecoder decodeObjectForKey:@"gender"];
//    }
//    return self;
    
//    借助runtime机制的写法
    if (self = [super init])
    {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([CodingRuntime class], &count);
        for (int i = 0; i<count; i++)
        {
            
            Ivar ivar        = ivars[i];// 取出i位置对应的成员变量
            const char *name = ivar_getName(ivar);// 查看成员变量
            NSString *key    = [NSString stringWithUTF8String:name];// 归档
            id value         = [aDecoder decodeObjectForKey:key];
            
            [self setValue:value forKey:key];// 设置到成员变量身上
            
        }
        free(ivars);
    }
    return self;
    
}

@end
