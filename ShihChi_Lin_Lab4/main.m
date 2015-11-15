//
//  main.m
//  ShihChi_Lin_Lab4
//
//  Created by Oslo on 11/10/15.
//  Copyright © 2015 Shih Chi Lin. All rights reserved.
//
/*
    name: Shih Chi Lin
    tuid: 915261410
    class: CIS4350 section 002
    Lab 4
    purpose: this lab requires to create UI for Lab 2: Task and TaskList
             this app displays tasks in TableView and users are able to edit each task by tapping any
             cell, it will show another view controller then edit window show up, with task name, priority, 
             complete status, and due date
             also there should be implementation for deleting tasks from the table view
*/
#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
