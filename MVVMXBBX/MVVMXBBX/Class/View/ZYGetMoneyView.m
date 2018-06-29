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
    
    
    [self bindViewModel];
}

- (void)bindViewModel {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        RAC(self,taxLabel.text) = RACObserve(self,viewModel.taxMoney);
//        self.serviceLabel.text = RACObserve(self.viewModel, serviceMoney);
//        self.finalLabel.text = RACObserve(self,viewModel.finalMoney);
//        self.finalLabel2.text = RACObserve(self,viewModel.finalMoney);
    });
    RAC(self,commitBtn.enabled) = self.viewModel.btnEnableSignal;
    // 监听textField的输入 赋值给viewModel的inputMoney属性
    RAC(self.viewModel,inputMoney) = self.moneyTextField.rac_textSignal;
   
    [RACObserve(self.moneyTextField,editing) subscribeNext:^(id  _Nullable x) {
       
    }];
    
    [[[self.viewModel.loadDataCommand execute:nil] deliverOnMainThread] subscribeCompleted:^{
        RAC(self,totalLabel.text) = RACObserve(self,viewModel.allMoney);
    }];
    
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
    double orgMoney = self.moneyTextField.text.doubleValue;
    
    // 提取金额大于800 多出金额20%扣税
    if (self.viewModel.monthGetMoneyCount.doubleValue >= 800) {
        taxMoney = orgMoney * 0.2;
    }else if (orgMoney + self.viewModel.monthGetMoneyCount.doubleValue > 800) {
        taxMoney = (orgMoney + self.viewModel.monthGetMoneyCount.doubleValue - 800) * 0.2;
    }
    // 手续费
    if ( self.viewModel.monthGetMoneyCount.intValue >= 2) {
        if (orgMoney <= 1) {
            //            XBBXAlertTool.showAlertWith(time: 1.5, info: "您的提现金额不足1元,不足以支付手续费")
            return false;
        }else {
            sxfMoney = 1;
        }
    }
    // 扣完手续费和税的金额
    taxedMoney = orgMoney - taxMoney - sxfMoney;
    
    self.taxLabel.text = [NSString stringWithFormat:@"¥%f",taxMoney];
    self.serviceLabel.text = [NSString stringWithFormat:@"¥%f",sxfMoney];
    self.finalLabel2.text = [NSString stringWithFormat:@"¥%f",taxedMoney];
    self.finalLabel.text = [NSString stringWithFormat:@"¥%f",taxedMoney];
    return true;
}


@end
