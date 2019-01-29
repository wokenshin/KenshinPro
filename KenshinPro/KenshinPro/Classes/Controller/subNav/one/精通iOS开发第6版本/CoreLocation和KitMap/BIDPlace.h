//
//  BIDPlace.h
//  KenshinPro
//
//  Created by apple on 2019/1/29.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>//地图框架

NS_ASSUME_NONNULL_BEGIN

@interface BIDPlace : NSObject<MKAnnotation>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end

NS_ASSUME_NONNULL_END
