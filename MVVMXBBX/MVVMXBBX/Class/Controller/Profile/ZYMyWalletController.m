//
//  ZYMyWalletController.m
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/6/14.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYMyWalletController.h"
#import "ZYProfileHttpTool.h"
@interface ZYMyWalletController ()

@end

@implementation ZYMyWalletController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    [self loadData];
}

- (void)loadData {
    [ZYProfileHttpTool.shareInstance loadMyWalletDataSuccessHandler:^(ZYProfileWalletItem *walletItem) {
        if (walletItem) {
            
        }
    } failureHandler:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
