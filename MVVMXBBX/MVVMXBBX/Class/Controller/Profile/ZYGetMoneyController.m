//
//  ZYGetMoneyController.m
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/6/25.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYGetMoneyController.h"
#import "ZYGetMoneyView.h"
@interface ZYGetMoneyController ()
@end
@implementation ZYGetMoneyController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubview];
}

- (void)setupSubview {
    ZYGetMoneyView *view = [[NSBundle mainBundle]loadNibNamed:@"ZYGetMoneyView" owner:self options:nil].firstObject;
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
