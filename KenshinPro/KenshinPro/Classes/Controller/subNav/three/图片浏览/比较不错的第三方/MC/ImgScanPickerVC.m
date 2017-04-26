//
//  ViewController.m
//  STPhotoBrowser
//
//  Created by https://github.com/STShenZhaoliang/STPhotoBrowser.git on 16/1/14.
//  Copyright © 2016年 ST. All rights reserved.
//

#import "ImgScanPickerVC.h"

#import "STPhotoBrowserController.h"
#import "STConfig.h"
#import "UIButton+WebCache.h"
#import "Tools.h"
#import "NoDataView.h"
#import "SDWebImageManager.h"
#import "SDImageCache.h"

static BOOL SDImageCacheOldShouldDecompressImages = YES;
static BOOL SDImagedownloderOldShouldDecompressImages = YES;

@interface ImgScanPickerVC ()<STPhotoBrowserDelegate>

@property (nonatomic, strong, nullable)UIScrollView         *scrollView; //

@property (nonatomic, strong, nullable)NSMutableArray       *arrayButton; //

@property (nonatomic, strong)          NSArray              *staffShowImageArr;

@property (nonatomic, strong) UIView                        *tipsNoData;

@end

@implementation ImgScanPickerVC

#pragma mark - lift cycle 生命周期

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initPhotoBrowserUI];
    [self loadData];
    
    //上下滚动的时候消耗内存过大 下列代码用于优化内存 dealloc 里 也有相关操作
    SDImageCache *canche = [SDImageCache sharedImageCache];
    SDImageCacheOldShouldDecompressImages = canche.shouldDecompressImages;
    canche.shouldDecompressImages = NO;
    
    SDWebImageDownloader *downloder = [SDWebImageDownloader sharedDownloader];
    SDImagedownloderOldShouldDecompressImages = downloder.shouldDecompressImages;
    downloder.shouldDecompressImages = NO;
    
}

- (void)loadData
{
    _tipsNoData = [NoDataView tipsNoDataViewWithImgName:@"no_saitu" andContent:@"暂无晒图"];
    [self.view addSubview:_tipsNoData];
    _tipsNoData.hidden = YES;
    
    _staffShowImageArr = @[
                           @"http://upload-images.jianshu.io/upload_images/1455933-e20b26b157626a5d.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                           @"http://upload-images.jianshu.io/upload_images/1455933-cb2abcce977a09ac.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                           @"http://upload-images.jianshu.io/upload_images/1455933-92be2b34e7e9af61.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                           @"http://upload-images.jianshu.io/upload_images/1455933-edd183910e826e8c.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                           @"http://upload-images.jianshu.io/upload_images/1455933-198c3a62a30834d6.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                           @"http://upload-images.jianshu.io/upload_images/1455933-e9e2967f4988eb7f.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                           @"http://upload-images.jianshu.io/upload_images/1455933-ce55e894fff721ed.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                           @"http://upload-images.jianshu.io/upload_images/1455933-5d3417fa034eafab.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                           @"http://upload-images.jianshu.io/upload_images/1455933-642e217fcdf15774.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                           @"http://upload-images.jianshu.io/upload_images/1455933-7245174910b68599.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                           @"http://upload-images.jianshu.io/upload_images/1455933-e74ae4df495938b7.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                           @"http://upload-images.jianshu.io/upload_images/1455933-ee53be08d63a0d22.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                           @"http://upload-images.jianshu.io/upload_images/1455933-412255ddafdde125.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                           @"http://upload-images.jianshu.io/upload_images/1455933-cee5618e9750de12.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                           @"http://upload-images.jianshu.io/upload_images/1455933-5d5d6ba05853700a.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                           @"http://upload-images.jianshu.io/upload_images/1455933-6dd4d281027c7749.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                           @"http://upload-images.jianshu.io/upload_images/1455933-5d3417fa034eafab.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                           @"http://upload-images.jianshu.io/upload_images/1455933-642e217fcdf15774.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                           @"http://upload-images.jianshu.io/upload_images/1455933-7245174910b68599.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                           @"http://upload-images.jianshu.io/upload_images/1455933-e74ae4df495938b7.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                           @"http://upload-images.jianshu.io/upload_images/1455933-ee53be08d63a0d22.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                           @"http://upload-images.jianshu.io/upload_images/1455933-412255ddafdde125.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                           @"http://upload-images.jianshu.io/upload_images/1455933-cee5618e9750de12.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                           @"http://upload-images.jianshu.io/upload_images/1455933-5d5d6ba05853700a.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                           
                           ];
    [self initAndLoadPhotosUI];
    _tipsNoData.hidden = YES;
    
//    if (_phoneNo != nil) {
//        
//        [self showProgress:@""];
//        WS(ws);
//        [HttpManager getStaffShowImageWithPhoneNo:_phoneNo
//                                     andPageIndex:1 resultBlock:^(id result, BOOL success, HttpResponseError *error) {
//                                         [self hideProgress];
//                                         if (success)
//                                         {
//                                             if (result != nil && [result count] > 0)
//                                             {
//                                                  ws.staffShowImageArr = [[NSMutableArray alloc]initWithArray:result];
//                                                 [ws initAndLoadPhotosUI];
//                                                 ws.tipsNoData.hidden = YES;
//                                                 
//                                             }
//                                             else
//                                             {
//                                                 ws.tipsNoData.hidden = NO;//显示暂无晒图的图片
//                                                 
//                                             }
//                                         }
//                                         else
//                                         {
//                                             [ws autoAlertError:error.desc];
//                                         }
//                                     }];
//        
//    }
    
}

- (void)initPhotoBrowserUI
{
    self.navigationItem.title = @"大神晒图";
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)initAndLoadPhotosUI
{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 74, ScreenWidth, ScreenHeight - 20 - 74)];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [_scrollView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:self.scrollView];
    
    __block CGFloat sizeButton = (ScreenWidth - STMargin * 6)/2;
    __block CGFloat marginK = (screenWidth - sizeButton*2)/3.0;
    __block CGFloat buttonX = 0;
    __block CGFloat buttonY = 0;
    
    //循环
    [self.arrayImageUrl enumerateObjectsUsingBlock:^(NSString *imageUrl, NSUInteger idx, BOOL * _Nonnull stop) {
        
        buttonX = marginK + (idx % 2) * (sizeButton + marginK);
        buttonY = marginK + (idx / 2) * (sizeButton + marginK);
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(buttonX,
                                                                     buttonY,
                                                                     sizeButton,
                                                                     sizeButton)];
        button.imageView.contentMode = UIViewContentModeScaleAspectFill;
        button.clipsToBounds = YES;
        [Tools setBorder:button andColor:[UIColor whiteColor] andWeight:2];
        
        [button sd_setImageWithURL:[NSURL URLWithString:imageUrl]
                          forState:UIControlStateNormal
                  placeholderImage:[UIImage imageNamed:@"load_shaitu"]];
        
        [button setTag:idx];
        [button addTarget:self
                   action:@selector(buttonClick:)
         forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:button];
        [self.arrayButton addObject:button];
    }];
    
    //滚动区域
    CGFloat hScroll = (self.arrayImageUrl.count / 2 ) * (sizeButton + marginK) +
                      (self.arrayImageUrl.count % 2 )*  (sizeButton + marginK);
    
    [self.scrollView setContentSize:CGSizeMake(ScreenWidth, hScroll)];
    
}

#pragma mark - Delegate 视图委托


#pragma mark - photobrowser代理方法
- (UIImage *)photoBrowser:(STPhotoBrowserController *)browser placeholderImageForIndex:(NSInteger)index
{
    return [self.scrollView.subviews[index] currentImage];
    
}

- (NSURL *)photoBrowser:(STPhotoBrowserController *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *urlStr = self.arrayImageUrl[index];
    return [NSURL URLWithString:urlStr];

}


#pragma mark - event response 事件相应
- (void)buttonClick:(UIButton *)button
{
    //启动图片浏览器
    STPhotoBrowserController *browserVc = [[STPhotoBrowserController alloc] init];
    browserVc.sourceImagesContainerView = self.scrollView; // 原图的父控件
    browserVc.countImage = self.arrayImageUrl.count; // 图片总数
    browserVc.currentPage = (int)button.tag;
    browserVc.delegate = self;
    [browserVc show];
    
}

//图片数据源
- (NSArray *)arrayImageUrl
{
    NSMutableArray *imgsM = [[NSMutableArray alloc] init];
    for (int i = 0; i < [_staffShowImageArr count]; i++) {
        NSString *url = [_staffShowImageArr objectAtIndex:i];
        if (url != nil) {
            [imgsM addObject:url];
        }
        
    }
    
    return imgsM;
}

- (NSMutableArray *)arrayButton
{
    if (!_arrayButton)
    {
        _arrayButton = [NSMutableArray array];
        
    }
    return _arrayButton;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
    
    //占用内存过大 清楚缓存
    [[SDWebImageManager sharedManager] cancelAll];
    [[SDImageCache sharedImageCache]   clearDisk];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    _scrollView = nil;
    _arrayButton = nil;
    _staffShowImageArr = nil;
    _tipsNoData = nil;
    
    
    //上下滚动的时候消耗内存过大 下列代码用于优化内存
    SDImageCache *canche = [SDImageCache sharedImageCache];
    canche.shouldDecompressImages = SDImageCacheOldShouldDecompressImages;
    
    SDWebImageDownloader *downloder = [SDWebImageDownloader sharedDownloader];
    downloder.shouldDecompressImages = SDImagedownloderOldShouldDecompressImages;
    
}

@end
