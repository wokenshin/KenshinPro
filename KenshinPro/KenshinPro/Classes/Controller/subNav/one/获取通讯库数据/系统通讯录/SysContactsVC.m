//
//  SysContactsVC.m
//  KenshinPro
//
//  Created by kenshin on 17/3/16.
//  Copyright © 2017年 Kenshin. All rights reserved.
/*
 
    已封装到BaseVC 一行代码解决。 运用到了 ddzm 分享mKey的地方
 
 */

#import "SysContactsVC.h"

#import <AddressBookUI/ABPeoplePickerNavigationController.h>
#import <AddressBook/ABPerson.h>
#import <AddressBookUI/ABPersonViewController.h>

@interface SysContactsVC ()<ABPersonViewControllerDelegate, ABPeoplePickerNavigationControllerDelegate>

//@property (nonatomic, strong)UITableView                    *tableview;


@property (weak, nonatomic) IBOutlet UITextField *textPhoneNo;

@end


@implementation SysContactsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"系统通讯录";
    
}

- (IBAction)clickBtnAction:(id)sender
{
    [self initContacts];
    
}


//然后初始化ABPeoplePickerNavigationController
- (void)initContacts
{
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
    self.textPhoneNo.text = phoneNO;
    if (phone && [RegexUtil isValidTelePhone:phoneNO])
    {
//        [self.tableview reloadData];
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

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
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
    self.textPhoneNo.text = phoneNO;
    if (phone && [RegexUtil isValidTelePhone:phoneNO])
    {
//        [self.tableview reloadData];
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

- (void)dealloc
{
    [Tools NSLogClassDestroy:self];
    
}

@end
