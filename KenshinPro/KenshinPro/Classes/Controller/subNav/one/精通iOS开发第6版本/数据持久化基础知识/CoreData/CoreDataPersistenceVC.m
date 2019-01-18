//
//  CoreDataPersistenceVC.m
//  KenshinPro
//
//  Created by apple on 2019/1/9.
//  Copyright © 2019 Kenshin. All rights reserved.
//

#import "CoreDataPersistenceVC.h"
#import "AppDelegate.h"
#import <CoreData/NSPersistentStoreRequest.h>
#import <CoreData/NSManagedObject.h>
#import <CoreData/NSManagedObjectID.h>
#import <CoreData/NSFetchRequest.h>
#import <CoreData/NSManagedObjectContext.h>
#import <CoreData/NSEntityDescription.h>

static NSString * const kLineEntityName = @"Line";
static NSString * const kLineNumberKey  = @"lineNumber";
static NSString * const kLineTextKey    = @"lineText";
@interface CoreDataPersistenceVC ()

@property (nonatomic, strong) IBOutletCollection(UITextField)  NSArray   *lineFields;

@end

@implementation CoreDataPersistenceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *appDelegate = nil;//[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = nil;//[appDelegate manageobjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:kLineEntityName];
    NSError *errors;
    
    NSArray *objects = [context executeFetchRequest:request error:&errors];
    if (objects == nil) {
        NSLog(@"There was an error!");
        //做一些适当的错误处理
    }
    
    for (NSManagedObject *oneObjec in objects) {
        int lineNumber = [[oneObjec valueForKey:kLineNumberKey] intValue];
        NSString *lineText = [oneObjec valueForKey:kLineTextKey];
        
        UITextField *theField = self.lineFields[lineNumber];
        theField.text = lineText;
    }
    
    //接收通知
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification
                                               object:app];
    
}

- (void)applicationWillResignActive:(NSNotification *)notify{
    
    AppDelegate *appDelegate = nil;
    NSManagedObjectContext *context = nil;
    NSError *error;
    for (int i = 0 ; i < 4; i++) {
        UITextField *theField = self.lineFields[i];
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:kLineEntityName];
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"%K = %d", kLineNumberKey, i];
        [request setPredicate:pred];
        
        NSArray *objects = [context executeFetchRequest:request error:&error];
        if (objects == nil) {
            NSLog(@"There was an error!");
            //做一些适当的错误处理
        }
        
        NSManagedObject *theLine = nil;
        if ([objects count] > 0) {
            theLine = [NSEntityDescription insertNewObjectForEntityForName:kLineEntityName inManagedObjectContext:context];
        }
        [theLine  setValue:[NSNumber numberWithInt:i] forKey:kLineNumberKey];
        [theLine setValue:theField.text forKey:kLineTextKey];
    }
    
    [appDelegate saveContext];
    
    
}

@end
