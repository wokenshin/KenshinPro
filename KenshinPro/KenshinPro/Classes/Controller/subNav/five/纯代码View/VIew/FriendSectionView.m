//
//  FriendSectionView.m
//  KenshinPro
//
//  Created by apple on 2018/5/3.
//  Copyright © 2018年 Kenshin. All rights reserved.
//

#import "FriendSectionView.h"
#import "Masonry.h"

@interface FriendSectionView()

@property (nonatomic, strong) UIImageView     *imgArrow;
@property (nonatomic, strong) UILabel         *labSectionName;
@property (nonatomic, strong) UILabel         *labSumFriends;
@property (nonatomic, strong) UIButton        *btnClick;

@property (nonatomic, copy) BlockFriendSection        blockClick;
@property (nonatomic, copy) BlockFriendSection        blockLongPress;

@property (nonatomic, assign) BOOL flag;

@end;

@implementation FriendSectionView

+ (FriendSectionView *)jjsj_create
{
    FriendSectionView *cell = [[FriendSectionView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 40)];
    
    //箭头
    cell.imgArrow = [[UIImageView alloc] init];
    cell.imgArrow.image = [UIImage imageNamed:@"arrow_right_gray"];
    [cell addSubview:cell.imgArrow];
    [cell.imgArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
    }];
    
    //好友个数
    cell.labSumFriends = [[UILabel alloc] init];
    cell.labSumFriends.text = @"11";
    [cell addSubview:cell.labSumFriends];
    [cell.labSumFriends mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-5);
        make.height.mas_equalTo(20);
    }];
    
    //分组名
    cell.labSectionName = [[UILabel alloc] init];
    cell.labSectionName.text = @"我的好友我的好友我的好友我的好友我的好友我的好友我的好友";
    [cell addSubview:cell.labSectionName];
    [cell.labSectionName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cell.imgArrow.mas_right).offset(5);
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(20);
    }];
    
    cell.btnClick = [[UIButton alloc] init];
    [cell.btnClick addTarget:cell action:@selector(clickBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:cell.btnClick];
    [cell.btnClick mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    //长按手势
    UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    recognizer.minimumPressDuration = 0.5; //设置最小长按时间；默认为0.5秒
    [cell addGestureRecognizer:recognizer];
    cell.userInteractionEnabled = YES;
    
    return cell;
}


//点击视图
- (void)clickBtnAction{
    if (_blockClick){
        _blockClick(self);
    }
    if (_flag) {
        [self closeSection];
    }
    else{
        [self openSection];
    }
    _flag = !_flag;
}

//点击视图回调
- (void)click:(BlockFriendSection)resultBlock{
    _blockClick = resultBlock;
}


- (void)handleLongPress:(UILongPressGestureRecognizer *)recognizer{
    if (recognizer.state == UIGestureRecognizerStateBegan)//如果这里不判断的话 事件会触发两次 一次是事件的开始，一次是事件的结束
    {
        if (_blockLongPress){
            _blockLongPress(self);
        }
    }
    
}

//长按事件
- (void)longPress:(BlockFriendSection)resultBlock{
    _blockLongPress = resultBlock;
}

- (void)closeSection
{
    __weak typeof(self) ws = self;
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
        CGAffineTransform currentTransform = ws.imgArrow.transform;
        CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, -M_PI/2); // 在现在的基础上旋转指定角度
        ws.imgArrow.transform = newTransform;
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)openSection
{
    __weak typeof(self) ws = self;
    [UIView animateWithDuration:0.3 delay:0.0 options: UIViewAnimationOptionAllowUserInteraction
     | UIViewAnimationOptionCurveLinear animations:^{
         CGAffineTransform currentTransform = ws.imgArrow.transform;
         CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, M_PI/2); // 在现在的基础上旋转指定角度
         ws.imgArrow.transform = newTransform;
         
     } completion:^(BOOL finished) {
         
     }];
}

@end
