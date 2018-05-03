//
//  FYMenu2VC.m
//  KenshinPro
//
//  Created by apple on 2018/4/12.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import "FYMenu2VC.h"
#import "ModelYY.h"
#import "CellJJSJYY.h"
#import "FXWMenuScrollView.h"

@interface FYMenu2VC ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic,strong)  UICollectionView      *collectionView;
@property (nonatomic , strong) NSMutableArray       *mArrData;

@property (nonatomic, strong) FXWMenuScrollView     *menu;
@end

@implementation FYMenu2VC

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self initFYMenuVCUI];
    
    CGRect frame = CGRectMake(0, 84, screenWidth, Height_CellJJSJYY);
    _menu = [FXWMenuScrollView fxw_menuWithFrame:frame andData:self.mArrData];
    [_menu clickItem:^(ModelYY *model) {
        NSLog(@"click %@", model.imgUrl);
    }];
    [self.view addSubview:_menu];
}

- (void)initFYMenuVCUI
{
    self.navigationItem.title = @"菜单-水平方向";
    self.view.backgroundColor = [UIColor grayColor];
    
    //此处必须要有创见一个UICollectionViewFlowLayout的对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //同一行相邻两个cell的最小间距
    layout.minimumInteritemSpacing = 0;
    //最小两行之间的间距
    layout.minimumLineSpacing = 0;
    
    //集合view的高度应该为 屏幕高度-(顶部蓝色view+导航栏高度)
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, screenWidth, Height_CellJJSJYY)
                                        collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate   = self;
    _collectionView.dataSource = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    //这个是横向滑动
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [self.view addSubview:_collectionView];
    
    //注册xib cell
    UINib *cellNib = [UINib nibWithNibName:@"CellJJSJYY" bundle:nil];
    [_collectionView registerNib:cellNib forCellWithReuseIdentifier:@"CellJJSJYY"];
    
}

- (NSMutableArray *)mArrData
{
    if (_mArrData == nil) {
        _mArrData = [[NSMutableArray alloc] init];
        ModelYY *item = [[ModelYY alloc] init];
        item.imgUrl = @"h1";
        
        ModelYY *item2 = [[ModelYY alloc] init];
        item2.imgUrl = @"h2";
        
        ModelYY *item3 = [[ModelYY alloc] init];
        item3.imgUrl = @"h3";
        
        [_mArrData addObject:item];
        [_mArrData addObject:item2];
        [_mArrData addObject:item3];
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
    [self toast:item.imgUrl];
    
}

@end
