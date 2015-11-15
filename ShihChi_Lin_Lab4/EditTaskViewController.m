//
//  EditTaskViewController.m
//  ShihChi_Lin_Lab4
//
//  Created by Oslo on 11/10/15.
//  Copyright © 2015 Shih Chi Lin. All rights reserved.
//

#import "EditTaskViewController.h"

@interface EditTaskViewController () <PriorityProtocol, DueDateProtocol>

@property (weak, nonatomic) IBOutlet UITextField *taskName;
@property (weak, nonatomic) IBOutlet UIButton *priority;
@property (weak, nonatomic) IBOutlet UIButton *duedate;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@end

@implementation EditTaskViewController
@synthesize delegate;
@synthesize segmentControl;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} forState:UIControlStateSelected];
    if (self.currentTask == nil) {
        self.currentTask = [Task task];
    }
}

-(void)viewDidAppear:(BOOL)animated {
    if (self.currentTask.text.length != 0) {
        _taskName.text = self.currentTask.text;
    }
    
    if (self.currentTask.dueDate != nil) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM-dd-yyyy 'at' HH:mm"];
        NSString *stringFromDate = [formatter stringFromDate:self.currentTask.dueDate];
        //[formatter release];
        [_duedate setTitle:stringFromDate forState:UIControlStateNormal];
    } else {
        [_duedate setTitle:@"No Due Date" forState:UIControlStateNormal];
    }
    
    if (self.currentTask.completed == NO) {
        [segmentControl setSelectedSegmentIndex:0];
    } else {
        [segmentControl setSelectedSegmentIndex:1];
    }
    // set title of the button
    [self setPriorityButtonTitle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setPriorityButtonTitle {
    switch (self.currentTask.priority) {
        case low:
            [_priority setTitle:[self convertToString:self.currentTask.priority] forState:UIControlStateNormal];
            break;
        case medium:
            [_priority setTitle:[self convertToString:self.currentTask.priority] forState:UIControlStateNormal];
            break;
        case high:
            [_priority setTitle:[self convertToString:self.currentTask.priority] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}


- (IBAction)chooseComplete:(id)sender {
    if (segmentControl.selectedSegmentIndex == 0) {
        self.currentTask.completed = NO;
    } else {
        self.currentTask.completed = YES;
    }
}

-(NSString *)convertToString:(Priority)pr {
    NSString *result = nil;
    switch (pr) {
    case low:
        result = @"Low";
        break;
    case medium:
        result = @"Medium";
        break;
    case high:
        result = @"High";
        break;
    default:
        NSLog(@"Priority convertion Error");
        break;
    }
    return result;
}

// get the priority value from the Priority VC
-(void)getPriority:(Task *)receivedTask {
    self.currentTask.priority = receivedTask.priority;
    //NSLog(@"print priority 2");
    [_priority setTitle:[self convertToString:receivedTask.priority] forState:UIControlStateNormal];
}

// get due date from the DueDate VC
-(void)getDueDate:(Task *)receivedTask {
    self.currentTask.dueDate = receivedTask.dueDate;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM-dd-yyyy 'at' HH:mm"];
    NSString *stringFromDate = [formatter stringFromDate:self.currentTask.dueDate];
    //[formatter release];
    [_duedate setTitle:stringFromDate forState:UIControlStateNormal];
}

-(void)noDueDate:(Task *)receivedTask {
    self.currentTask = receivedTask;
    [_duedate setTitle:@"No Due Date" forState:UIControlStateNormal];
}

// save all the data belong to current data and pass it back to parent VC
- (IBAction)saveTaskData:(id)sender {
    // save the task data from the UI
    self.currentTask.text = self.taskName.text;
    [self.delegate taskInformation:self.currentTask];
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"priority"]) {
        // set the PriorityVC as destination VC then pass Task data to it
        PriorityViewController *taskPriority = [segue destinationViewController];
        taskPriority.currentTask = self.currentTask;
        // set itself as delegate for the next view controller to get the data back
        taskPriority.delegate = self;
    } else if ([segue.identifier isEqualToString:@"duedate"]) {
        DueDateViewController *taskDuedate = [segue destinationViewController];
        taskDuedate.currentTask = self.currentTask;
        // set itself as delegate for the next view controller to get the data back
        taskDuedate.delegate = self;
    }
}


@end
