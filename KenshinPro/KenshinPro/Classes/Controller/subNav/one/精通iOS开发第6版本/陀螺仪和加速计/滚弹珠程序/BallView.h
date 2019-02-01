//
//  BallView.h
//  KenshinPro
//
//  Created by apple on 2019/2/1.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

NS_ASSUME_NONNULL_BEGIN

@interface BallView : UIView

@property (nonatomic, assign)CMAcceleration acceleration;

@end

NS_ASSUME_NONNULL_END
