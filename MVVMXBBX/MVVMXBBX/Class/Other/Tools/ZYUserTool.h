//
//  ZYUserTool.h
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/6/5.
//  Copyright © 2018年 me2. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZYUserItem;
@interface ZYUserTool : NSObject
+ (instancetype)shareInstance;
- (BOOL)saveUser:(ZYUserItem *)user;
- (ZYUserItem *)getUser;
- (BOOL)isLoging;
- (void)removeUser;
@end
