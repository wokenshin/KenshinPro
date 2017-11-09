//
//  CusModel.m
//  KenshinPro
//
//  Created by kenshin on 2017/11/9.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "CusModel.h"


/**
 需要注意 这里的encode方法 和 decode方法 后面需要指定类型 不然会报错
 */
@implementation CusModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:_age      forKey:@"age"];
    [aCoder encodeObject:_name  forKey:@"name"];
    [aCoder encodeFloat:_height forKey:@"height"];
    //这样写 如果参数少的话，还OK 但是参数很多的话就很麻烦了，可以通过runtime遍历类的全部属性来实现以个通用的写法，可查看App中runtime部分的归档解档demo
    //全局搜索 RuntimeVC 即可
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.age    = [aDecoder decodeIntForKey:@"age"];
        self.name   = [aDecoder decodeObjectForKey:@"name"];
        self.height = [aDecoder decodeFloatForKey:@"height"];
    }
    return self;
    
}


@end
