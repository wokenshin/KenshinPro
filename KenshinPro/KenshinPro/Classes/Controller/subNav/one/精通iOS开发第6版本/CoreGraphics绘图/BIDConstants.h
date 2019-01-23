//
//  BIDConstants.h
//  KenshinPro
//
//  Created by apple on 2019/1/22.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#ifndef BIDConstants_h//ifndef 的目的是防止重复导入（在C语言中需要） 但在#import中不需要这样定义（OC中），
#define BIDConstants_h

//形状
typedef NS_ENUM(NSInteger, ShapeType){
    kLineShape = 0,
    kRectShape,
    kEllipseShape,
    kImageShape
};

//颜色
typedef NS_ENUM(NSInteger, ColorTabIndex){
    kRedColorTab = 0,
    kBlueColorTab,
    kYellowColorTab,
    kGreenColorTab,
    kRandomColorTab
};

#define degreesToRadian(x) (M_PI * (x)/180.0)

#endif /* BIDConstants_h */
