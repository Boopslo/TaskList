//
//  DueDateViewController.m
//  ShihChi_Lin_Lab4
//
//  Created by Oslo on 11/10/15.
//  Copyright © 2015 Shih Chi Lin. All rights reserved.
//

#import "DueDateViewController.h"

@interface DueDateViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation DueDateViewController
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// pop out VC without setting due date
- (IBAction)noDue:(id)sender {
    self.currentTask.dueDate = nil;
    [self.delegate noDueDate:self.currentTask];
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

// set the due date and return it back to parent VC
- (IBAction)setupDueDate:(id)sender {
    self.currentTask.dueDate = [_datePicker date];
    [self.delegate getDueDate:self.currentTask];
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
