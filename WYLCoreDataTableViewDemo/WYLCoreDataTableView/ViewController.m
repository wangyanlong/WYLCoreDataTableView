//
//  ViewController.m
//  WYLCoreDataTableView
//
//  Created by 王老师 on 15/9/18.
//  Copyright © 2015年 wyl. All rights reserved.
//
#import "AppDelegate.h"
#import "CollectionTableView.h"
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    CollectionTableView *ctv = [[CollectionTableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"comicID" ascending:YES];
    ctv.context = app.managedObjectContext;
    ctv.sortArray = @[sortDescriptor];
    ctv.entityName = @"Comic";
    [ctv createFetchTableViewInfomation];

    [self.view addSubview:ctv];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
