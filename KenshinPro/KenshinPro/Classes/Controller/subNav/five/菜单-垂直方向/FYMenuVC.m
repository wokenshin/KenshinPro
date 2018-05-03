//
//  FYMenuVC.m
//  KenshinPro
//
//  Created by apple on 2018/4/11.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import "FYMenuVC.h"
#import "CellJJSJMenu.h"
#import "ModelItem.h"

#import "FXWMenuGridView.h"

@interface FYMenuVC ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic,strong)  UICollectionView      *collectionView;
@property (nonatomic , strong) NSMutableArray       *mArrData;

@property (nonatomic , strong) FXWMenuGridView *gridView;
@end

@implementation FYMenuVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initFYMenuVCUI];
    [self addGridView];//可复用
    
}

#pragma mark - 封装好的菜单
- (void)addGridView
{
    self.view.backgroundColor = [UIColor grayColor];
    
    //注意 这里的y=64， 因为导航栏的高度是64，如果从0开始的话 由于gridview的内容是collectionview 它会自动下移64即导航栏的高度
    //为了方便理解 可以 gridView.backgroundColor = [UIColor redColor]; 之后查看图层结构
    
    if (_gridView == nil)
    {
        CGFloat hTopView   = _collectionView.frame.size.height;
        CGFloat hStatusBar = 64;
        CGFloat margin     = 20;
        CGFloat y          = hTopView + hStatusBar + margin;
        
        _gridView = [FXWMenuGridView fxw_gridViewWithData:self.mArrData point:CGPointMake(0, y)];
        [self.view addSubview:_gridView];
        
        [_gridView clickItem:^(ModelItem *model) {
            NSLog(@"click %@", model.title);
        }];
    }
    
    
}

- (void)initFYMenuVCUI
{
    self.navigationItem.title = @"菜单-垂直方向";
    self.view.backgroundColor = [UIColor grayColor];

    //此处必须要有创见一个UICollectionViewFlowLayout的对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //同一行相邻两个cell的最小间距
    layout.minimumInteritemSpacing = 0;
    //最小两行之间的间距
    layout.minimumLineSpacing = 0;

    //集合view的高度应该为 屏幕高度-(顶部蓝色view+导航栏高度)
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, screenWidth, Height_CellJJSJMenu * 2)
                                        collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate   = self;
    _collectionView.dataSource = self;
    //这个是横向滑动
//    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [self.view addSubview:_collectionView];

    //注册xib cell
    UINib *cellNib = [UINib nibWithNibName:@"CellJJSJMenu" bundle:nil];
    [_collectionView registerNib:cellNib forCellWithReuseIdentifier:@"CellJJSJMenu"];

}

- (NSMutableArray *)mArrData
{
    if (_mArrData == nil) {
        _mArrData = [[NSMutableArray alloc] init];
        ModelItem *item = [[ModelItem alloc] init];
        item.imgName = @"jjsj_1";
        item.title   = @"筑e通";

        ModelItem *item2 = [[ModelItem alloc] init];
        item2.imgName = @"jjsj_2";
        item2.title   = @"房产超市";

        ModelItem *item3 = [[ModelItem alloc] init];
        item3.imgName = @"jjsj_3";
        item3.title   = @"园林绿化";

        ModelItem *item4 = [[ModelItem alloc] init];
        item4.imgName = @"jjsj_4";
        item4.title   = @"供需发现";

        ModelItem *item5 = [[ModelItem alloc] init];
        item5.imgName = @"jjsj_5";
        item5.title   = @"办证攻略";

        ModelItem *item6 = [[ModelItem alloc] init];
        item6.imgName = @"jjsj_6";
        item6.title   = @"问答";

        ModelItem *item7 = [[ModelItem alloc] init];
        item7.imgName = @"jjsj_more";
        item7.title   = @"更多";

        [_mArrData addObject:item];
        [_mArrData addObject:item2];
        [_mArrData addObject:item3];
        [_mArrData addObject:item4];
        [_mArrData addObject:item5];
        [_mArrData addObject:item6];
        [_mArrData addObject:item7];

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
    return self.mArrData.count;

}

#pragma mark - UICollectionView 返回 Cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    CellJJSJMenu *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellJJSJMenu"
                                                                       forIndexPath:indexPath];
    cell.model = [self.mArrData objectAtIndex:indexPath.row];

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
    return CGSizeMake(screenWidth/4.0, Height_CellJJSJMenu);
}

#pragma mark - UICollectionView cell的点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ModelItem *item = [_mArrData objectAtIndex:indexPath.row];
    [self toast:item.title];

}

@end
