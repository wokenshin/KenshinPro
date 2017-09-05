//
//  AFNMCVC.m
//  KenshinPro
//
//  Created by kenshin on 17/3/28.
//  Copyright © 2017年 Kenshin. All rights reserved.
//

#import "AFNMCVC.h"
#import "AFN_MC.h"
#import "ModelUploadImg.h"
#import "ImageUtil.h"

@interface AFNMCVC ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

//图片上传 表单方式
@property (nonatomic, strong) UIAlertController             *alertController;
@property (nonatomic, strong) UIImagePickerController       *picker;//拍照获取图片 和 选中本地图片

@end

@implementation AFNMCVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"MC AFN封装";
    
}

- (IBAction)getVerifyCode:(id)sender
{
    NSMutableDictionary *parmsDic = [[NSMutableDictionary alloc] init];
    [parmsDic setObject:@"18385099999" forKey:@"phoneNo"];
    
    [AFN_MC postWithMethod:@"getValidCode"
                    module:@"sms"
                    params:parmsDic
    resultBlock:^(BOOL success, NSDictionary *resultDic, NSString *errorMsg) {
        if (success)
        {
            NSString *code = [resultDic objectForKey:@"validCode"];
            NSLog(@"验证码是 %@", code);
        }
        else
        {
            [self toast:errorMsg];
        }
        
    }];
    
    
}

#pragma mark - 上传图片
- (IBAction)clickUploadImage:(id)sender
{
    /*
     在访问相册 和拍照的地方需要获取对应的权限，权限添加到了info.plist中
     1.从本地选择图片设置头像
     2.拍照设置头像
     3.将设置好的头像图片保存到Documents中
     */
    
    //初始化 图片选择器
    if (_picker == nil)
    {
        _picker = [[UIImagePickerController alloc] init];
        _picker.delegate = self;
        //设置拍照后的图片可被编辑
        _picker.allowsEditing = YES;
    }
    
    self.alertController = [UIAlertController alertControllerWithTitle:@"设置头像"
                                                               message:nil
                                                        preferredStyle:UIAlertControllerStyleActionSheet];
    
    WS(ws);
    UIAlertAction *takePhoto = [UIAlertAction actionWithTitle:@"拍照选择"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action){
                                                          [ws takePhoto];
                                                      }];
    
    UIAlertAction *localPhoto = [UIAlertAction actionWithTitle:@"本地图片"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action){
                                                           [ws localPhoto];
                                                       }];
    
    UIAlertAction *cancelPhoto = [UIAlertAction actionWithTitle:@"取消"
                                                          style:UIAlertActionStyleCancel
                                                        handler:nil];
    
    //按钮的顺序由UIAlertAction 的style来决定的
    [self.alertController addAction:takePhoto];
    [self.alertController addAction:localPhoto];
    [self.alertController addAction:cancelPhoto];
    
    //显示alertController
    [self presentViewController:self.alertController animated:YES completion:nil];
    
}

- (void)takePhoto
{
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;//指定源的类型
        [self presentViewController:self.picker animated:YES completion:nil];
    }
    else
    {
        [self toast:@"模拟其中无法打开照相机"];
    }
    
}

- (void)localPhoto
{
    //创建图片选择器
    self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//指定源的类型
    self.picker.allowsEditing = YES;//在选定图片之前，用户可以简单编辑要选的图片。包括上下移动改变图片的选取范围，用手捏合动作改变图片的大小等。
    //设置完iamgePicker后，就可以启动了。用以下方法将图像选取器的视图“推”出来
    [self presentViewController:self.picker animated:YES completion:nil];
    
}

#pragma mark 拍照or选择本地图片 选择后 进入本函数
-(void)imagePickerController:(UIImagePickerController*)ImgPicker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData   UIImagePickerControllerReferenceURL
        UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
        NSData *data;
        data = UIImageJPEGRepresentation(image, 0.6);//压缩比例 默认值为：1
        
        //图片保存的路径
        //关闭相册界面
        [ImgPicker dismissViewControllerAnimated:YES completion:nil];
        
        
        NSString *imageName = @"userHeadImg.png";
        [ImageUtil saveImage:image imageName:imageName isThumb:YES isScale:NO];
        
#pragma mark - 上传图片 返回图片的url
        [self showJuHua:@""];
        [AFN_MC postUploadImageWithFiles:@[imageName]
        resultBlock:^(BOOL success, NSDictionary *resultDic, NSString *errorMsg) {
            [self hideJuHua];
            if (success)
            {
                [self showMessage:@"请求成功"];
                NSArray *arrUploadImg = [NSArray arrayWithArray:(NSArray *)resultDic];
                //字典转模型fxw 总是容易忘记 其实mj的方法自己还可以再封装一层
                ModelUploadImg *model = [ModelUploadImg mj_objectWithKeyValues:[arrUploadImg firstObject]];
                NSLog(@"%@",model.fileFullUrl);
            }
            else
            {
                [self showError:errorMsg];
            }
        }];
    }
    
}

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
