//
//  QuartzFunView.h
//  KenshinPro
//
//  Created by apple on 2019/1/22.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BIDConstants.h"

NS_ASSUME_NONNULL_BEGIN

@interface QuartzFunView : UIView

//CGPoint 跟踪用户在屏幕上拖动的手指
@property (nonatomic, assign) CGPoint   firstTouchLocation;
@property (nonatomic, assign) CGPoint   lastTouchLocation;

@property (nonatomic, assign) ShapeType shapeType;
@property (nonatomic, assign) BOOL      useRandomColor;//是否使用随机色
@property (nonatomic, strong) UIColor   *currentColor;
@property (nonatomic, strong) UIImage   *drawImage;


@property (nonatomic, readonly) CGRect currentRect;//前一次的矩形
@property (nonatomic, assign) CGRect   redrawRect;//跟踪后的矩形
@end

NS_ASSUME_NONNULL_END
