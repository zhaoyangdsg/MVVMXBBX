//
//  ZYGetMoneyController.m
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/6/25.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYGetMoneyController.h"
#import "ZYGetMoneyView.h"
#import "ZYGetMoneyViewModel.h"
@interface ZYGetMoneyController ()
@property(weak,nonatomic)ZYGetMoneyView *getMoneyView;
@property(weak,nonatomic)ZYGetMoneyViewModel *viewModel;
@end
@implementation ZYGetMoneyController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubview];
    [self bindViewModel];
}
- (void)setupSubview {
    self.view.backgroundColor = UIColor.whiteColor;
    self.getMoneyView = [[NSBundle mainBundle]loadNibNamed:@"ZYGetMoneyView" owner:self options:nil].firstObject;
    [self.view addSubview:self.getMoneyView];
    [self.getMoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(80);
        make.bottom.equalTo(self.view).offset(-60);
//        make.edges.equalTo(self.view);
    }];
    
}

- (void)bindViewModel {
    self.viewModel = self.getMoneyView.viewModel;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
