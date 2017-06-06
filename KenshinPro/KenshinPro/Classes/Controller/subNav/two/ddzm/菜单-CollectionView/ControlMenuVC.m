//
//  ControlMenu.m
//  KenshinPro
//
//  Created by kenshin on 17/3/18.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "ControlMenuVC.h"
#import "CellCtrlDdzm.h"

//from http://blog.csdn.net/ios_mark/article/details/51800401
@interface ControlMenuVC ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray                       *arrImg;
@property (nonatomic, strong) NSArray                       *arrTitle;
@property(nonatomic,strong)UICollectionView                 *collectionView;

@end

@implementation ControlMenuVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    [self initUI];
    
    WS(ws);
    [ws toastBottom:@"3s后刷新数据"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        ws.arrImg   = @[@"ddzmMenu1",@"ddzmMenu2",@"ddzmMenu3",@"ddzmMenu4",@"ddzmMenu5",@"ddzmMenu6"];
        ws.arrTitle = @[@"更新",@"修改",@"变换",@"改变",@"手机钥匙",@"节电模式"];
        [ws.collectionView reloadData];
    });
    
}

- (void)loadData
{
    _arrImg   = @[@"ddzmMenu1",@"ddzmMenu2",@"ddzmMenu3",@"ddzmMenu4",@"ddzmMenu5",
                  @"ddzmMenu6",@"ddzmMenu2",@"ddzmMenu3",@"ddzmMenu4",@"ddzmMenu5",
                  @"ddzmMenu6",@"ddzmMenu2",@"ddzmMenu3",@"ddzmMenu4",@"ddzmMenu5",
                  @"ddzmMenu6",@"ddzmMenu2",@"ddzmMenu3",@"ddzmMenu4",@"ddzmMenu5",@"ddzmMenu6"];
    
    _arrTitle = @[@"下载",@"指纹",@"ID卡",@"日志",@"手机钥匙",
                  @"节电模式",@"指纹",@"ID卡",@"日志",@"手机钥匙"
                  @"节电模式",@"指纹",@"ID卡",@"日志",@"手机钥匙",
                  @"节电模式",@"指纹",@"ID卡",@"日志",@"手机钥匙",@"节电模式"];
}

- (void)initUI
{
    self.navigationItem.title = @"最简单的CollectionView";
    
    
    //此处必须要有创见一个UICollectionViewFlowLayout的对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //同一行相邻两个cell的最小间距
    layout.minimumInteritemSpacing = 0;
    //最小两行之间的间距
    layout.minimumLineSpacing = 0;
    
    //末尾-64 是因为集合view的高度已经在y坐标系的影响下 超出的屏幕 所以要剪掉64
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, screenWidth, screenHeight - 64) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    //这个是横向滑动
    //layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    [self.view addSubview:_collectionView];
    
    /*
     *这是重点 必须注册cell
     */
    //这种是xib建的cell 需要这么注册
    UINib *cellNib=[UINib nibWithNibName:@"CellCtrlDdzm" bundle:nil];
    [_collectionView registerNib:cellNib forCellWithReuseIdentifier:@"CellCtrlDdzm"];
    //这种是自定义cell不带xib的注册
    //   [_collectionView registerClass:[CollectionViewCell1 class] forCellWithReuseIdentifier:@"myheheIdentifier"];
    //这种是原生cell的注册
    //    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    /*
     //这是头部与脚部的注册
     UINib *cellNib1=[UINib nibWithNibName:@"CollectionReusableView" bundle:nil];
     [_collectionView registerNib:cellNib1 forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionReusableView"];
     [_collectionView registerNib:cellNib1 forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"CollectionReusableView"];
     */
}

//一共有多少个组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每一组有多少个cell
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _arrImg.count;
    
}
//每一个cell是什么
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CellCtrlDdzm *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellCtrlDdzm" forIndexPath:indexPath];
    
    NSString *imgName = [_arrImg objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:imgName];
    cell.labTitle.text = [_arrTitle objectAtIndex:indexPath.row];
    return cell;
    
}

//头部和脚部的加载
//-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionReusableView *view=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CollectionReusableView" forIndexPath:indexPath];
//    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(110, 20, 100, 30)];
//    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//        label.text=@"头";
//    }else{
//        label.text=@"脚";
//    }
//    [view addSubview:label];
//    return view;
//}

//每一个分组的上左下右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //在设置间距的时候，个人觉得 可以把间距直接体现在单个cell上。
    //或者也可以在这里设置， 个人建议 设置上 下 间距的时候 不要只设置一个，最好上下都设置，不然最顶部 或者 最底部 可能因为你没有设置 而变成0
    //那样看着并不美观
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//头部试图的大小
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    return CGSizeMake(50, 60);
//}
////脚部试图的大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    return CGSizeMake(50, 60);
//}

//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(screenWidth/3.0, 100);
    
}

//cell的点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //cell被电击后移动的动画
//    [collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionTop];
    NSLog(@"%ld", indexPath.row);
    [self toast:[NSString stringWithFormat:@"%ld", indexPath.row]];
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
