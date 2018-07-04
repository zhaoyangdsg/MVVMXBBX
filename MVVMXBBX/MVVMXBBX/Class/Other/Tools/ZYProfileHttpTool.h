//
//  ZYProfileHttpTool.h
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/6/1.
//  Copyright © 2018年 me2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYBaseHttpTool.h"
#import "ZYSharedable.h"
@class ZYGetMoneyItem;
@class ZYProfileWalletItem;
typedef void(^handlerBlock)(id);
@interface ZYProfileHttpTool :ZYBaseHttpTool
- (void)loginWithUser:(NSString *)user password:(NSString *)password successHandler:(handlerBlock)successHandler  failureHandler:(handlerBlock)failureHandler;
- (void)loadMyWalletDataSuccessHandler:(void(^)(ZYProfileWalletItem *walletItem))success failureHandler:(void(^)(NSError *error))failure;
- (void)loadGetMoneyDataSuccess:(void(^)(ZYGetMoneyItem *item))success failure:(void(^)(NSError *error))failure;
@end
