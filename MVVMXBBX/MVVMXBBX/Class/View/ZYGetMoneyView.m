//
//  ZYGetMoneyView.m
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/6/25.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYGetMoneyView.h"
#import "ZYGetMoneyViewModel.h"
@interface ZYGetMoneyView()

@end

@implementation ZYGetMoneyView
- (void)awakeFromNib {
    [super awakeFromNib];
    ZYGetMoneyViewModel *viewModel = [[ZYGetMoneyViewModel alloc]init];
    self.viewModel = viewModel;
}


@end
