//
//  ZYProfileHttpTool.m
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/6/1.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYProfileHttpTool.h"
#import "ZYHttpTool.h"
#import "NSURLRequest+ZY.h"
#import "ZYLoginResutItem.h"
#import "ZYUserItem.h"
#import "MJExtension.h"

@interface ZYProfileHttpTool()
@property(nonatomic,strong)ZYHttpTool *httpTool;
/** request */
@property (nonatomic,strong)NSURLRequest *request;
@end
@implementation ZYProfileHttpTool


- (void)loginWithUser:(NSString *)user password:(NSString *)password successHandler:(handlerBlock)successHandler  failureHandler:(handlerBlock)failureHandler {
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    paramDic[@"mobile"] = user;
    paramDic[@"password"] = password;
    paramDic[@"isEnc"] = @"1";
    paramDic[@"regSource"] = @"1";
    paramDic[@"versionName"] = @"ios.xiaobai";
    paramDic[@"EnCode"] = @"UTF-8";
    paramDic[@"version"] = [NSString stringWithFormat:@"%@",NSBundle.mainBundle.infoDictionary[@"CFBundleVersion"]];
    
    NSString *apiUrl = @"app/user/login.do";
    
    self.request = [self.httpTool postRequestWithUrl:apiUrl parameters:paramDic];
    
    // response 返回成功
    self.request.responseJsonWithSuccess = ^(id respJson) {
        
        [ZYLoginResutItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"userId":@"id"};
        }];
        NSLog(@"%@",[respJson valueForKey:@"param"][0]);
        ZYLoginResutItem *loginResult = [ZYLoginResutItem mj_objectWithKeyValues:[respJson valueForKey:@"param"][0]];
        if (loginResult.success == 1) {
            ZYUserItem *user = loginResult.user[0];
            NSData* userData = [NSKeyedArchiver archivedDataWithRootObject:user];
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:userData forKey:@"user"];
            [userDefault synchronize];
            successHandler(user);
            
        }else {
            NSError *error = [NSError errorWithDomain:@"用户名或密码不正确" code:11 userInfo:nil];
            failureHandler(error);
        }

        // 根据返回报表 做出判断 成功:返回user信息 失败:返回失败原因
    };
    // response 返回失败
    self.request.failureHandler = ^(NSError *error) {
        NSLog(@"%@",error.domain);
        failureHandler(error);
    };
    
}

- (ZYHttpTool *)httpTool {
    return ZYHttpTool.defaultTool;
}
+ (instancetype)shareInstance {
    static ZYProfileHttpTool* tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[ZYProfileHttpTool alloc]init];
    });
    return tool;
}

@end
