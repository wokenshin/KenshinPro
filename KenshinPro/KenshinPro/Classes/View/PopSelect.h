//
//  OrdersDropdownSelection.h
//  CooperChimney
//
//  Created by Karthik Baskaran on 29/09/16.
//  Copyright © 2016 Karthik Baskaran. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

#define AvenirMedium(_size)   [UIFont fontWithName:@"Avenir-Medium" size:_size]

#define RGB(_red,_green,_blue)  [UIColor colorWithRed:_red/255.0 green:_green/255.0 blue:_blue/255.0 alpha:1]

#define NormalAnimation(_inView,_duration,_option,_frames)            [UIView transitionWithView:_inView duration:_duration options:_option animations:^{ _frames    }

@class PopSelect;

typedef void (^IntBlock)(int tag);

@interface PopSelect : UIControl<UITableViewDataSource,UITableViewDelegate>
{
    
    IntBlock completionBlock;
    UITableView *DropdownTable;
    NSString *Title;
    
}

-(void)alertTableview:(NSArray *)Contentarray title:(NSString *)title resultBlock:(IntBlock )block;

@end
