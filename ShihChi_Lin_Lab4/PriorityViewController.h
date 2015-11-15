//
//  PriorityViewController.h
//  ShihChi_Lin_Lab4
//
//  Created by Oslo on 11/10/15.
//  Copyright © 2015 Shih Chi Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditTaskViewController.h"
#import "TaskListTableViewController.h"
#import "Task.h"

@protocol PriorityProtocol <NSObject>

-(void) getPriority:(Task *)receivedTask;

@end

@interface PriorityViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property Task *currentTask;
@property NSArray *data;
@property (weak, nonatomic) id<PriorityProtocol> delegate;

@end
