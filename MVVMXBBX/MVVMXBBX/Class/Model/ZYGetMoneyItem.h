//
//  ZYGetMoneyItem.h
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/6/26.
//  Copyright © 2018年 me2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYGetMoneyItem : NSObject
/// 当日提现次数
//var tixianDayNum: NSNumber?
///// 可提现金额
//var canUserScore: NSNumber?
///// 用户
//var user: XBBXUserItem?
///// 历史提现金额
//var txScore: NSNumber?
///// 当月提现次数
//var tixianNum: NSNumber?
///// 当月提现金额
//var currentMonthTotalScore: NSNumber?
///// 银行卡状态
//var bankStauts: String?
@property(nonatomic,assign)int tixianDayNum;
@property(nonatomic,assign)double canUserScore;
@property(nonatomic,assign)double txScore;
@property(nonatomic,assign)int tixianNum;
@property(nonatomic,assign)double currentMonthTotalScore;
@property(nonatomic,copy)NSString *bankStauts;

@end
