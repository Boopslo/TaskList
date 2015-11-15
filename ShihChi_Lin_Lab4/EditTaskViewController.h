//
//  EditTaskViewController.h
//  ShihChi_Lin_Lab4
//
//  Created by Oslo on 11/10/15.
//  Copyright © 2015 Shih Chi Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "TaskList.h"
#import "PriorityViewController.h"
#import "DueDateViewController.h"

@protocol TaskProtocol <NSObject>

-(void) taskInformation:(Task *)receivedTask;

@end


@interface EditTaskViewController : UIViewController <UITextFieldDelegate>

@property Task *currentTask;
@property (weak, nonatomic) id<TaskProtocol> delegate;

@end
