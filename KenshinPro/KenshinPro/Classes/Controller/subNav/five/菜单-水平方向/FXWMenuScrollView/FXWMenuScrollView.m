//
//  FXWMenuScrollView.m
//  KenshinPro
//
//  Created by apple on 2018/4/12.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import "FXWMenuScrollView.h"
#import "CellJJSJYY.h"

@interface FXWMenuScrollView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic,strong)  UICollectionView      *collectionView;
@property (nonatomic , strong) NSMutableArray       *mArrData;
@property (nonatomic, copy) BlockFXWMenuScrollView  blockClick;

@end;



@implementation FXWMenuScrollView

+ (FXWMenuScrollView *)fxw_menuWithFrame:(CGRect)frame andData:(NSArray<ModelYY*> *)arrData
{
    FXWMenuScrollView *menu = [[FXWMenuScrollView alloc] init];
    menu.frame = frame;
    menu.mArrData = [NSMutableArray arrayWithArray:arrData];
    [menu setUp];
    return menu;
}

- (void)setUp
{
    //此处必须要有创见一个UICollectionViewFlowLayout的对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //同一行相邻两个cell的最小间距
    layout.minimumInteritemSpacing = 0;
    //最小两行之间的间距
    layout.minimumLineSpacing = 0;
    
    //集合view的高度应该为 屏幕高度-(顶部蓝色view+导航栏高度)
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, Height_CellJJSJYY)
                                        collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate        = self;
    _collectionView.dataSource      = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    //这个是横向滑动
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [self addSubview:_collectionView];
    
    //注册xib cell
    UINib *cellNib = [UINib nibWithNibName:@"CellJJSJYY" bundle:nil];
    [_collectionView registerNib:cellNib forCellWithReuseIdentifier:@"CellJJSJYY"];
    
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
    
    CellJJSJYY *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellJJSJYY"
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
    return CGSizeMake(screenWidth*0.4, Height_CellJJSJYY);
}

#pragma mark - UICollectionView cell的点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ModelYY *item = [_mArrData objectAtIndex:indexPath.row];
    if (_blockClick) {
        _blockClick(item);
    }
}

- (void)clickItem:(BlockFXWMenuScrollView)resultBlock
{
    _blockClick = resultBlock;
}
@end
