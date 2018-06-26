//
//  ZYGetMoneyViewModel.h
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/6/25.
//  Copyright © 2018年 me2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYGetMoneyViewModel : NSObject
@property(nonatomic,copy)NSString *allMoney;
@property(nonatomic,copy)NSString *taxMoney;
@property(nonatomic,copy)NSString *serviceMoney;
@property(nonatomic,copy)NSString *finalMoney;
/// 输入的金额
@property(nonatomic,copy)NSString *inputMoney;
/// 当日提现次数
@property(nonatomic,copy)NSString *todayCount;
/// 当月提现次数
@property(nonatomic,copy)NSString *monthCount;
/// 当月提现金额
@property(nonatomic,copy)NSString *monthGetMoneyCount;
/// 加载初始数据command
@property(nonatomic,strong)RACCommand *loadDataCommand;
/// 提交请求command
@property(nonatomic,strong)RACCommand *commitCommand;
/// 按钮是否可按signal
@property(nonatomic,strong)RACSignal *btnEnableSignal;
@end
