//
//  AppDelegate.h
//
//  Created by MCL on 16/7/13.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "LeftMenuView.h"
#import "LeftMenuTableView.h"
#import "Tools.h"
#import "UIView+Extend.h"

@interface LeftMenuView()<UIGestureRecognizerDelegate, UIActionSheetDelegate>
//required
@property (nonatomic, strong) UIViewController              *ContainerVC;
@property (nonatomic, strong) UIView                        *maskView;

//自定义视图
@property (nonatomic, strong) UIView                        *topBackView;
@property (nonatomic, strong) UIButton                      *btnHead;
@property (nonatomic, strong) UIImageView                   *imgHead;

//@property (nonatomic, strong) UIButton                    *btnLoginOut;
@property (nonatomic, strong) LeftMenuTableView             *menuTableView;
@property (nonatomic, assign) BOOL                          isOpeningMenu;

@end

@implementation LeftMenuView

NSInteger menuViewWith = 275;//6的size

//Objective-C中的单例
static LeftMenuView *menuView = nil;
+ (instancetype)ShareManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        menuViewWith = screenWidth - 100;//兼容4 5 6p
        menuView = [[self alloc] initWithFrame:CGRectMake(- menuViewWith, 0, menuViewWith, screenHeight)];
    });
    return menuView;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        menuView = [super allocWithZone:zone];
    });
    return menuView;
}

- (instancetype)initWithContainerViewController:(UIViewController *)containerVC{
    
    if (self = [super init]) {
        _ContainerVC = containerVC;
        self.isLeftViewHidden = YES;
        _maskView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _maskView.backgroundColor = [UIColor grayColor];//菜单显示时 右边的背景色
        _maskView.hidden = YES;
        [_ContainerVC.view addSubview:_maskView];
        [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        [self addRecognizer];

    }
    
    return self;
}

//拖出menu
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"frame"]) {
        CGRect new = [change[@"new"] CGRectValue];
        CGFloat x = new.origin.x;
        if (x != - menuViewWith) {
            _maskView.hidden = NO;
            _maskView.alpha = (x + menuViewWith)/menuViewWith*0.5;
        }else
        {
            _maskView.hidden = YES;
        }
    }
}

#pragma mark - UIPanGestureRecognizer
-(void)addRecognizer{
    
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(didPanEvent:)];
    pan.delegate = self;
    [_ContainerVC.view addGestureRecognizer:pan];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeLeftViewEvent:)];
    [_maskView addGestureRecognizer:tap];

}

-(void)closeLeftViewEvent:(UITapGestureRecognizer *)recognizer{
    
    [self closeLeftView];
}

-(void)didPanEvent:(UIPanGestureRecognizer *)recognizer{
    
    CGPoint translation = [recognizer translationInView:_ContainerVC.view];
//    NSLog(@"translation.x == %f", translation.x);
    [recognizer setTranslation:CGPointZero inView:_ContainerVC.view];
    
    if(UIGestureRecognizerStateBegan == recognizer.state ||
       UIGestureRecognizerStateChanged == recognizer.state){
        
        if (translation.x > 0 ) {//SwipRight
            
            if (self.x == 0) {
                return;
            }
            CGFloat tempX = self.x + translation.x;
            if (tempX <= 0) {
                
                self.frame = CGRectMake(tempX, 0, menuViewWith, screenHeight);
                
            }else{
                
                self.frame = CGRectMake(0, 0, menuViewWith, screenHeight);
            }
            
        }else{//SwipLeft
            
            CGFloat tempX = self.x + translation.x;
            self.frame = CGRectMake(tempX, 0, menuViewWith, screenHeight);
        }
        
    }else{
//        NSLog(@"shoushi ting zhi");
        
        if (self.x >= - menuViewWith * 0.5) {
            
            [self openLeftView];
            
        }else{
            
            [self closeLeftView];
        }
    }
}

/**
 *  关闭左视图
 */
- (void)closeLeftView
{
    if (!_isOpeningMenu)
    {
        [UIView animateWithDuration:0.3 animations:^{
            
            self.frame = CGRectMake(- menuViewWith, 0, menuViewWith, screenHeight);
            self.isLeftViewHidden = YES;
            _maskView.hidden = YES;
        }];
    }
    
}

- (void)openLeftView
{
    
    WS(ws);
    //当点击打开侧滑菜单的时候，不允许点击空白关闭侧滑菜单
    ws.isOpeningMenu = YES;
    [UIView animateWithDuration:0.3 animations:^{
        
        ws.frame = CGRectMake(0, 0, menuViewWith, screenHeight);
        ws.isLeftViewHidden = NO;
    } completion:^(BOOL finished) {
        
        ws.isOpeningMenu = NO;
        ws.maskView.hidden = NO;
        ws.maskView.alpha = 0.5;
        
        [ws.menuViewClickActionDelegate leftMenuOpenFinished];
    }];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    if ([otherGestureRecognizer.view isKindOfClass:[UITableView class]]) {
        
        return NO;
    }
    
    return YES;
}

#pragma mark - Private
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self=[super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        //背景view
        _topBackView = [[UIImageView alloc] init];
        _topBackView.backgroundColor = colorHomeBlue;
        [self addSubview:_topBackView];
        
        //头像Button
        _btnHead = [[UIButton alloc]init];
        [_btnHead addTarget:self action:@selector(changeHeaderImage) forControlEvents:UIControlEventTouchUpInside];
        _imgHead = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"noOrder"]];
        _imgHead.backgroundColor = [UIColor blackColor];
        _imgHead.layer.cornerRadius = 23;
        _imgHead.layer.masksToBounds = YES;
        [self addSubview:_btnHead];
        
        //手机号
        _labPhoneNo = [[UILabel alloc]init];
        _labPhoneNo.text = @"18385099999";
        _labPhoneNo.textColor = [UIColor whiteColor];
        _labPhoneNo.font = [UIFont systemFontOfSize:22];
        _labPhoneNo.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_labPhoneNo];
        
        //退出按钮
//        _btnLoginOut = [[UIButton alloc]init];
//        _btnLoginOut.backgroundColor = colorBlueButton;
//        [_btnLoginOut setTitle:@"退出当前账户" forState:UIControlStateNormal];
//        [_btnLoginOut.titleLabel setFont:[UIFont systemFontOfSize:16]];
//        [_btnLoginOut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [_btnLoginOut addTarget:self action:@selector(loginOutAction) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:_btnLoginOut];
        
        //tableview
        _menuTableView = [[LeftMenuTableView alloc]init];
        _menuTableView.backgroundColor = [UIColor whiteColor];
        __block LeftMenuView *blockSelf = self;
        _menuTableView.menuActionBlock = ^(NSString *name){
            
            if (blockSelf.menuViewClickActionDelegate) {
                [blockSelf.menuViewClickActionDelegate LeftMenuViewActionIndex:name];
            }
        };
        [self addSubview:_menuTableView];
        
    }
    //注册通知观察者（接受通知，将记录跳转界面的值从主控制器传过来）
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(UpdateUserData:) name:@"UpdateUserData" object:nil];
    return  self ;
    
}

- (void)layoutSubviews{
    
    _imgHead.frame = CGRectMake(5, 35, 46, 46);
    [_btnHead addSubview:_imgHead];
    
    CGFloat marginX = 23;
    
    _topBackView.frame = CGRectMake(0, 0, self.width, 100);
    
    _labPhoneNo.frame = CGRectMake(CGRectGetMaxX(_imgHead.frame) + 5, CGRectGetMinY(_imgHead.frame) + 10, 200, marginX);
    
//    CGFloat addBtnW = 30;
//    _btnLoginOut.frame = CGRectMake(marginX, screenHeight - 35 - addBtnW, self.width - marginX * 2, 39);
//    [_btnLoginOut setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, addBtnW)];
//    [_btnLoginOut setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    
    CGFloat tablView_top = CGRectGetMaxY(_topBackView.frame);
    CGFloat tableView_Bottom = screenHeight - 20;
    _menuTableView.frame = CGRectMake(0, tablView_top, self.width, tableView_Bottom - tablView_top);
}

- (void)UpdateUserData:(NSNotification *)notify{
    
//    NSLog(@"UpdateUserData");
}

- (void)changeHeaderImage{
    
//    NSLog(@"changeHeaderImage");
}

- (void)loginOutAction{

//    NSLog(@"loginOutAction");
    if (_menuViewClickActionDelegate) {
        [_menuViewClickActionDelegate LeftMenuViewActionIndex:@"loginOutAction"];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeObserver:self forKeyPath:@"frame"];
    [Tools NSLogClassDestroy:self];
}

@end
