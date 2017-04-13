//
//  BaiDuBottomMenu.m
//  KenshinPro
//
//  Created by kenshin on 17/4/5.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "BaiDuBottomMenu.h"
#import "CategoryCell.h"

@interface BaiDuBottomMenu ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UIView                        *categoryView;
@property (nonatomic, strong) UIButton                      *categoryBtn;
@property (nonatomic, strong) UIImageView                   *arrowIV;

@property (nonatomic, strong) UIView                        *dropDownMenuView;
@property (nonatomic, strong) UIControl                     *control;
@property (nonatomic, strong) UICollectionView              *collectionView;

@property (nonatomic, assign) BOOL                          isDropDownMenu;
@property (nonatomic, strong) NSArray                       *images;
@property (nonatomic, strong) NSArray                       *titles;
@property (nonatomic, assign) NSInteger                     index;
@end

#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

#define kDuration 0.3

@implementation BaiDuBottomMenu


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self prepareData];
    
    [self creatUI];
}

#pragma mark - private
- (void)prepareData
{
    _images = @[@"baiDuBottomMenu1",
                @"baiDuBottomMenu2",
                @"baiDuBottomMenu3",
                @"baiDuBottomMenu4",
                @"baiDuBottomMenu5",
                @"baiDuBottomMenu6",
                @"baiDuBottomMenu7",
                @"baiDuBottomMenu8"];
    
    _titles = @[@"全部",@"最近上传",@"图片",@"文档",@"视频",@"音乐",@"应用",@"其他"];
    _index = -1;
    
}

- (void)creatUI
{
    self.navigationItem.title = @"百度底部菜单";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.categoryView];
    [self arrowIV];
    
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:_images[indexPath.item]];
    cell.label.text = _titles[indexPath.item];
    
    //    NSLog(@"_index: %ld", _index);
    if (indexPath.item == _index) {
        cell.label.textColor = [UIColor redColor];
        
    }else {
        cell.label.textColor = [UIColor blackColor];
    }
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSLog(@"item: %ld", indexPath.item);
    
    NSLog(@"title: %@", _titles[indexPath.item]);
    
    _index = indexPath.item;
    
    [self dismissControl];
}

#pragma mark - 懒加载
- (UIView *)categoryView
{
    if (!_categoryView)
    {
        _categoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    }
    return _categoryView;
    
}

- (UIButton *)categoryBtn
{
    if (!_categoryBtn) {
        _categoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_categoryBtn setTitle:@"分类" forState:UIControlStateNormal];
        [self.categoryView addSubview:_categoryBtn];
        [_categoryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.mas_equalTo(0);
        }];
        [_categoryBtn addTarget:self action:@selector(clickCategoryBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _categoryBtn;
}

- (void)clickCategoryBtn:(UIButton *)sender
{
    //    NSLog(@"clickCategoryBtn");
    
    if (!_isDropDownMenu)
    {
        [UIView animateWithDuration:kDuration animations:^{
            self.control.alpha = 0.3f;
            self.dropDownMenuView.frame = CGRectMake(0, kHeight - kHeight/4, kWidth, kHeight/4);
            self.dropDownMenuView.alpha = 1.0f;
            self.arrowIV.transform = CGAffineTransformRotate(self.arrowIV.transform, M_PI);
            
        }];
        _isDropDownMenu = YES;
        
        [self.collectionView reloadData];
        
    }else
    {
        [self dismissControl];
    }
    
}

- (UIImageView *)arrowIV
{
    if (!_arrowIV)
    {
        _arrowIV = [UIImageView new];
        _arrowIV.image = [UIImage imageNamed:@"baiDuBottomMenu_arrow"];
        [self.categoryView addSubview:_arrowIV];
        [_arrowIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.categoryBtn.mas_right).mas_equalTo(10);
            make.centerY.mas_equalTo(self.categoryBtn);
        }];
    }
    return _arrowIV;
}

- (UIView *)dropDownMenuView
{
    if (!_dropDownMenuView)
    {
        _dropDownMenuView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight, kWidth, kHeight/4)];
        _dropDownMenuView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.dropDownMenuView];
    }
    return _dropDownMenuView;
    
}

- (UIControl *)control
{
    if (!_control)
    {
        _control = [UIControl new];
        _control.backgroundColor = [UIColor blackColor];
        _control.alpha = 0.0f;
        [self.view addSubview:_control];
        [_control mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        [_control addTarget:self action:@selector(clickControl:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _control;
    
}

- (void)clickControl:(UIControl *)sender
{
    [self dismissControl];
}

- (void)dismissControl
{
    _isDropDownMenu = NO;
    
    [UIView animateWithDuration:kDuration animations:^{
        self.dropDownMenuView.frame = CGRectMake(0, kHeight, kWidth, kHeight/4);
        self.control.alpha = 0.0f;
        self.arrowIV.transform = CGAffineTransformRotate(self.arrowIV.transform, M_PI);
        self.dropDownMenuView.alpha = 0.0f;
    }];
}

- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        flowLayout.itemSize = CGSizeMake(90, 85);
        //定义每个UICollectionView 横向的间距
        flowLayout.minimumLineSpacing = 0;
        //定义每个UICollectionView 纵向的间距
        flowLayout.minimumInteritemSpacing = 0;
        _collectionView.scrollEnabled = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self.dropDownMenuView addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        [_collectionView registerNib:[UINib nibWithNibName:@"CategoryCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
