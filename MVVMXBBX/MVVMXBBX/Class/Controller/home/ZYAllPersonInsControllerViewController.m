//
//  ZYAllPersonInsControllerViewController.m
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/7/13.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYAllPersonInsControllerViewController.h"
#import "ZYCategoryScrollView.h"
@interface ZYAllPersonInsControllerViewController ()

@end

@implementation ZYAllPersonInsControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ZYCategoryScrollViewItem *item1 = [[ZYCategoryScrollViewItem alloc]initWithTitle:@"myWallet" andViewName:@"ZYMyWalletController"];
    ZYCategoryScrollViewItem *item2 = [[ZYCategoryScrollViewItem alloc]initWithTitle:@"getMoney" andViewName:@"ZYGetMoneyController"];
    ZYCategoryScrollView *catView = [[ZYCategoryScrollView alloc]init];
    catView.frame = self.view.bounds;
    catView.items = [NSMutableArray arrayWithArray: @[item1,item2]];
    [self.view addSubview:catView];
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
