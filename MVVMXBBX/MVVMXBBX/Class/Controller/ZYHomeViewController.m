//
//  ZYHomeViewController.m
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/6/13.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYHomeViewController.h"

@interface ZYHomeViewController ()
@property(nonatomic,weak)UITableView *tableView;
@end

@implementation ZYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)setupSubview {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *view = [[UITableView alloc]init];
        _tableView = view;
    }
    return _tableView;
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
