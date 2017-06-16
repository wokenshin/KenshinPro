//
//  DeviceManageVC.m
//  CleverApartment
//
//  Created by kenshin on 2017/6/8.
//  Copyright © 2017年 M2MKey. All rights reserved.
//

#import "DeviceManageVC.h"
#import "CellDeviceManage.h"

@interface DeviceManageVC ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic,strong)  UICollectionView      *collectionView;

@end

@implementation DeviceManageVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initDeviceManageVCUI];
    
}

- (void)initDeviceManageVCUI
{
    self.navigationItem.title = @"设备管理";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //此处必须要有创见一个UICollectionViewFlowLayout的对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //同一行相邻两个cell的最小间距
    layout.minimumInteritemSpacing = 0;
    //最小两行之间的间距
    layout.minimumLineSpacing = 0;
    
    //集合view的高度应该为 屏幕高度-(顶部蓝色view+导航栏高度)
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, screenWidth, screenHeight - 64)
                                        collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate   = self;
    _collectionView.dataSource = self;
    //这个是横向滑动
    //layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [self.view addSubview:_collectionView];
    
    //注册xib cell
    UINib *cellNib = [UINib nibWithNibName:@"CellDeviceManage" bundle:nil];
    [_collectionView registerNib:cellNib forCellWithReuseIdentifier:@"CellDeviceManage"];
    
    
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
    return 13;
    
}

#pragma mark - UICollectionView 返回 Cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CellDeviceManage *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellDeviceManage"
                                                                       forIndexPath:indexPath];
    
//    ModelCellCtrl *model = [_arrCollectionData objectAtIndex:indexPath.row];
//    
//    cell.imageView.image = [UIImage imageNamed:model.imageName];
//    cell.labTitle.text = model.title;
    
    WS(ws);
    [cell clickCell:^(CellDeviceManage *cell) {
        [ws toast:@"点击了设备管理中的单元"];
    }];
    
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
    return CGSizeMake(screenWidth/2.0, screenWidth/2.0);
}

#pragma mark - UICollectionView cell的点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = [NSString stringWithFormat:@"这里的回调已经没啥用了 %zd", indexPath.row];
    [self toast:str];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
