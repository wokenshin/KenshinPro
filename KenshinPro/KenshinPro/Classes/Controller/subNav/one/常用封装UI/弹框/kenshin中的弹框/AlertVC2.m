//
//  AlertVC2.m
//  GYBase
//
//  Created by 刘万兵 on 17/1/4.
//  Copyright © 2017年 kenshin. All rights reserved.
//

#import "AlertVC2.h"
#import "Tools.h"
#import "LSActionSheet.h"

@interface AlertVC2 ()

@end

@implementation AlertVC2

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"from kenshinApp";
    [self toast:@"事件监听 看控制台输出"];
    
}

- (IBAction)actionOne:(id)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"标题"
                                                                             message:@"这个地方可以写一些内容"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"知道了"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action){
                                                             
                                                         }];
    
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (IBAction)actionTwo:(id)sender
{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"标题"
                                                                             message:@"取消风格的按钮只能有一个不然会崩溃"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action){
                                                             NSLog(@"取消");
                                                         }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action){
                                                             NSLog(@"确定");
                                                         }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)actionThree:(id)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"标题"
                                                                             message:@"确定风格的按钮可以有多个"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action){
                                                             NSLog(@"取消");
                                                         }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action){
                                                         NSLog(@"确定");
                                                     }];
    
    UIAlertAction *ok2Action = [UIAlertAction actionWithTitle:@"肯定"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action){
                                                         NSLog(@"肯定");
                                                     }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [alertController addAction:ok2Action];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (IBAction)actionFour:(id)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"标题"
                                                                             message:@"当超过两个按钮的时候就会一排显示1个按钮"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action){
                                                             NSLog(@"取消");
                                                         }];
    
    UIAlertAction *ok2Action = [UIAlertAction actionWithTitle:@"肯定"
                                                        style:UIAlertActionStyleDestructive
                                                      handler:^(UIAlertAction *action){
                                                          NSLog(@"肯定");
                                                      }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:ok2Action];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (IBAction)actionFive:(id)sender
{
    UIAlertController *view = [UIAlertController alertControllerWithTitle:@"标题"
                                                                   message:@"内容内容内容内容内容内容内容"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK"
                         
                                                 style:UIAlertActionStyleDefault
                         
                                               handler:^(UIAlertAction* action)
                         
    {
        NSLog(@"asd");
    }];
    
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel"
                             
                                                     style:UIAlertActionStyleDefault
                             
                                                   handler:^(UIAlertAction* action)
                             
    {
        NSLog(@"asasdd");
    }];
    
    [view addAction: ok];
    [view addAction: cancel];
    
    [self presentViewController: view animated: YES completion: nil];
    
    
}

- (IBAction)actionSix:(id)sender
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"My Title"
                                                                    message:@"添加文本框 只能用 UIAlertControllerStyleAlert"
                                                             preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"确定"
                                                 style: UIAlertActionStyleDefault
                                               handler:^(UIAlertAction* action) {
                                                   UITextField *text = [alert.textFields objectAtIndex:0];
                                                   UITextField *text2 = [alert.textFields objectAtIndex:1];
                                                   NSLog(@"%@  %@", text.text, text2.text);
                                               }];
    
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"取消"
                                                     style: UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction* action) {
//                                                       NSArray *a = alert.textFields;
                                                       UITextField *text = [alert.textFields objectAtIndex:0];
                                                       UITextField *text2 = [alert.textFields objectAtIndex:1];
                                                       NSLog(@"%@ %@", text.text, text2.text);
                                                   }];
    
    [alert addAction: ok];
    [alert addAction: cancel];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Username";
    }];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Password";
        textField.secureTextEntry = YES;
    }];
    
    [self presentViewController: alert animated: YES completion: nil];
    
}

- (IBAction)actionSeven:(id)sender
{
    [LSActionSheet showWithTitle:@"当群聊未保存到通讯录时，删除后将无法再通讯录中找到，确认删除？"
                destructiveTitle:@"删除"
                     otherTitles:nil
                           block:^(int index) {
                               NSLog(@"-----%d",index);
                           }];
    
}

- (IBAction)actionEight:(id)sender
{
    [LSActionSheet showWithTitle:@"当群聊未保存到通讯录时，删除后将无法再通讯录中找到，确认删除？"
                destructiveTitle:@"删除"
                     otherTitles:@[@"你爷爷", @"你奶奶", @"你外公", @"你外婆"]
                           block:^(int index) {
                               NSLog(@"-----%d",index);
                           }];
}


@end
