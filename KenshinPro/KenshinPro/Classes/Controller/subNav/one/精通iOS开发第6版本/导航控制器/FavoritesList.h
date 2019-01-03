//
//  FavoritesList.h
//  KenshinPro
//
//  Created by apple on 2019/1/2.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FavoritesList : NSObject

+ (instancetype)sharedFavoritesList;

- (NSArray *)favorites;

- (void)addFavorite:(id)item;
- (void)removeFavorite:(id)item;

//将数组中的 某行数据移动到其他行
- (void)moveItemAtIndex:(NSInteger)from toIndex:(NSInteger)to;

@end

NS_ASSUME_NONNULL_END
