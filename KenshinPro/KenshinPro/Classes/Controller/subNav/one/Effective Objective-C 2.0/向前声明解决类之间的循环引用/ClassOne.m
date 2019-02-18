//
//  ClassOne.m
//  KenshinPro
//
//  Created by apple on 2019/2/18.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "ClassOne.h"
#import "ClassTwo.h"

@implementation ClassOne

- (void)funcOne{
    //当要在实现中使用到 ClassTwo中的细节的时候 就必须引入相应的头文件了
    [_two functionTwo];
    
}

@end
