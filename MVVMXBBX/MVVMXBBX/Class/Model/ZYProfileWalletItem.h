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
@property(nonatomic,assign)NSInteger txsum;
@property(nonatomic,assign)NSInteger userBankStatus;
@property(nonatomic,assign)NSInteger totalsum;
@property(nonatomic,assign)NSInteger jlmx;
@property(nonatomic,assign)NSInteger djsjl;
@property(nonatomic,assign)NSInteger success;
@property(nonatomic,assign)NSInteger jlmxh;
@property(nonatomic,assign)NSInteger userId;

@end
