//
//  GYZSCtrlVC.m
//  KenshinPro
//
//  Created by kenshin on 2017/11/2.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "GYZSCtrlVC.h"
#import "LockCtrlHeaderView.h"
#import "CellLockCtrl.h"

int const Height_TopView        = 230;
static NSString *CtrlHeader     = @"CtrlHeader";

@interface GYZSCtrlVC ()<UICollectionViewDelegate, UICollectionViewDataSource>

//上半部分UI
@property (nonatomic, strong) LockCtrlHeaderView            *myHeaderView;

//控制UI
@property (nonatomic, strong) UICollectionView              *collectionView;
@property (nonatomic, strong) NSMutableArray                *mArrData;

@end

@implementation GYZSCtrlVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initCtrlLockVCUI];
}

- (void)initCtrlLockVCUI
{
    self.navigationItem.title = @"设备管理";
    
    //背景
    UIImageView *imgBg = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imgBg.image = [UIImage imageNamed:@"bg_list_main"];
    [self.view addSubview:imgBg];
    
    [self.view addSubview:self.collectionView]; //控制UI
    
}

#pragma mark 懒加载
- (LockCtrlHeaderView *)myHeaderView
{
    if (_myHeaderView == nil)
    {
        _myHeaderView = [[LockCtrlHeaderView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, Height_TopView)];
        //self.myHeaderView.model = _model;
        
        WS(ws);
        [_myHeaderView clickBaterryViewWithResultBlock:^(LockCtrlHeaderView *view) {
            //更换电量图标
            ws.myHeaderView.imgBattery.image = [UIImage imageNamed:@"battery_75"];
            
        }];
    }
    return _myHeaderView;
    
}

#pragma 懒加载 集合
- (UICollectionView *)collectionView
{
    if (_collectionView == nil)
    {
        //此处必须要有创见一个UICollectionViewFlowLayout的对象
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.minimumInteritemSpacing = 0;//同一行相邻两个cell的最小间距
        layout.minimumLineSpacing      = 0;//最小两行之间的间距
        
        //fxw_coreCode 头部视图 1/2 这里必须设置好frame
        layout.headerReferenceSize     = CGSizeMake(self.view.frame.size.width, Height_TopView); //设置collectionView头视图的大小
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)
                                            collectionViewLayout:layout];
        
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate   = self;
        _collectionView.dataSource = self;
        
        //注册头部
        [_collectionView registerClass:[UICollectionReusableView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CtrlHeader];
        
        //注册xib cell
        UINib *cellNib = [UINib nibWithNibName:@"CellLockCtrl" bundle:nil];
        [_collectionView registerNib:cellNib forCellWithReuseIdentifier:@"CellLockCtrl"];
    }
    return _collectionView;
}

//集合数据源
- (NSMutableArray *)mArrData
{
    if (_mArrData == nil)
    {
        _mArrData = [[NSMutableArray alloc] init];
        
        LockCtrlModel *model1 = [[LockCtrlModel alloc] init];
        model1.imgName = @"btn_lock_off";
        model1.title   = @"开锁";
        
        LockCtrlModel *model2 = [[LockCtrlModel alloc] init];
        model2.imgName = @"btn_lock_pwd";
        model2.title   = @"密码管理";
        
        LockCtrlModel *model3 = [[LockCtrlModel alloc] init];
        model3.imgName = @"btn_lock_phoneKey";
        model3.title   = @"钥匙管理";
        
        LockCtrlModel *model4 = [[LockCtrlModel alloc] init];
        model4.imgName = @"btn_lock_syncTime";
        model4.title   = @"同步时间";
        
        LockCtrlModel *model5 = [[LockCtrlModel alloc] init];
        model5.imgName = @"btn_lock_changeLock";
        model5.title   = @"换锁";
        
        LockCtrlModel *model6 = [[LockCtrlModel alloc] init];
        model6.imgName = @"btn_lock_del";
        model6.title   = @"解绑";
        
        [_mArrData addObject:model1];
        [_mArrData addObject:model2];
        [_mArrData addObject:model3];
        [_mArrData addObject:model4];
        [_mArrData addObject:model5];
        [_mArrData addObject:model6];
        
    }
    return _mArrData;
}

#pragma mark - UICollectionView 返回分组数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark - UICollectionView 返回每一组cell个数
-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    return [self.mArrData count];
    
}

#pragma mark - UICollectionView 返回 Cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LockCtrlModel *model = _mArrData[indexPath.row];
    CellLockCtrl  *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellLockCtrl"
                                                                     forIndexPath:indexPath];
    cell.model = model;
    return cell;
    
}

#pragma mark - UICollectionView 每一个分组的上左下右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                       layout:(UICollectionViewLayout *)collectionViewLayout
       insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - UICollectionView 定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(screenWidth/2.0, 110);
}

#pragma mark - UICollectionView cell的点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LockCtrlModel *model = _mArrData[indexPath.row];
    NSString      *title = model.title;
    
    if ([title isEqualToString:@"开锁"])
    {
        [self toastBottom:title];
    }
    else if([title isEqualToString:@"密码管理"])
    {
        [self toastBottom:title];
    }
    else if([title isEqualToString:@"钥匙管理"])
    {
        [self toastBottom:title];
    }
    else if([title isEqualToString:@"同步时间"])
    {
        [self toastBottom:title];
    }
    else if([title isEqualToString:@"换锁"])
    {
        [self toastBottom:title];
    }
    else if([title isEqualToString:@"解绑"])
    {
        [self toastBottom:title];
    }
    
}

//fxw_coreCode 头部视图 2/2 必须实现该代理，在代理中绘制头部视图【这个地方如果上下滑动的话 是会被重复调用】
#pragma mark 返回头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //如果是头视图
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                              withReuseIdentifier:CtrlHeader
                                                                                     forIndexPath:indexPath];
        
        //头视图添加view
        [header addSubview:self.myHeaderView];
        return header;
    }
    //如果底部视图
    //    if([kind isEqualToString:UICollectionElementKindSectionFooter]){
    //
    //    }
    return nil;
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
