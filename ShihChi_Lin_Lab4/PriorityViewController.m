//
//  PriorityViewController.m
//  ShihChi_Lin_Lab4
//
//  Created by Oslo on 11/10/15.
//  Copyright © 2015 Shih Chi Lin. All rights reserved.
//

#import "PriorityViewController.h"

@interface PriorityViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *priorityPicker;

@end

@implementation PriorityViewController
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _data = @[@"low", @"medium", @"high"];
    self.priorityPicker.delegate = self;
    self.priorityPicker.dataSource = self;
    [_priorityPicker reloadAllComponents];
    [_priorityPicker selectRow:0 inComponent:0 animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 3;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [_data objectAtIndex:row];
}

- (IBAction)pickPriority:(id)sender {
    // the done button simply set the priority value and dismiss current VC
    [self.delegate getPriority:self.currentTask];
    //NSLog(@"print priority");
    // dismiss VC
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (row == 0) {
        self.currentTask.priority = low;
    } else if (row == 1) {
        self.currentTask.priority = medium;
    } else {
        self.currentTask.priority = high;
    }
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
