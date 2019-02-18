//
//  ClassB.h
//  KenshinPro
//
//  Created by apple on 2019/2/18.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClassA.h"

NS_ASSUME_NONNULL_BEGIN

@interface ClassB : NSObject

//取消这里的注释就会出现编译错误，因为 ClassA和ClassB互相引用 可以使用 向前声明来解决此问题，请查看 ClassOne 和ClassTwo
//@property (nonatomic, strong) ClassA    *a;

@end

NS_ASSUME_NONNULL_END
