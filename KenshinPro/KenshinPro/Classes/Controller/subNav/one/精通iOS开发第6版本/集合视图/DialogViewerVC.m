//
//  DialogViewerVC.m
//  KenshinPro
//
//  Created by apple on 2019/1/3.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "DialogViewerVC.h"
#import "BIDHeaderCell.h"
#import "BIDContentCell.h"

@interface DialogViewerVC ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView  *collectionView;
@property (nonatomic, strong) NSArray            *sections;
@end

@implementation DialogViewerVC

static NSString * const reuseIdentifier = @"BIDContentCell";
static NSString * const IDHeaderCell    = @"BIDHeaderCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    _sections = @[@{@"header":@"First Witch",
                    @"content":@"Hey,when will the three of us meet up later?"},
                  
                  @{@"header":@"Second Witch",
                    @"content":@"When everything's straightened out."},
                  
                  @{@"header":@"Third Witch",
                    @"content":@"That'll be just before sunset."},
                  
                  @{@"header":@"First With",
                    @"content":@"Where?"},
                  
                  @{@"header":@"Second With",
                    @"content":@"The dirt patch."},
                  
                  @{@"header":@"Third Witch",
                    @"content":@"I guess we'll see Mac there."},
                  
                  @{@"header":@"郑",
                    @"content":@"谢谢"},
                  
                  @{@"header":@"郑",
                    @"content":@"谢谢"},
                  
                  @{@"header":@"郑",
                    @"content":@"谢谢"},
                  
                  @{@"header":@"郑",
                    @"content":@"谢谢"},
                  
                  @{@"header":@"郑",
                    @"content":@"谢谢"}
                  ];
    
    
    //布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 4;//同一行相邻两个cell的最小间距
    layout.minimumLineSpacing      = 4;//最小两行之间的间距
    
    //初始化
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate   = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    //注册cell 在表上
    [self.collectionView registerClass:[BIDContentCell class]
            forCellWithReuseIdentifier:reuseIdentifier];
    
    //注册cell 在分区头上[注意区分！]
    [self.collectionView registerClass:[BIDHeaderCell class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:IDHeaderCell];
    
    [self.view addSubview:_collectionView];
    
    //调整布局
    UICollectionViewLayout *layout2  = self.collectionView.collectionViewLayout;
    UICollectionViewFlowLayout *flow = (UICollectionViewFlowLayout *)layout2;
    flow.sectionInset = UIEdgeInsetsMake(10, 20, 30, 20);
    
    //设置标题视图尺寸[如果不设置 就不会显示]
    flow.headerReferenceSize = CGSizeMake(100, 25);
}

//将句子中的单词切割后放到数组并返回
- (NSArray *)wordsInSection:(NSInteger)section{
    NSString *content = _sections[section][@"content"];
    NSCharacterSet *space = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSArray *words = [content componentsSeparatedByCharactersInSet:space];
    return words;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionviewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSArray *words = [self wordsInSection:indexPath.section];
    CGSize size = [BIDContentCell sizeForContentString:words[indexPath.row]];
    return size;
}

#pragma mark -
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [_sections count];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *words = [self wordsInSection:section];
    return [words count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *words = [self wordsInSection:indexPath.section];
    BIDContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                     forIndexPath:indexPath];
    cell.text = words[indexPath.row];
    return cell;
}

//分区头
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqual:UICollectionElementKindSectionHeader]) {
        BIDHeaderCell *cell = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                      withReuseIdentifier:IDHeaderCell
                                                                             forIndexPath:indexPath];
        cell.text = self.sections[indexPath.section][@"header"];
        NSLog(@"row:%ld", (long)indexPath.row);
        return cell;
    }
    return nil;
    
    
}
    



@end
