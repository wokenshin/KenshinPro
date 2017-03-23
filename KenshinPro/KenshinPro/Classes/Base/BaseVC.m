//
//  BaseVC.m
//  KenshinPro
//
//  Created by kenshin on 17/3/16.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "BaseVC.h"

//跳转到系统的通讯录选择手机号码后_返回获取手机号 注意！ 需要在info.plish 中设置 通讯录权限
#import <AddressBookUI/ABPeoplePickerNavigationController.h>
#import <AddressBook/ABPerson.h>
#import <AddressBookUI/ABPersonViewController.h>

#import <MessageUI/MessageUI.h>//导入发短信头文件 类库
@interface BaseVC ()<ABPersonViewControllerDelegate, ABPeoplePickerNavigationControllerDelegate,//通讯录代理
                    MFMessageComposeViewControllerDelegate>//发短信代理>


@property (nonatomic, strong) MBProgressHUD                     *juHua;
@property (nonatomic, copy) voidBlock                           clickRightBtnCallback;//导航栏右边的按钮block
@property (nonatomic, copy) voidBlock                           clickLeftBtnCallback;//导航栏左边的按钮block

@property (nonatomic, copy) PhoneNoBlock                        phoneNoCallback;
@property (nonatomic, copy) MSMNoBlock                          sendMsmCallback;

@end

@implementation BaseVC

//如果子类是xibVC的话，要继承这个VC的xib需要用下面的方式进行初始化
- (instancetype)initWithNib
{
    self = [super initWithNibName:NSStringFromClass([self.superclass class]) bundle:[NSBundle mainBundle]];
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addTapClickBackCloseKeyBoard];
    [self setBackButtonNoTitle];//隐藏导航栏返回按钮的标题 只显示返回按钮的箭头
    
}

- (void)setBackButtonNoTitle
{
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc]initWithTitle:@""
                                                               style:UIBarButtonItemStylePlain
                                                              target:nil
                                                              action:nil];
    self.navigationItem.backBarButtonItem = leftBar;
    //下面两行代码如果有的话 将会导致控制器view中的y值 自动下降导航栏个高度 44+20
    //    self.extendedLayoutIncludesOpaqueBars = NO;
    //    self.edgesForExtendedLayout = UIRectEdgeLeft | UIRectEdgeBottom;
    
}


/**
 添加手势，点击空白view时触发closeKeyBoard 关闭软键盘
 */
- (void)addTapClickBackCloseKeyBoard
{
    //添加手势 点击空白关闭软键盘 -> closeKeyBoard
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                         action:@selector(closeKeyBoard)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    
}

//关闭软键盘
- (void)closeKeyBoard
{
    [self.view endEditing:YES];
    
}

- (void)setNavRightBtnWithImg:(NSString *)imgName andClickResultblock:(voidBlock )block
{
    //eg: 需要注意 这里的图片最要是使用2倍或者3倍的 不然会显示得很的张
    UIImage *image = [UIImage imageNamed:imgName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//IOS 7以上要设置图片渲染模式
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(clickRightNavBtn)];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    self.clickRightBtnCallback = block;
    
}

- (void)setNavRightBtnWithName:(NSString *)btnName andClickResultblock:(voidBlock )block
{
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    
    [rightBtn setTitle:btnName forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, btnName.length*20, 44);
    
    //事件
    [rightBtn addTarget:self action:@selector(clickRightNavBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* rightBtnItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [self.navigationItem setRightBarButtonItem:rightBtnItem];
    self.clickRightBtnCallback = block;
    
}

- (void)setNavRightBtnWithName:(NSString *)btnName
                andTitleColor:(UIColor *)color
          andClickResultblock:(voidBlock )block
{
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    
    [rightBtn setTitle:btnName forState:UIControlStateNormal];
    [rightBtn setTitleColor:color forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, btnName.length*20, 44);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    //事件
    [rightBtn addTarget:self action:@selector(clickRightNavBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* rightBtnItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [self.navigationItem setRightBarButtonItem:rightBtnItem];
    self.clickRightBtnCallback = block;
    
}

- (void)setNavLeftBtnWithImg:(NSString *)imgName andClickResultblock:(voidBlock )block
{
    UIImage *image = [UIImage imageNamed:imgName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//IOS 7以上要设置图片渲染模式
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftNavBtn)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    self.clickLeftBtnCallback = block;
    
}

- (void)setNavLeftBtnWithName:(NSString *)btnName andClickResultblock:(voidBlock )block
{
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    
    [rightBtn setTitle:btnName forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, btnName.length*20, 44);
    
    //事件
    [rightBtn addTarget:self action:@selector(clickLeftNavBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* leftBtnItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [self.navigationItem setLeftBarButtonItem:leftBtnItem];
    self.clickLeftBtnCallback = block;
    
}

- (void)setNavLeftBtnWithName:(NSString *)btnName
               andTitleColor:(UIColor *)color
         andClickResultblock:(voidBlock )block
{
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    
    [rightBtn setTitle:btnName forState:UIControlStateNormal];
    [rightBtn setTitleColor:color forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, btnName.length*20, 44);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    //事件
    [rightBtn addTarget:self action:@selector(clickLeftNavBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* leftBtnItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [self.navigationItem setLeftBarButtonItem:leftBtnItem];
    self.clickLeftBtnCallback = block;
    
}

- (void)clickRightNavBtn
{
    if (_clickRightBtnCallback)
    {
        _clickRightBtnCallback();
    }
    else
    {
        NSLog(@"设置导航栏右边的按钮的点击blcok粗错啦");
    }
    
}

- (void)clickLeftNavBtn
{
    if (_clickLeftBtnCallback)
    {
        _clickLeftBtnCallback();
    }
    else
    {
        NSLog(@"设置导航栏左边的按钮的点击blcok粗错啦");
    }
    
}

- (void)toast:(NSString *)message
{
    MDToast *toast = [[MDToast alloc] initWithText:@"" duration:kMDToastDurationShort];
    toast.textFont = [UIFont systemFontOfSize:14];
    [toast setGravity:MDGravityCenterVertical | MDGravityCenterHorizontal];
    
    [toast setText:message];
    [toast show];
    
}

- (void)toastBottom:(NSString *)message
{
    MDToast *toast = [[MDToast alloc] initWithText:@"" duration:kMDToastDurationShort];
    toast.textFont = [UIFont systemFontOfSize:14];
    [toast setText:message];
    [toast show];
    
}

//使用懒加载避免重复创建
- (MBProgressHUD *)juHua
{
    if (_juHua == nil)
    {
        _juHua = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
    }
    return _juHua;
    
}

-(void)showJuHua:(NSString *)message
{
    [self hideJuHua];
    self.juHua.mode = MBProgressHUDModeIndeterminate;
    self.juHua.labelText = message;
    
}

-(void)hideJuHua
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}


-(void)showError:(NSString *)message
{
    [MBProgressHUD showError:message];//MJ 包里面的方法
    
}


- (void)showMessage:(NSString *)msg
{
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hub.mode = MBProgressHUDModeText;
    [hub hide:YES afterDelay:1.2];
    hub.labelText = msg;
    
}

- (void)showMessageMLine:(NSString *)message
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    UIFont *font = [UIFont systemFontOfSize:18];
    CGSize size = CGSizeMake(300, 1000);
    CGSize  actualsize =[message boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = message;
    hud.detailsLabelFont = font;
    hud.minSize = CGSizeMake(0, actualsize.height+30);
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:1.2];
    
}

- (void)alertSystemTitle:(NSString *)title
                 message:(NSString *)message
                      OK:(voidBlock)okBlock
{
    UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action){
                                                         okBlock();
                                                        }];
    
    
    [alertCtrl addAction:okAction];
    [self presentViewController:alertCtrl animated:YES completion:nil];
    
}

- (void)alertSystemTitle:(NSString *)title
                 message:(NSString *)message
                      OK:(voidBlock)okBlock
                  Cancel:(voidBlock)cancelBlock
{
    UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action){
                                                            okBlock();
                                                        }];
    
    UIAlertAction *cancel   = [UIAlertAction actionWithTitle:@"取消"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action){
                                                                cancelBlock();
                                                            }];
    [alertCtrl addAction:cancel];
    [alertCtrl addAction:okAction];
    [self presentViewController:alertCtrl animated:YES completion:nil];
    
}

#pragma mark - 进入系统通讯录 选择号码
- (void)selectPhoneNoByContactsWithResultPhoneNo:(PhoneNoBlock)block
{
    _phoneNoCallback = block;
    
    //初始化ABPeoplePickerNavigationController
    ABPeoplePickerNavigationController *nav = [[ABPeoplePickerNavigationController alloc] init];
    nav.peoplePickerDelegate = self;
    if([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
    {
        nav.predicateForSelectionOfPerson = [NSPredicate predicateWithValue:false];
        //在iOS8之后，需要添加nav.predicateForSelectionOfPerson = [NSPredicate predicateWithValue:false];
        //这一段代码，否则选择联系人之后会直接dismiss，不能进入详情选择电话。
        
    }
    //进入通讯录控制器
    [self presentViewController:nav animated:YES completion:nil];
    
}

#pragma mark 代理
//取消选择
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    //删除通讯录控制器
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark iOS8下
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
                         didSelectPerson:(ABRecordRef)person
                                property:(ABPropertyID)property
                              identifier:(ABMultiValueIdentifier)identifier
{
    ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
    long index = ABMultiValueGetIndexForIdentifier(phone,identifier);
    NSString *phoneNO = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phone, index);
    
    if ([phoneNO hasPrefix:@"+"])
    {
        phoneNO = [phoneNO substringFromIndex:3];
    }
    
    phoneNO = [phoneNO stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSLog(@"%@", phoneNO);
    if (phone)//[RegexUtil isValidTelePhone:phoneNO]
    {
        if (_phoneNoCallback)
        {
            _phoneNoCallback(phoneNO);
        }
        [peoplePicker dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    
}

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person
{
    ABPersonViewController *personViewController = [[ABPersonViewController alloc] init];
    personViewController.displayedPerson = person;
    [peoplePicker pushViewController:personViewController animated:YES];
    
}

#pragma mark IOS7下
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    return YES;
    
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person
                                property:(ABPropertyID)property
                              identifier:(ABMultiValueIdentifier)identifier
{
    ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
    long index = ABMultiValueGetIndexForIdentifier(phone,identifier);
    NSString *phoneNO = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phone, index);
    if ([phoneNO hasPrefix:@"+"])
    {
        phoneNO = [phoneNO substringFromIndex:3];
        
    }
    
    phoneNO = [phoneNO stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSLog(@"%@", phoneNO);
    if (phone)//[RegexUtil isValidTelePhone:phoneNO]
    {
        if (_phoneNoCallback)
        {
            _phoneNoCallback(phoneNO);
        }
        [peoplePicker dismissViewControllerAnimated:YES completion:nil];
        return NO;
    }
    return YES;
    
}

//具体点进去看注释
- (BOOL)personViewController:(ABPersonViewController *)personViewController shouldPerformDefaultActionForPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    return YES;
    
}

#pragma mark - 发送短信
- (void)sendMSMPhoneNos:(NSArray *)phoneNos
                 title:(NSString *)title
               content:(NSString *)content
           resultBlock:(MSMNoBlock)block
{
    _sendMsmCallback = block;
    [self sendMSMWithPhoneNos:phoneNos title:title body:content];
    
}

#pragma mark 发短信--->从vc返回后 会调用 代理:messageComposeViewController
-(void)sendMSMWithPhoneNos:(NSArray *)phones title:(NSString *)title body:(NSString *)body
{
    if( [MFMessageComposeViewController canSendText] )
    {
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
        controller.recipients = phones;
        controller.navigationBar.tintColor = [UIColor redColor];
        controller.body = body;
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:title];//修改短信界面标题
    }
    else
    {
        [self alertSystemTitle:@"提示" message:@"该设备不支持短信功能" OK:^{}];
    }
}

#pragma mark 发短信 pop代理
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];
    switch (result)
    {
        case MessageComposeResultSent:
        {
//            [self alertSystemTitle:@"提示" message:@"短信发送成功" OK:^{}];
            if (_sendMsmCallback)
            {
                _sendMsmCallback(YES);
            }
        }
            break;
        case MessageComposeResultFailed:
        {
//            [self alertSystemTitle:@"提示" message:@"短信发送失败" OK:^{}];
            if (_sendMsmCallback)
            {
                _sendMsmCallback(NO);
            }
        }
            break;
        case MessageComposeResultCancelled:
        {
//            [self alertSystemTitle:@"提示" message:@"短信发送被取消" OK:^{}];
            NSLog(@"短信发送被取消");
        }
            break;
        default:
            break;
    }
    
}

@end
