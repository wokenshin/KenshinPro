//
//  WhereAmIVC.m
//  KenshinPro
//
//  Created by apple on 2019/1/29.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "WhereAmIVC.h"
#import <CoreLocation/CoreLocation.h>//定位框架
#import <MapKit/MapKit.h>//地图框架
#import "BIDPlace.h"

//注意 这里在info.plist中设置了定位权限
@interface WhereAmIVC ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager  *locationManager;
@property (nonatomic, strong) CLLocation         *previousPoint;
@property (nonatomic, assign) CLLocationDistance totalMovementDistance;

@property (nonatomic, weak) IBOutlet UILabel    *labLatitude;
@property (nonatomic, weak) IBOutlet UILabel    *labLongitude;
@property (nonatomic, weak) IBOutlet UILabel    *labHorizontalAccuracy;
@property (nonatomic, weak) IBOutlet UILabel    *labAltitude;
@property (nonatomic, weak) IBOutlet UILabel    *labVerticalAccuracy;
@property (nonatomic, weak) IBOutlet UILabel    *labDistanceTraveled;

@property (nonatomic, weak) IBOutlet MKMapView  *mapView;

@end

@implementation WhereAmIVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CoreLocation和KitMap";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //初始化定位管理器
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    //下面if的代码是书中没有的，如果不加上的话，就不会触发定位
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] > 8.0){
        //设置定位权限 仅ios8有意义
        [self.locationManager requestWhenInUseAuthorization];// 前台定位
        //[locationManager requestAlwaysAuthorization];// 前后台同时定位
    }
    
    [_locationManager startUpdatingLocation];
    
    //地图
    _mapView.showsUserLocation = YES;
    
}

#pragma mark - CLLocationManagerDelegate Methods
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *newLocation = [locations lastObject];
    
    NSString *latitudeString = [NSString stringWithFormat:@"%g\u00B0", newLocation.coordinate.latitude];
    _labLatitude.text = latitudeString;
    
    NSString *longitudeString = [NSString stringWithFormat:@"%g\u00B0", newLocation.coordinate.longitude];
    _labLongitude.text = longitudeString;
    
    NSString *horizontalAccuracyString = [NSString stringWithFormat:@"%gm", newLocation.horizontalAccuracy];
    _labHorizontalAccuracy.text = horizontalAccuracyString;
    
    NSString *altitudeString = [NSString stringWithFormat:@"%gm", newLocation.altitude];
    _labAltitude.text = altitudeString;
    
    NSString *verticalAccuracyString = [NSString stringWithFormat:@"%gm", newLocation.verticalAccuracy];
    _labVerticalAccuracy.text = verticalAccuracyString;
    
    if (newLocation.verticalAccuracy < 0 || newLocation.horizontalAccuracy < 0) {
        NSLog(@"无效的精度");
        return;
    }
    
    if (newLocation.horizontalAccuracy > 100 || newLocation.verticalAccuracy > 50) {
        NSLog(@"这里不使用过大的精度");
        return;
    }
    
    if (_previousPoint == nil) {
        _totalMovementDistance = 0;
        //地图相关代码
        BIDPlace *start = [[BIDPlace alloc] init];
        start.coordinate = newLocation.coordinate;
        start.title = @"Start Point";
        start.subTitle = @"This is where we started!";
        
        [_mapView addAnnotation:start];
        MKCoordinateRegion region;
        region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 100, 100);
        [_mapView setRegion:region animated:YES];
    } else {
        _totalMovementDistance += [newLocation distanceFromLocation:_previousPoint];
    }
    _previousPoint = newLocation;
    
    NSString *distanceString = [NSString stringWithFormat:@"%gm", _totalMovementDistance];
    _labDistanceTraveled.text = distanceString;
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSString *errorType = (error.code == kCLErrorDenied) ? @"Access Denied":@"UnKnown Error";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error getting Location"
                                                    message:errorType
                                                   delegate:nil
                                          cancelButtonTitle:@"Okay"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
