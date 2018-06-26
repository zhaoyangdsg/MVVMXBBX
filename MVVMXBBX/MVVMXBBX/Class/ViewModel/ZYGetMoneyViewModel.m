//
//  ZYGetMoneyViewModel.m
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/6/25.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYGetMoneyViewModel.h"
#import "ZYProfileHttpTool.h"
#import "ZYGetMoneyItem.h"
@implementation ZYGetMoneyViewModel
- (instancetype)init {
    if (self = [super init]) {
        [self initialBind];
    }
    return self;
}

- (void)initialBind {
    _loadDataCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [ZYProfileHttpTool.shareInstance loadGetMoneyDataSuccess:^(ZYGetMoneyItem *item) {
                self.todayCount = [[NSString alloc]initWithFormat:@"%f", item.tixianDayNum ];
                self.monthCount = [[NSString alloc]initWithFormat:@"%f",item.tixianNum];
                self.allMoney = [[NSString alloc]initWithFormat:@"%f",item.canUserScore];
                self.monthGetMoneyCount = [[NSString alloc] initWithFormat:@"%f",item.currentMonthTotalScore];
                [subscriber sendNext: nil];
                [subscriber sendCompleted];
            } failure:^(NSError *error) {
                [subscriber sendError:error];
            }];
            return  nil;
        }];
        return signal;
    }];
    
    
}
@end
