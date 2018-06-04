//
//  ZYUserItem.h
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/6/4.
//  Copyright © 2018年 me2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYUserItem : NSObject
@property(nonatomic,copy)NSString* bankId;
@property(nonatomic,copy)NSString* bankIdNum;
@property(nonatomic,copy)NSString* bankName;
@property(nonatomic,copy)NSString* bankPic;
@property(nonatomic,assign)NSInteger bankStatus;
@property(nonatomic,copy)NSString* bankUserName;
@property(nonatomic,copy)NSString* birthday;
@property(nonatomic,copy)NSString* cityId;
@property(nonatomic,copy)NSString* cityName;
@property(nonatomic,copy)NSString* companyId;
@property(nonatomic,copy)NSString* createDate;
@property(nonatomic,copy)NSString* detail;
@property(nonatomic,copy)NSString* email;
@property(nonatomic,copy)NSString* entryTime;
@property(nonatomic,copy)NSString* userId;
@property(nonatomic,copy)NSString* ihomeUrl;
@property(nonatomic,copy)NSString* inviteNum;
@property(nonatomic,copy)NSString* isAutoExam;
@property(nonatomic,copy)NSString* isPhoneStatus;
@property(nonatomic,copy)NSString* ititle;
@property(nonatomic,copy)NSString* lastAddr;
@property(nonatomic,copy)NSString* lastTime;
@property(nonatomic,copy)NSString* lastUpdate;
@property(nonatomic,copy)NSString* licenseId;
@property(nonatomic,copy)NSString* licensePic;
@property(nonatomic,copy)NSString* mobile;
@property(nonatomic,copy)NSString* nick;
@property(nonatomic,copy)NSString* password;
@property(nonatomic,copy)NSString* provinceId;
@property(nonatomic,copy)NSString* provinceName;
@property(nonatomic,copy)NSString* qq;
@property(nonatomic,copy)NSString* qrCodePath;
@property(nonatomic,copy)NSString* regMailStatus;

@property(nonatomic,copy)NSString* regSource;

@property(nonatomic,copy)NSString* regTime;

@property(nonatomic,copy)NSString* result;

@property(nonatomic,assign)NSInteger sex;
/// xmppID
@property(nonatomic,copy)NSString* smackId;

@property(nonatomic,copy)NSString* smsValidNum;

@property(nonatomic,copy)NSString* sourcePic;

@property(nonatomic,assign)NSInteger sourceType;

@property(nonatomic,assign)NSInteger status;

@property(nonatomic,assign)NSInteger type;

@property(nonatomic,copy)NSString* userName;

@property(nonatomic,copy)NSString* userNum;

@property(nonatomic,copy)NSString* userNumPic;

@property(nonatomic,copy)NSString* userPic;

@property(nonatomic,copy)NSString* version;

@property(nonatomic,copy)NSString* versionName;

@property(nonatomic,copy)NSString* weixinId;

@property(nonatomic,copy)NSString* workAge;

/// 用户头像
@property(nonatomic,copy)NSString* appHeadPic;

/// 是否显示推广费 0: false 1: true
@property(nonatomic,assign)NSInteger showPromotionMoney;
@end
