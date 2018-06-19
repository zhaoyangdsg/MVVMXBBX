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
- (void)loadWalletDataWithSuccessHandler:(void (^)(id))success failureHandler:(void (^)(NSError *))failureHandler {
    [ZYProfileHttpTool.shareInstance loadMyWalletDataSuccessHandler:^(ZYProfileWalletItem *walletItem) {
        walletItem.totalsum;
    } failureHandler:^(NSError *error) {
        
    }];
}
@end
