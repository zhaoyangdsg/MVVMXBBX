//
//  ZYProductItem.h
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/7/12.
//  Copyright © 2018年 me2. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZYProductItem : NSObject
@property (nonatomic,strong)NSString *pdtId;
@property (nonatomic,strong)NSString *insureId;
@property (nonatomic,copy)NSString *dueTime;
@property (nonatomic,copy)NSString *condiContent;
@property (nonatomic,copy)NSString *clogo;
@property (nonatomic,copy)NSString *plogo;
@property (nonatomic,copy)NSString *suit;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *ageType;
@property (nonatomic,copy)NSString *moeny;
@property (nonatomic,copy)NSString *sellNum;
@property (nonatomic,copy)NSString *minAge;
@property (nonatomic,copy)NSString *minAgeType;
@property (nonatomic,copy)NSString *maxAgeType;
@property (nonatomic,copy)NSString *tiMoney;
@property (nonatomic,strong)NSArray *ensureShowList;
//var id: NSNumber?
//var insureId: NSNumber?
///// 产品名称
//var name: String?
///// 保险期限
//var dueTime: String?
///// 保险期限
//var condiContent: String?
///// logo
//var clogo: String?
///// 年龄类型
//var ageType: NSNumber?
///// plogo
//var plogo: String?
///// 适用人群
//var suit: String?
///// 价格
//var moeny: NSNumber?
///// 销量
//var sellNum: NSNumber?
///// 最小年龄
//var minAge: NSNumber?
///// 最大年龄
//var maxAge: NSNumber?
///// 年龄类型 0 1 2 年 月 日
//var minAgeType: NSNumber?
//var maxAgeType: NSNumber?
///// 保险项目
//var ensureShowList: [ensure]?
///// 推广费
//var tiMoney: NSNumber?
@end

@interface ZYProductEnsureItem: NSObject
@property (nonatomic,copy)NSString *detail;
@property (nonatomic,copy)NSString *money;
@property (nonatomic,copy)NSString *type;
@property (nonatomic,copy)NSString *name;
@end
