//
//  ViewController.m
//  展开列表
//
//  Created by 罗小友 on 2017/12/5.
//  Copyright © 2017年 csair.etms. All rights reserved.
//

#import "ViewController.h"
#import "LXYOpenListTableView.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    //添加tableView
   // [self addTableView];
    CGFloat x = 50;
    CGFloat y = 64;
    CGFloat w = self.view.frame.size.width - 2 * x;
    CGFloat h = self.view.frame.size.height - 2 * y;
    LXYOpenListTableView *tableView = [[LXYOpenListTableView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    [self.view addSubview:tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
