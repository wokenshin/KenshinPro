//
//  BaseVC.m
//  KenshinPro
//
//  Created by kenshin on 17/3/16.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "BaseVC.h"

//跳转到系统的通讯录选择手机号码后_返回获取手机号 注意！ 需要在info.plish 中设置 通讯录权限
//IOS10之前获取通讯录
#import <AddressBookUI/ABPeoplePickerNavigationController.h>
#import <AddressBook/ABPerson.h>
#import <AddressBookUI/ABPersonViewController.h>

//IOS10之后获取通讯录
#import <ContactsUI/ContactsUI.h>

#import <MessageUI/MessageUI.h>//导入发短信头文件 类库
@interface BaseVC ()<ABPersonViewControllerDelegate,
ABPeoplePickerNavigationControllerDelegate,//通讯录代理<IOS10
CNContactPickerDelegate,//通讯录>=IOS10
                    MFMessageComposeViewControllerDelegate,//发短信代理
UINavigationControllerDelegate, UIImagePickerControllerDelegate>//获取相册 or 拍照中的图片


@property (nonatomic, copy) VoidBlock                           clickRightBtnCallback;//导航栏右边的按钮block
@property (nonatomic, copy) VoidBlock                           clickLeftBtnCallback;//导航栏左边的按钮block

@property (nonatomic, copy) PhoneNoBlock                        phoneNoCallback;
@property (nonatomic, copy) MSMNoBlock                          sendMsmCallback;

@property (nonatomic, strong) UIImagePickerController           *imgPicker;//拍照获取图片 和 选中本地图片
@property (nonatomic, copy)   BlockPhoto                        photoCallback;

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
//    self.view.backgroundColor = [UIColor whiteColor];//设置背景色
    [self addTapClickBackCloseKeyBoard];
    [self setBackButtonNoTitle];//隐藏导航栏返回按钮的标题 只显示返回按钮的箭头
    [self cancelAutoDownMove];//取消自动下移
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_fxw_isDisablePopGesture)//禁用返回手势
    {
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
        {
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //可用返回手势[注意这里如果写在 didDis方法内 这里的if是不会触发的]
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"tips-------->>>当前控制器是:%@ 标题:%@", NSStringFromClass([self class]), self.navigationItem.title);
    
}

- (void)cancelAutoDownMove
{
    //有了下面两段代码之后，所有滚动视图极其子类都不会自动下移64了 所以在有导航栏的控制器中使用tableview y值需要+64 高度需要减64 如果有tabBar 还需要减49
    /*
     会导致滚动视图极其子类自动下移的情况
     1.导航栏控制器 默认就会自动下移64 导航栏的高度就是64
     2.在设置导航栏背景图片的时候 还会倒是 view层自动下移
     如：
     [self.navigationController.navigationBar
     setBackgroundImage:[UIImage imageNamed:@"navigation"]
     forBarPosition:UIBarPositionAny
     barMetrics:UIBarMetricsDefault];
     */
    self.automaticallyAdjustsScrollViewInsets = NO; //取消scrollview的自动像素下移
    self.extendedLayoutIncludesOpaqueBars     = YES;//取消navigationbar导致的view层自动下移
    
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
                                                                         action:@selector(fxw_closeKeyBoard)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    
}

//关闭软键盘
- (void)fxw_closeKeyBoard
{
    [self.view endEditing:YES];
    
}

//获取指定控制器
- (UIViewController *)getViewControllerWithClass:(Class)vcClass;
{
    for (UIViewController *controller in self.navigationController.viewControllers)
    {
        if ([controller isKindOfClass:vcClass])
        {
            return controller;
        }
    }
    return nil;
}

- (void)setNavRightBtnWithImg:(NSString *)imgName andClickResultblock:(VoidBlock )block
{
    //eg: 需要注意 这里的图片最要是使用2倍或者3倍的 不然会显示得很的张
    UIImage *image = [UIImage imageNamed:imgName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//IOS 7以上要设置图片渲染模式
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(clickRightNavBtn)];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    self.clickRightBtnCallback = block;
    
}

- (void)setNavRightBtnWithName:(NSString *)btnName andClickResultblock:(VoidBlock )block
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
          andClickResultblock:(VoidBlock )block
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

- (void)setNavLeftBtnWithImg:(NSString *)imgName andClickResultblock:(VoidBlock )block
{
    UIImage *image = [UIImage imageNamed:imgName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//IOS 7以上要设置图片渲染模式
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftNavBtn)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    self.clickLeftBtnCallback = block;
    
}

- (void)setNavLeftBtnWithName:(NSString *)btnName andClickResultblock:(VoidBlock )block
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
         andClickResultblock:(VoidBlock )block
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
    NSLog(@"%@", message);
}

- (void)toastBottom:(NSString *)message
{
    MDToast *toast = [[MDToast alloc] initWithText:@"" duration:kMDToastDurationShort];
    toast.textFont = [UIFont systemFontOfSize:14];
    [toast setText:message];
    [toast show];
    NSLog(@"%@", message);
}


-(void)showJuHua:(NSString *)message
{
    [self hideJuHua];
    
    //其实这里统一使用self.view就可以了，但是这样的话，navc 的返回按钮是可以点击的
    if (self.navigationController == nil)//因为有些页面是模态出来的 没有导航栏控制器 那样的话使用会崩溃
    {
        MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hub.mode = MBProgressHUDModeIndeterminate;
        hub.labelText = message;
    }
    else
    {
        MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hub.mode = MBProgressHUDModeIndeterminate;
        hub.labelText = message;
    }
    
}

-(void)hideJuHua
{
    if (self.navigationController == nil)//因为有些页面是模态出来的 没有导航栏控制器 那样的话使用会崩溃
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
    else
    {
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    }
    
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
                      OK:(VoidBlock)okBlock
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
                      OK:(VoidBlock)okBlock
                  Cancel:(VoidBlock)cancelBlock
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
    
    //需要区别一下当前系统 测试 在5C上没有区分系统直接调用ABPeoplePickerNavigationController 导致崩溃
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 10.0)
    {
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
    else
    {
        CNContactPickerViewController * contactVc = [CNContactPickerViewController new];
        contactVc.delegate = self;
        [self presentViewController:contactVc animated:YES completion:nil];
    }
    
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
    
    //取消号码中的特殊符号
    phoneNO = [phoneNO stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
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
    
    //取消号码中的特殊符号
    phoneNO = [phoneNO stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
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

#pragma mark 这个方法调用会进入通讯录详情界面 >=IOS10
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty {
    
//    NSString *firstName = contactProperty.contact.familyName;
//    NSString *lastName = contactProperty.contact.givenName;
//    NSString *Name = [NSString stringWithFormat:@"%@%@",firstName,lastName];
    NSString *phoneNum = [contactProperty.value stringValue];
    
    //去掉获取的电话号码中的特殊符号
    NSString *phoneString = [phoneNum stringByReplacingOccurrencesOfString:@"-" withString:@""];
    if (_phoneNoCallback)
    {
        _phoneNoCallback(phoneString);
    }
    
}

//取消选择回调 >=IOS10
- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
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

//拨号
- (void)callNo:(NSString *)no
{
    //如果 no 为 @“”，不会有任何反应
    //如果 no 为 nil， 会提示是否呼叫，可以打出去
    
    //[Tools tellPhoneWithNo:no];
    
    //等同注释掉的代码
    NSString *protocol = [NSString stringWithFormat:@"tel://%@", no];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:protocol]];
    
}

//当前根视图
- (void)fxw_changeRootVCWithAnimation:(UIViewController *)vc
{
    //切换根控制器 有一个渐变的效果
    // options是动画选项
    [UIView transitionWithView:[UIApplication sharedApplication].keyWindow duration:0.5f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        [UIApplication sharedApplication].keyWindow.rootViewController = vc;
        [UIView setAnimationsEnabled:oldState];
        
    } completion:^(BOOL finished) {}];
    
}

#pragma mark - 获取相册 or 拍照
//懒加载
- (UIImagePickerController *)imgPicker
{
    if (_imgPicker == nil)
    {
        _imgPicker = [[UIImagePickerController alloc] init];
        _imgPicker.delegate      = self;//实现委托，委托必须实现UIImagePickerControllerDelegate协议，来对用户在图片选取器中的动作进行监听
        _imgPicker.allowsEditing = YES;//在选定图片之前，用户可以简单编辑要选的图片。包括上下移动改变图片的选取范围，用手捏合动作改变图片的大小等。
    }
    return _imgPicker;
    
}

#pragma mark 获取本地图片
- (void)fxw_photoLocalWithResultBlock:(BlockPhoto)resultBlock
{
    _photoCallback = resultBlock;
    
    //创建图片选择器
    self.imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//指定源的类型
    //设置完iamgePicker后，就可以启动了。用以下方法将图像选取器的视图“推”出来
    [self presentViewController:self.imgPicker animated:YES completion:nil];
    
}

#pragma mark 拍照获取图片
- (void)fxw_photoTakeWithResultBlock:(BlockPhoto)resultBlock
{
    _photoCallback = resultBlock;
    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        self.imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;//指定源的类型
        [self presentViewController:self.imgPicker animated:YES completion:nil];
    }
    else
    {
        [Tools toast:@"模拟其中无法打开照相机" andCuView:self.view];
    }
    
}

#pragma mark 拍照or选择本地图片 选择后 进入本函数
-(void)imagePickerController:(UIImagePickerController*)ImgPicker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData   UIImagePickerControllerReferenceURL
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        //其实这里可以根据需求判断大小 然后再做压缩处理
        NSData  *data  = UIImageJPEGRepresentation(image, 0.6);//压缩比例 默认值为：1
        
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString *pathDoc = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png【保存为 xxx.png】
        NSString *headerPng = @"/用户头像.png";
        NSString *imgPath   = [pathDoc stringByAppendingString:headerPng];
        //将图片保存到Documents 中
        [fileManager createDirectoryAtPath:pathDoc withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:imgPath contents:data attributes:nil];
        
        //关闭相册界面
        [ImgPicker dismissViewControllerAnimated:YES completion:nil];
        NSLog(@"保存图片成功， path:%@/%@", pathDoc, headerPng);
        
        if (_photoCallback) {
            _photoCallback(data, imgPath);
            _photoCallback = nil;//避免两个地方的回调出现错误
        }
        
    }
    else
    {
        NSLog(@"父类 imgPicker 出错了");
    }
    
}

@end
