//
//  ClassA.h
//  KenshinPro
//
//  Created by apple on 2019/2/18.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClassB.h"

NS_ASSUME_NONNULL_BEGIN

@interface ClassA : NSObject

//取消这里的注释就会出现编译错误，因为 ClassA和ClassB互相引用
//@property (nonatomic, strong) ClassB    *b;

@end

NS_ASSUME_NONNULL_END
