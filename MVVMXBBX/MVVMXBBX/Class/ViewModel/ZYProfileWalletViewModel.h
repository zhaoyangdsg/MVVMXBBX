//
//  ZYProfileWalletViewModel.h
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/6/19.
//  Copyright © 2018年 me2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYProfileWalletViewModel : NSObject
@property(nonatomic,copy)NSString *allMoney;
@property(nonatomic,copy)NSString *cashMoney;
@property(nonatomic,copy)NSString *activityMoney;
@property(nonatomic,copy)NSString *preMoney;
@property(nonatomic,copy)NSString *cardStatus;
@property(nonatomic,strong)RACCommand *loadDataCommand;
//- (void)loadWalletDataWithSuccessHandler:(void(^) (id resp))success failureHandler:(void(^)(NSError *error))failureHandler;

@end
