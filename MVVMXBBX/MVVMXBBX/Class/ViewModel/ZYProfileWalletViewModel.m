//
//  ZYProfileWalletViewModel.m
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/6/19.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYProfileWalletViewModel.h"
#import "ZYProfileHttpTool.h"
#import "ZYProfileWalletItem.h"

@implementation ZYProfileWalletViewModel

- (instancetype)init {
    if (self = [super init]) {
        [self initialBind];
    }
    return self;
}

// 初始化绑定
- (void)initialBind {
    _loadDataCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *loadDataSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [ZYProfileHttpTool.shareInstance loadMyWalletDataSuccessHandler:^(ZYProfileWalletItem *walletItem) {
                self.allMoney =  [@"¥" stringByAppendingString: [walletItem.totalsum stringValue]];
                self.cashMoney = [@"¥" stringByAppendingString: [walletItem.jlmx stringValue]];
                self.activityMoney =  [@"¥" stringByAppendingString:  [walletItem.jlmxh stringValue]];
                self.preMoney = [@"¥" stringByAppendingString:  [walletItem.djsjl stringValue]];
                switch (walletItem.userBankStatus.intValue) {
                    case -1:
                        self.cardStatus = @"未设置";
                    case 0:
                        self.cardStatus = @"审核中";
                    case 1:
                        self.cardStatus = @"审核成功";
                    case 2:
                        self.cardStatus = @"审核失败";
                    default :
                        self.cardStatus = @"未设置";
                }
                [subscriber sendNext:nil]; 
                [subscriber sendCompleted];
            } failureHandler:^(NSError *error) {
                [subscriber sendError:error];
            }];

            return nil;
        }];
        
        return loadDataSignal;
    }];
}

- (void)loadWalletDataWithSuccessHandler:(void (^)(id))success failureHandler:(void (^)(NSError *))failureHandler {
    [ZYProfileHttpTool.shareInstance loadMyWalletDataSuccessHandler:^(ZYProfileWalletItem *walletItem) {
        walletItem.totalsum;
    } failureHandler:^(NSError *error) {
        
    }];
}
@end
