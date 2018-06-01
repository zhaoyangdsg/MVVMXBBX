//
//  ZYProfileHttpTool.m
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/6/1.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYProfileHttpTool.h"
#import "ZYHttpTool.h"

@interface ZYProfileHttpTool()
@property(nonatomic,strong)ZYHttpTool *httpTool;
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
    
    [self.httpTool postRequestWithUrl:apiUrl parameters:paramDic success:^(id resp) {
        NSLog(@"%@",(NSData *)resp);
        successHandler(resp);
    } failure:^(NSError *error) {
        NSLog(error);
        failureHandler(error);
    }];
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
