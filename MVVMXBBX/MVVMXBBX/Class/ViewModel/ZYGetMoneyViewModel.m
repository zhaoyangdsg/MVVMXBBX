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
@interface ZYGetMoneyViewModel()
@property(nonatomic,strong)ZYGetMoneyItem *getMoneyItem;
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
    
    _btnEnableSignal = [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSNumberFormatter *numFormat = [[NSNumberFormatter alloc]init];
        double inputMoney = [numFormat numberFromString:self.inputMoney].doubleValue;
        // 如果 输入的值不是数字 或输入负数 或大于总金额 return false
        if ( !inputMoney || self.getMoneyItem.tixianDayNum >= 3 ||  inputMoney <= 0 || inputMoney > self.allMoney.doubleValue  ) {
            return false;
        }else {
//            if ([self computeTax]) {
////                [subscriber sendNext: @YES];
//                return true;
//            }else {
////                [subscriber sendNext: @NO];
//                return false;
//            }
            [self computeTax];
        }
        
        return nil;
    }]distinctUntilChanged];
}
/// 计算税
- (BOOL)computeTax {
    // 代扣税
    double taxMoney = 0;
//    var taxMoney: Double = 0
    // 手续费
    double sxfMoney = 0;
//    var sxfMoney: Double = 0
    // 最后的金额
    double taxedMoney;
//    var taxedMoney:Double
    
    // 输入的金额
    double orgMoney = self.inputMoney.doubleValue;
    
    // 提取金额大于800 多出金额20%扣税
    if (self.getMoneyItem.currentMonthTotalScore >= 800) {
        taxMoney = self.inputMoney.doubleValue * 0.2;
    }else if (self.inputMoney.doubleValue + self.getMoneyItem.currentMonthTotalScore > 800) {
        taxMoney = (self.inputMoney.doubleValue + self.getMoneyItem.currentMonthTotalScore - 800) * 0.2;
    }
    // 手续费
    if ( self.getMoneyItem.tixianNum >= 2){
        if (self.inputMoney.doubleValue <= 1)
        {
//            XBBXAlertTool.showAlertWith(time: 1.5, info: "您的提现金额不足1元,不足以支付手续费")
            return false;
        }else {
            sxfMoney = 1;
        }
    }
    // 扣完手续费和税的金额
    taxedMoney = orgMoney - taxMoney - sxfMoney;
    
    self.taxMoney = [NSString stringWithFormat:@"¥%f",taxMoney];
    self.serviceMoney = [NSString stringWithFormat:@"¥%f",sxfMoney];
    self.finalMoney = [NSString stringWithFormat:@"¥%f",taxedMoney];
    return true;
}

@end
