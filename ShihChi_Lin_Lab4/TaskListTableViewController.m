//
//  TaskListTableViewController.m
//  ShihChi_Lin_Lab4
//
//  Created by Oslo on 11/10/15.
//  Copyright © 2015 Shih Chi Lin. All rights reserved.
//

#import "TaskListTableViewController.h"

@interface TaskListTableViewController () <TaskProtocol>

@property Task *currentTask;
@property TaskList *taskList;
@property NSMutableArray *taskArray;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;

@end

@implementation TaskListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    // init an empty tasklist
    //_taskList = [[TaskList alloc] init];
    _taskArray = [[NSMutableArray alloc] init];
    // set the edit button to the editbutton item
    self.editButton = [self editButtonItem];
    self.navigationItem.rightBarButtonItem = self.editButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated {
    [self.tableView reloadData];
}

-(void)taskInformation:(Task *)receivedTask {
    self.currentTask = receivedTask;
    //NSLog(@"check 2");
    NSLog(@"task: %@, duedate: %@, completed: %d", self.currentTask.text, self.currentTask.dueDate, self.currentTask.completed);
}

-(void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    self.editButton.title = @"Done";
}

-(void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    self.editButton.title = @"Edit";
}

// have to get the task that you really want to edit
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //////$$$#$#$#$#$#$#$##$ not sure how to get the corresponded task
    [self.tableView reloadData];
    self.currentTask = _taskArray[indexPath.row];
//    [self.tableView reloadData];
//    NSIndexPath *selectedPath = [self.tableView indexPathForSelectedRow];
//    [self.tableView reloadData];
//    self.currentTask = _taskArray[selectedPath.row];
    //NSLog(@"second current task: %@", self.currentTask.text);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return self.taskArray.count;
    // return self.taskList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"task" forIndexPath:indexPath];
    // Configure the cell...
    //_taskArray = [self.taskList allTasks];
    // get current date/time
    NSDate *today = [NSDate date];
    Task *display = _taskArray[indexPath.row];
    // if it is in ascending order means that task due date is before the currentDate
    // we are considering the currentDate as endDate for comparison
    if([display.dueDate compare:today] == NSOrderedAscending){
        cell.textLabel.textColor = [UIColor redColor];
        cell.detailTextLabel.textColor = [UIColor redColor];
    }
    if (display.completed == YES) {
        cell.textLabel.textColor = [UIColor grayColor];
        cell.detailTextLabel.textColor = [UIColor grayColor];
    }
    cell.textLabel.text = display.text;
    NSString *concatenate = [NSString stringWithFormat:@"Due %@", display.dueDate];
    cell.detailTextLabel.text = concatenate;
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.taskArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"editTask"]) {
        NSLog(@"test log: edit task");
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        [self.tableView reloadData];
        self.currentTask = _taskArray[indexPath.row];
        
        EditTaskViewController *taskVC = [segue destinationViewController];
        taskVC.currentTask = self.currentTask;
        NSLog(@"first current task: %@", self.currentTask.text);
        taskVC.delegate = self;
    } else if ([segue.identifier isEqualToString:@"addTask"]) {
        // create empty task
        //_currentTask = [[Task alloc] initWithText:nil dueDate:nil priority:low completed:nil];
        NSLog(@"test log: add task");
//        if (!self.taskList) {
//            self.taskList = [TaskList taskList];
//        }
        Task *newTask = [[Task alloc] init];
        // add new task to the task list(on the top of it, like stack)
        //[_taskList addTask:_currentTask];
        [_taskArray insertObject:newTask atIndex:0];
        // get the index that you are inserting it in the tableview
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        EditTaskViewController *taskVC = [segue destinationViewController];
        //taskVC.taskList = self.taskList;
        // add it into the taskList
        [self.tableView reloadData];
        taskVC.currentTask = newTask;
        taskVC.delegate = self;
    }
}


@end
