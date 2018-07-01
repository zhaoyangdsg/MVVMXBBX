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
#import "NSNumber+ZY.h"
@interface ZYGetMoneyViewModel()
@property(nonatomic,strong)ZYGetMoneyItem *getMoneyItem;
@property(nonatomic,strong)RACSignal *inputSignal;
@end

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
                self.getMoneyItem = item;
                self.todayCount = [[NSString alloc]initWithFormat:@"%d", item.tixianDayNum ];
                self.monthCount = [[NSString alloc]initWithFormat:@"%d",item.tixianNum];
                self.allMoney = @(item.canUserScore/100).keep2String  ;// [[NSString alloc]initWithFormat:@"%f",item.canUserScore];
                self.monthGetMoneyCount = @(item.currentMonthTotalScore/100).keep2String; // [[NSString alloc] initWithFormat:@"%f",item.currentMonthTotalScore];
                [subscriber sendNext: nil];
                [subscriber sendCompleted];
            } failure:^(NSError *error) {
                [subscriber sendError:error];
            }];
            return  nil;
        }];
        return signal;
    }];
    
//    [RACObserve(self, endEdit) map:^id (NSNumber* x) {
//        NSLog(@"%d",x.boolValue);
//        return nil;
//    }];
    
    
//    _btnEnableSignal = [[[RACObserve(self, endEdit) filter:^BOOL(NSNumber *ended) {
//        return ended.boolValue;
//    }] map:^id (NSNumber *endEdit) {
//            NSNumberFormatter *numFormat = [[NSNumberFormatter alloc]init];
//            double inputMoney = [numFormat numberFromString:self.inputMoney].doubleValue;
//            // 如果 输入的值不是数字 或输入负数 或大于总金额 return false
//            if ( !inputMoney || self.getMoneyItem.tixianDayNum >= 3 ||  inputMoney <= 0 || inputMoney > self.allMoney.doubleValue  ) {
//                return false;
//            }else {
//                return @([self computeTax]);
//            }
//    }]distinctUntilChanged] ;
    
//    _btnEnableSignal = [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        NSNumberFormatter *numFormat = [[NSNumberFormatter alloc]init];
//        double inputMoney = [numFormat numberFromString:self.inputMoney].doubleValue;
//        // 如果 输入的值不是数字 或输入负数 或大于总金额 return false
//        if ( !inputMoney || self.getMoneyItem.tixianDayNum >= 3 ||  inputMoney <= 0 || inputMoney > self.allMoney.doubleValue  ) {
//            return false;
//        }else {
//            [self computeTax];
//        }
//        return nil;
//    }]distinctUntilChanged];
    
    self.btnEnableSignal = [[RACObserve(self, inputMoney) filter:^BOOL(NSString *value) {
        NSNumberFormatter *format = [[NSNumberFormatter alloc]init];
        NSNumber *num = [format numberFromString:value];
        if (num) {
            return YES;
        }
        return NO;
    }] map:^id (NSString *inputMoney) {
        // 如果 输入的值不是数字 或输入负数 或大于总金额 return false
        double inputMoney_d = inputMoney.doubleValue;
        if ( !inputMoney_d || self.getMoneyItem.tixianDayNum >= 3 ||  inputMoney <= 0 || inputMoney_d > self.allMoney.doubleValue  ) {
            return @NO;
        }else {
            return @([self computeTax]);
        }
    }] ;
    
}
/// 计算税
- (BOOL)computeTax {
    // 代扣税
    double taxMoney = 0;
    // 手续费
    double sxfMoney = 0;
    // 最后的金额
    double taxedMoney;
    // 输入的金额
    double orgMoney = self.inputMoney.doubleValue;
    
    // 提取金额大于800 多出金额20%扣税
    if (self.monthGetMoneyCount.doubleValue >= 800) {
        taxMoney = self.inputMoney.doubleValue * 0.2;
    }else if (orgMoney + self.monthGetMoneyCount.doubleValue > 800) {
        taxMoney = (orgMoney + self.monthGetMoneyCount.doubleValue - 800) * 0.2;
    }
    // 手续费
    if ( self.getMoneyItem.tixianNum >= 2) {
        if (self.inputMoney.doubleValue <= 1) {
//            XBBXAlertTool.showAlertWith(time: 1.5, info: "您的提现金额不足1元,不足以支付手续费")
            return NO;
        }else {
            sxfMoney = 1;
        }
    }
    // 扣完手续费和税的金额
    taxedMoney = orgMoney - taxMoney - sxfMoney;
    
    self.taxMoney = [NSString stringWithFormat:@"¥%.2f",taxMoney];
    self.serviceMoney = [NSString stringWithFormat:@"¥%.2f",sxfMoney];
    self.finalMoney = [NSString stringWithFormat:@"¥%.2f",taxedMoney];
    return YES;
}

@end
