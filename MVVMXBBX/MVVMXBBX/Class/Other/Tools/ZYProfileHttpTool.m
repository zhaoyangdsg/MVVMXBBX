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
#import "ZYUserTool.h"
#import "ZYProfileWalletItem.h"
#import "ZYGetMoneyItem.h"

@interface ZYProfileHttpTool()

@property(nonatomic,strong)ZYHttpTool *httpTool;
/** request */
@property (nonatomic,strong)NSURLRequest *request;
@end
@implementation ZYProfileHttpTool

singleM(ZYProfileHttpTool)
- (void)loginWithUser:(NSString *)user password:(NSString *)password successHandler:(handlerBlock)successHandler  failureHandler:(handlerBlock)failureHandler {
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    paramDic[@"mobile"] = user;
    paramDic[@"password"] = password;
    paramDic[@"isEnc"] = @"1";
    paramDic[@"regSource"] = @"1";
    paramDic[@"versionName"] = @"ios.xiaobai";
    paramDic[@"EnCode"] = @"UTF-8";
    paramDic[@"version"] = [NSString stringWithFormat:@"%@",NSBundle.mainBundle.infoDictionary[@"CFBundleVersion"]];
    NSLog(@"%@",paramDic);
    NSString *apiUrl = @"app/user/login.do";
    
    self.request = [self.httpTool postRequestWithUrl:apiUrl parameters:paramDic];
    
    // response 返回成功
    self.request.responseJsonWithSuccess = ^(id respJson) {
        
        [ZYLoginResutItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"userId":@"id"};
        }];
//        NSLog(@"%@",[respJson valueForKey:@"param"][0]);
        ZYLoginResutItem *loginResult = [ZYLoginResutItem mj_objectWithKeyValues:[respJson valueForKey:@"param"][0]];
        if (loginResult.success == 1) {
            ZYUserItem *user =[ZYUserItem mj_objectWithKeyValues: loginResult.user[0]];
            
           
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

- (void)loadMyWalletDataSuccessHandler:(void (^)(ZYProfileWalletItem *))success failureHandler:(void (^)(NSError *))failure {
//    let url = APP_HEAD_URL + "/app/cash/appMoneyBag.do"
//
//    var param = Dictionary<String, AnyObject>()
//    //        param["EnCode"] = "UTF-8"
//    param["mobile"] = XBBXAccountTool.getAccount()?.mobile as AnyObject?
//    param["pwd"] = XBBXAccountTool.getAccount()?.password as AnyObject?
//    param["EnCode"] = "UTF-8" as AnyObject?
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    ZYUserItem *user = [ZYUserTool.shareInstance getUser];
    parameters[@"mobile"] = user.mobile;
    parameters[@"pwd"] = user.password; //@"1"; //
    parameters[@"EnCode"] = @"UTF-8";
    NSURLRequest *request = [self.httpTool postRequestWithUrl:@"/app/cash/appMoneyBag.do" parameters:parameters];
    request.responseJsonWithSuccess = ^(id respJson) {
        NSLog(@"%@",respJson[@"param"][0][@"success"]);
        NSNumber *isSuccess = (NSNumber*)respJson[@"param"][0][@"success"];
        
        if (isSuccess.intValue ) {
            ZYProfileWalletItem *walletItem = [ZYProfileWalletItem  mj_objectWithKeyValues:respJson[@"param"][0]];
            success(walletItem);
        }else {
            
            failure([[NSError alloc]initWithDomain:@"参数错误" code: 1 userInfo:nil]);
        }
    };
    request.failureHandler = ^(NSError *error) {
        NSLog(@"%@",error);
        failure(error);
    };
}

- (void)loadGetMoneyDataSuccess:(void(^)(ZYGetMoneyItem *item))success failure:(void(^)(NSError *error))failure {
    {
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        ZYUserItem *user = [ZYUserTool.shareInstance getUser];
        if (!(user.mobile && user.password)) {
            NSError *error = [[NSError alloc]initWithDomain:@"用户信息不完整" code:1 userInfo:nil];
            failure(error);
        }
        parameters[@"mobile"] = user.mobile;
        parameters[@"password"] = user.password;
        parameters[@"EnCode"] = @"UTF-8";
        NSURLRequest *request = [self.httpTool postRequestWithUrl:@"app/cash/initPrepScore.do" parameters:parameters];
        request.responseJsonWithSuccess = ^(id respJson) {
            NSLog(@"%@",respJson);
            NSNumber *isSuccess = (NSNumber*)respJson[@"canUserScore"];
            
            if (isSuccess ) {
                ZYGetMoneyItem *getMoneyItem = [ZYGetMoneyItem  mj_objectWithKeyValues:respJson];
                
                success(getMoneyItem);
                
            }else {
                failure([[NSError alloc]initWithDomain:@"获取数据错误" code: 1 userInfo:nil]);
            }
        };
        
        request.failureHandler = ^(NSError *error) {
            NSLog(@"%@",error);
            failure(error);
        };
  
    }
}

- (ZYHttpTool *)httpTool {
    return ZYHttpTool.defaultTool;
}
//+ (instancetype)shareInstance {
//    static ZYProfileHttpTool* tool;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        tool = [[ZYProfileHttpTool alloc]init];
//    });
//    return tool;
//}

@end
