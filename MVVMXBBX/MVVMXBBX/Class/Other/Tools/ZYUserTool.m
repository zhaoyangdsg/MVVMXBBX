//
//  ZYUserTool.m
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/6/5.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYUserTool.h"
#import "MJExtension.h"
#import "NSString+ZY.h"

NSString *K_user = @"user";
NSString *K = @"user";
#define k_user @"user"
#define k_isLoging @"isLoging"
#define k_userPlist @"user.plist"
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

    BOOL isSuccess = [NSKeyedArchiver archiveRootObject:user toFile:k_userPlist.documentPath];
    [self setIsLoging:isSuccess];
    return isSuccess;
}
- (ZYUserItem *)getUser {
    if ([self isLoging]) {
        ZYUserItem *user = [NSKeyedUnarchiver unarchiveObjectWithFile:k_userPlist.documentPath];
        return user;
    }
    return nil;
}

- (void)removeUser {
    if ([[NSFileManager defaultManager] isDeletableFileAtPath:k_userPlist]) {
        [[NSFileManager defaultManager] removeItemAtPath:k_userPlist error:nil];
    }
    [self setIsLoging:false];
}

- (BOOL)isLoging {
    return [[NSUserDefaults standardUserDefaults] boolForKey:k_isLoging];
}

- (void)setIsLoging:(BOOL)isLoging{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setBool:isLoging forKey:k_isLoging];
    [userDefault synchronize];
}

@end
