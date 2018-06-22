//
//  ZYMyWalletController.m
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/6/14.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYMyWalletController.h"
#import "ZYProfileHttpTool.h"
#import "ZYProfileWalletView.h"
#import "UIView+ZY.h"
#import "ZYProfileWalletViewModel.h"
@interface ZYMyWalletController ()<UITableViewDelegate,UITableViewDataSource>
@property(weak,nonatomic)UITableView *tableView;
@property(weak,nonatomic)ZYProfileWalletView *walletView;
@property(strong,nonatomic)ZYProfileWalletViewModel *viewModel;
@end

@implementation ZYMyWalletController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
//    [self loadData];
    [self setupSubview];
}

- (void)setupSubview {
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    // 设置headerview xib 先添加空view
    UIView *headBlkView = [[UIView alloc]init];
    headBlkView.height = 100;
    [headBlkView addSubview:self.walletView];
    [self.walletView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(headBlkView);
    }];
    
    self.tableView.tableHeaderView = headBlkView;
    
}

- (void)bindViewModel {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// MARK: - lazy
- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc]init];
        _tableView = tableView;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        return _tableView;
    }
    return _tableView;
}

- (ZYProfileWalletView *)walletView {
    if (!_walletView) {
        ZYProfileWalletView *view = [NSBundle.mainBundle loadNibNamed:@"ZYProfileWalletView" owner:self options:nil].firstObject;
        _walletView = view;
        return _walletView;
    }
    return _walletView;
}

- (ZYProfileWalletViewModel *)viewModel {
    if (!_viewModel) {
        ZYProfileWalletViewModel *viewModel = [[ZYProfileWalletViewModel alloc]init];
        _viewModel = viewModel;
        return _viewModel;
    }
    return _viewModel;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell1"];
    cell.textLabel.text = @"xxx";
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


@end
