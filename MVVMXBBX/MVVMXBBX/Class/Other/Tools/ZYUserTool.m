//
//  ZYUserTool.m
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/6/5.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYUserTool.h"
#import "MJExtension.h"

NSString *K_user = @"user";
NSString *user2 = @"user";
@implementation ZYUserTool

+ (instancetype)shareInstance {
    static ZYUserTool *tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!tool) {
            tool = [[ZYUserTool alloc]init];
        }
    });
    return tool;
}
- (BOOL)saveUser:(ZYUserItem *)user {
    // NSKeyedArchiver 是NSCoder的子类 coder是编码器 用于把对象进行编码 变成可存储的data  keyed: 通过key来编码 而非顺序
    NSData* userData = [NSKeyedArchiver archivedDataWithRootObject:user];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:userData forKey:K_user];
    [userDefault synchronize];
    return true;
}
- (ZYUserItem *)getUser {
    NSData *data = [[NSUserDefaults standardUserDefaults] valueForKey:K_user];
    ZYUserItem *user = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return user;
}

- (BOOL)isLoging {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"isLoging"];
}

- (void)removeUser {
     [[NSUserDefaults standardUserDefaults]removeObjectForKey:K_user];
}

//- (BOOL)isLoging;
@end
