//
//  DueDateViewController.h
//  ShihChi_Lin_Lab4
//
//  Created by Oslo on 11/10/15.
//  Copyright © 2015 Shih Chi Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskListTableViewController.h"
#import "EditTaskViewController.h"
#import "Task.h"

@protocol DueDateProtocol <NSObject>

-(void) getDueDate:(Task *)receivedTask;
-(void) noDueDate:(Task *)receivedTask;

@end

@interface DueDateViewController : UIViewController

@property Task *currentTask;
@property (weak, nonatomic) id<DueDateProtocol> delegate;

@end
