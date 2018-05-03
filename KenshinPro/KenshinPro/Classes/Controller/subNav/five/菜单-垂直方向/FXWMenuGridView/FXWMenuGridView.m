//
//  FXWMenuGridView.m
//  KenshinPro
//
//  Created by apple on 2018/4/11.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import "FXWMenuGridView.h"
#import "CellJJSJMenu.h"



@interface FXWMenuGridView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic,strong)  UICollectionView      *collectionView;
@property (nonatomic , strong) NSMutableArray       *mArrData;
@property (nonatomic, copy)    BlockFXWMenuGridView blockClickCell;
@end;


@implementation FXWMenuGridView

+ (FXWMenuGridView *)fxw_gridViewWithData:(NSArray<ModelItem*> *)arrModel point:(CGPoint)origin
{
    FXWMenuGridView *grid = [[FXWMenuGridView alloc] init];
    grid.mArrData = [NSMutableArray arrayWithArray:arrModel];
    
    //计算表格高度
    CGFloat heightGrid = [FXWMenuGridView heightGridWithData:arrModel];
    [grid setUp:heightGrid];
    
    //设置frame
    CGRect tmpFrame = CGRectMake(origin.x, origin.y, screenWidth, heightGrid);
    grid.frame = tmpFrame;
    
    return grid;
}

+ (CGFloat )heightGridWithData:(NSArray<ModelItem*> *)data
{
    NSInteger sumModel = [data count];
    NSInteger line     = sumModel/4;
    
    if (sumModel % 4 == 0) {//eg: = 7时， line == 1 -->heightGrid = h * 2
        line--;             //eg: = 12,  line == 3 -->heightGrid = h * 2
    }
    
    CGFloat heightGrid = Height_CellJJSJMenu * (1 +line);
    
    return heightGrid;
}

#pragma mark 创建菜单
- (void)setUp:(CGFloat)heightGrid
{
    //此处必须要有创见一个UICollectionViewFlowLayout的对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //同一行相邻两个cell的最小间距
    layout.minimumInteritemSpacing = 0;
    //最小两行之间的间距
    layout.minimumLineSpacing = 0;
    
    //集合view的高度应该为 屏幕高度-(顶部蓝色view+导航栏高度)
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, heightGrid)
                                        collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate   = self;
    _collectionView.dataSource = self;
    
    //这个是横向滑动
    //    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [self addSubview:_collectionView];
    
    //注册xib cell
    UINib *cellNib = [UINib nibWithNibName:@"CellJJSJMenu" bundle:nil];
    [_collectionView registerNib:cellNib forCellWithReuseIdentifier:@"CellJJSJMenu"];
    
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
    if (_blockClickCell) {
        _blockClickCell(item);
    }
}

#pragma mark 回调
- (void)clickItem:(BlockFXWMenuGridView)resultBlock
{
    _blockClickCell = resultBlock;
}

@end
