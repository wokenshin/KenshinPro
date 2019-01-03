//
//  FavoritesList.m
//  KenshinPro
//
//  Created by apple on 2019/1/2.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "FavoritesList.h"


@interface FavoritesList()

@property(nonatomic, strong) NSMutableArray *favorites;

@end

static NSString *UD_favorites = @"favorites";
@implementation FavoritesList

+ (instancetype)sharedFavoritesList{
    static FavoritesList *share = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[FavoritesList alloc] init];
    });
    return share;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSArray *sortedFavorites = [defaults objectForKey:UD_favorites];
        if (sortedFavorites) {
            _favorites = [sortedFavorites mutableCopy];
        } else {
            _favorites = [NSMutableArray array];
        }
        
    }
    return self;
}

- (void)addFavorite:(id)item{
    [_favorites insertObject:item atIndex:0];
    [self saveFavorites];
}

- (void)removeFavorite:(id)item{
    [_favorites removeObject:item];
    [self saveFavorites];
}

- (void)saveFavorites{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_favorites forKey:UD_favorites];
    [defaults synchronize];
}

//移动行
- (void)moveItemAtIndex:(NSInteger)from toIndex:(NSInteger)to{
    
    if (to > [_favorites count]) {
        NSLog(@"FavoritesList.h 插入数据的位置越界！！！");
        return;
    }
    id item = _favorites[from];
    [_favorites removeObjectAtIndex:from];
    [_favorites insertObject:item atIndex:to];
    [self saveFavorites];
    
}
@end
