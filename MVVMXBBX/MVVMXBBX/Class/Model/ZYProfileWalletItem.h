//
//  ZYProfileWalletItem.h
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/6/14.
//  Copyright © 2018年 me2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYProfileWalletItem : NSObject
/// 提现
//var txsum: NSNumber?
///// 银行卡状态
//var userBankStatus: NSNumber?
//var totalsum: NSNumber?
//
//var jlmx: NSNumber?
///// 待结算
//var djsjl: NSNumber?
//var success: NSNumber?
///// 不可提现
//var jlmxh: NSNumber?
//var userId: NSNumber?
/// 提现
@property(nonatomic,strong)NSNumber *txsum;
/// 银行卡状态
@property(nonatomic,strong)NSNumber *userBankStatus;
@property(nonatomic,strong)NSNumber *totalsum;
@property(nonatomic,strong)NSNumber *jlmx;
/// 待结算
@property(nonatomic,strong)NSNumber *djsjl;
@property(nonatomic,strong)NSNumber *success;
/// 不可提现
@property(nonatomic,strong)NSNumber *jlmxh;
@property(nonatomic,strong)NSNumber *userId;

@end
