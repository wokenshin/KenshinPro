//
//  JJCircleView.m
//  KenshinPro
//
//  Created by apple on 2018/5/3.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import "JJCircleView.h"
#import "Masonry.h"

@interface JJCircleView()

//我的群聊
@property (nonatomic, strong) UIImageView *imgHeadGroup;
@property (nonatomic, strong) UILabel     *labTitleGroup;
@property (nonatomic, strong) UIButton    *btnActionClickGroup;

//我的房间
@property (nonatomic, strong) UIImageView *imgHeadRoom;
@property (nonatomic, strong) UILabel     *labTitleRoom;
@property (nonatomic, strong) UIButton    *btnActionClickRoom;

//好友分组
@property (nonatomic, strong) UILabel     *labSectionTitle;

@property (nonatomic, copy)   BlockJJCircleView blockClickGroup;
@property (nonatomic, copy)   BlockJJCircleView blockClickRoom;

@end;

@implementation JJCircleView

+ (JJCircleView *)jjsj_createJJCircleView
{
    JJCircleView *selfView = [[JJCircleView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 150)];
    
    UIView *cellGroup = [[UIView alloc] init];
    [selfView addSubview:cellGroup];
    [cellGroup mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(60);
    }];
    
    //头像
    selfView.imgHeadGroup = [[UIImageView alloc] init];
    selfView.imgHeadGroup.image = [UIImage imageNamed:@"im_my_group"];
    [cellGroup addSubview:selfView.imgHeadGroup];
    [selfView.imgHeadGroup mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    //标题
    selfView.labTitleGroup = [[UILabel alloc] init];
    selfView.labTitleGroup.text = @"我的群聊";
    selfView.labTitleGroup.font = [UIFont systemFontOfSize:15];
    [cellGroup addSubview:selfView.labTitleGroup];
    [selfView.labTitleGroup mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(selfView.imgHeadGroup.mas_right).offset(10);
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(20);
    }];
    
    
    //分割线
    UIView *line = [[UIView alloc] init];
    line.alpha = 0.4;
    line.backgroundColor = [UIColor grayColor];
    [cellGroup addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(60);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    //按钮「包裹整个cellGroup」
    selfView.btnActionClickGroup = [[UIButton alloc] init];
    [selfView.btnActionClickGroup addTarget:selfView
                                     action:@selector(clickBtnGroup)
                           forControlEvents:UIControlEventTouchUpInside];
    [cellGroup addSubview:selfView.btnActionClickGroup];
    [selfView.btnActionClickGroup mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    UIView *cellRoom = [[UIView alloc] init];
    [selfView addSubview:cellRoom];
    [cellRoom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(cellGroup.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(60);
    }];
    
    //头像
    selfView.imgHeadRoom = [[UIImageView alloc] init];
    selfView.imgHeadRoom.image = [UIImage imageNamed:@"im_my_room"];
    [cellRoom addSubview:selfView.imgHeadRoom];
    [selfView.imgHeadRoom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    //标题
    selfView.labTitleRoom = [[UILabel alloc] init];
    selfView.labTitleRoom.text = @"我的房间";
    selfView.labTitleRoom.font = [UIFont systemFontOfSize:15];
    [cellRoom addSubview:selfView.labTitleRoom];
    [selfView.labTitleRoom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(selfView.imgHeadGroup.mas_right).offset(10);
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(20);
    }];
    
    //按钮「包裹整个cellRoom」
    selfView.btnActionClickRoom = [[UIButton alloc] init];
    [selfView.btnActionClickRoom addTarget:selfView
                                     action:@selector(clickBtnRoom)
                           forControlEvents:UIControlEventTouchUpInside];
    [cellRoom addSubview:selfView.btnActionClickRoom];
    [selfView.btnActionClickRoom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    //好友分组
    selfView.labSectionTitle = [[UILabel alloc] init];
    selfView.labSectionTitle.text = @"  好友分组";
    selfView.labSectionTitle.backgroundColor = RGB2Color(242, 242, 242);
    [selfView addSubview:selfView.labSectionTitle];
    [selfView.labSectionTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(cellRoom.mas_bottom);
        make.height.mas_equalTo(30);
    }];
    
    return selfView;
    
}

- (void)clickBtnGroup{
    if (_blockClickGroup) {
        _blockClickGroup(self);
    }
}

- (void)clickBtnRoom{
    if (_blockClickRoom) {
        _blockClickRoom(self);
    }
}

- (void)clickGroupCell:(BlockJJCircleView)resultBlock{
    _blockClickGroup = resultBlock;
}

- (void)clickRoomCell:(BlockJJCircleView)resultBlock{
    _blockClickRoom = resultBlock;
}














@end
