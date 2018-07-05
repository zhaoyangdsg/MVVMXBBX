//
//  ZYHomeHttpTool.m
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/6/14.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYHomeHttpTool.h"
#import "ZYHttpTool.h"
#import "NSURLRequest+ZY.h"
#import "ZYHomeItem.h"
#import "MJExtension.h"
#import "ZYHomeTopicItem.h"
#import "ZYHomeAdItem.h"
#import "ZYHomeProductItem.h"
@implementation ZYHomeHttpTool
singleM(ZYHomeHttpTool)
- (void)loadHomeDataWithSuccess:(void (^)(id))success Failure:(void (^)(NSError *))failure {
//    let url = APP_HEAD_URL + "app/home/homePicList.do"
//    var param = Dictionary<String, Any>()
//    param["EnCode"] = "UTF-8" //as AnyObject?
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"EnCode"] = @"UTF-8";
    NSURLRequest *req = [ZYHttpTool.defaultTool postRequestWithUrl:@"app/home/homePicList.do" parameters:parameter];
    // 
    req.responseJsonWithSuccess = ^(id respJson) {
        NSLog(@"%@",respJson);
        [ZYHomeTopicItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"pdtId":@"id"};
        }];
        [ZYHomeProductItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"pdtId":@"id"};
        }];
        // 设置数组属性的model
        [ZYHomeItem mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"featureList":@"ZYHomeTopicItem",
                     @"recommend":@"ZYHomeProductItem",
                     @"result":@"ZYHomeAdItem"
                     };
        }];
        ZYHomeItem *homeItem = [ZYHomeItem mj_objectWithKeyValues:respJson];
        success(homeItem);
    };
    req.failureHandler = ^(NSError *error) {
        failure(error);
    };
    
    
    
}
@end
