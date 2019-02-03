//
//  CameraVC.m
//  KenshinPro
//
//  Created by apple on 2019/2/2.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "CameraVC.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/UTCoreTypes.h>

@interface CameraVC ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView        *imageView;
@property (weak, nonatomic) IBOutlet UIButton           *takePickerBtn;

@property (nonatomic, strong) MPMoviePlayerController   *moviePlayerCtrl;
@property (nonatomic, strong) UIImage                   *image;
@property (nonatomic, strong) NSURL                     *movieURL;
@property (nonatomic, assign) NSString                  *lastChosenMediaType;
@end

@implementation CameraVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"摄像头和照片库";
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        _takePickerBtn.hidden = YES;
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self updateDisplay];
}

- (IBAction)shootPickerOrVideo:(id)sender {
    [self pickMediaFromSource:UIImagePickerControllerSourceTypeCamera];
}

- (IBAction)selectExistingPickerOrVedio:(id)sender {
    [self pickMediaFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)updateDisplay{
    if ([_lastChosenMediaType isEqual:(NSString*)kUTTypeImage]) {
        _imageView.image = _image;
        _imageView.hidden = NO;
        _moviePlayerCtrl.view.hidden = YES;
    } else if([_lastChosenMediaType isEqual:(NSString *)kUTTypeMovie]){
        [_moviePlayerCtrl.view removeFromSuperview];
        _moviePlayerCtrl = [[MPMoviePlayerController alloc] initWithContentURL:_movieURL];
        [_moviePlayerCtrl play];
        
        UIView *movieView = _moviePlayerCtrl.view;
        movieView.frame = _imageView.frame;
        movieView.clipsToBounds = YES;
        [self.view addSubview:movieView];
        _imageView.hidden = YES;
    }
    
}

- (void)pickMediaFromSource:(UIImagePickerControllerSourceType)sourceType{
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
    if ([UIImagePickerController isSourceTypeAvailable:sourceType] &&
        [mediaTypes count] > 0) {
        NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.mediaTypes = mediaTypes;
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:NULL];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error accessing media"
                                                        message:@"Unsupported media source"
                                                       delegate:nil
                                              cancelButtonTitle:@"卧槽!"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (UIImage *)shrinkImage:(UIImage *)original toSize:(CGSize)size{
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    CGFloat originalAspect = original.size.width/original.size.height;
    CGFloat targetAspect   = size.width/size.height;
    CGRect targetRect;
    
    if (originalAspect > targetAspect) {
        targetRect.size.width  = size.width;
        targetRect.size.height = size.height * targetAspect / originalAspect;
        targetRect.origin.x    = 0;
        targetRect.origin.y    = (size.height - targetRect.size.height) * 0.5;
    } else if(originalAspect < targetAspect){
        targetRect.size.width  = size.width * originalAspect / targetAspect;
        targetRect.size.height = size.height;
        targetRect.origin.x    = (size.width - targetRect.size.width) * 0.5;
        targetRect.origin.y    = 0;
    } else {
        targetRect = CGRectMake(0, 0, size.width, size.height);
    }
    [original drawInRect:targetRect];
    UIImage *final = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return final;
}

#pragma mark - Image Picker Controller delegate methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    _lastChosenMediaType = info[UIImagePickerControllerMediaType];
    if ([_lastChosenMediaType isEqual:(NSString *)kUTTypeImage]) {
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        _image = [self shrinkImage:chosenImage toSize:_imageView.bounds.size];
    } else if([_lastChosenMediaType isEqual:(NSString *)kUTTypeMovie]){
        _movieURL = info[UIImagePickerControllerMediaURL];
    }
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

@end
