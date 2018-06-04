//
//  ZYLoginResutItem.h
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/6/4.
//  Copyright © 2018年 me2. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZYUserItem;
@interface ZYLoginResutItem : NSObject
//var user: [XBBXUserItem]?
//
//var success: Bool = false
//
//var isPermit: Bool = false
//
//var type: String?
//
//var pwd: Bool = false
//
//var isHasUser: Bool = false
//
//var firstLogin: Bool = false
@property(nonatomic,strong)NSArray<ZYUserItem*> *user;
@property(nonatomic,assign)BOOL success;
@property(nonatomic,assign)BOOL isPermit;
@property(nonatomic,assign)BOOL pwd;
@property(nonatomic,assign)BOOL isHasUser;
@property(nonatomic,assign)BOOL firstLogin;
@property(nonatomic,copy)NSString *type;
@end
