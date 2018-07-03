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
    
    RAC(self,commitBtn.enabled) = self.viewModel.btnEnableSignal;
    // 监听textField的输入 赋值给viewModel的inputMoney属性
    RAC(self.viewModel,inputMoney) = self.moneyTextField.rac_textSignal;
   
    RAC(self.viewModel,endEdit) = RACObserve(self.moneyTextField,editing) ;
    
    [[[self.viewModel.loadDataCommand execute:nil] deliverOnMainThread] subscribeCompleted:^{
        RAC(self,totalLabel.text) = RACObserve(self,viewModel.allMoney);
    }];
    RAC(self,taxLabel.text) = [RACObserve(self, viewModel.taxMoney)map:^id (NSString *value) {
        if (!value) {
            return @"¥0.00";
        }else {
            return value;
        }
    }] ;
    RAC(self,serviceLabel.text) = [RACObserve(self, viewModel.serviceMoney) map:^id (NSString *value) {
        if (!value) {
            return @"¥0.00";
        }else {
            return value;
        }
    }] ;
    RAC(self,finalLabel.text) = [RACObserve(self, viewModel.finalMoney) map:^id (NSString *value) {
        if (!value) {
            return @"¥0.00";
        }else {
            return value;
        }
    }] ;

    RAC(self,finalLabel2.text) = [RACObserve(self, viewModel.finalMoney) map:^id (NSString *value) {
        if (!value) {
            return @"¥0.00";
        }else {
            return value;
        }
    }] ;

    
//    [NSNotificationCenter defaultCenter]postNotificationName:<#(nonnull NSNotificationName)#> object:<#(nullable id)#>
    
}


@end
