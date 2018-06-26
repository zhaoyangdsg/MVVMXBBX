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
@property(nonatomic,strong)ZYGetMoneyViewModel *viewModel;
@end

@implementation ZYGetMoneyView

- (instancetype)initWithViewModel:(nullable ZYGetMoneyViewModel *)viewModel {
    self = [super init];
    if (viewModel) {
        self.viewModel = viewModel;
    }else {
        ZYGetMoneyViewModel *viewModel = [[ZYGetMoneyViewModel alloc]init];
        self.viewModel = viewModel;
    }
    return self;
}
@end
