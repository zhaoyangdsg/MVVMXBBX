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

#import "ZYHomeTopicItem.h"
#import "ZYHomeAdItem.h"
#import "ZYHomeProductItem.h"
#import "ZYProductItem.h"
@implementation ZYHomeHttpTool
singleM(ZYHomeHttpTool)

- (void)loadPersonInsByType:(int)type pageNo:(int)pageNo withSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure {

    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    paramDic[@"EnCode"] = @"UTF-8";
    paramDic[@"typeId"] = @"0";
    paramDic[@"type"] = @"gn";
    paramDic[@"offset"] = [NSString stringWithFormat:@"%d", pageNo];
    NSURLRequest *request = [ZYHttpTool.defaultTool postRequestWithUrl:@"/app/product/searchlist.do" parameters:paramDic];
    request.responseJsonWithSuccess = ^(id respJson) {
        NSArray *pdtItemAry = [ZYProductItem mj_objectArrayWithKeyValuesArray:respJson[@"result"]];
        NSString *total =  respJson[@"param"][0][@"total"] ;
        NSString *pageCount =  respJson[@"param"][0][@"maxPage"];
        NSDictionary *resultDic = @{@"pdtItemAry":pdtItemAry,@"total":total,@"pageCount":pageCount};
        success(resultDic);
    };
    request.failureHandler = ^ (NSError *error) {
        NSLog(@"%@",error);
        failure(error);
    };
}

- (void)loadHomeDataWithSuccess:(void (^)(id))success Failure:(void (^)(NSError *))failure {
//    let url = APP_HEAD_URL + "app/home/homePicList.do"
//    var param = Dictionary<String, Any>()
//    param["EnCode"] = "UTF-8" //as AnyObject?
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"EnCode"] = @"UTF-8";
    NSURLRequest *req = [ZYHttpTool.defaultTool postRequestWithUrl:@"app/home/homePicList.do" parameters:parameter];
    // 
    req.responseJsonWithSuccess = ^(id respJson) {
        // 缓存首页数据
        [[NSUserDefaults standardUserDefaults] setObject:respJson forKey:k_homeData];

        ZYHomeItem *homeItem = [ZYHomeItem mj_objectWithKeyValues:respJson];
        success(homeItem);
    };
    req.failureHandler = ^(NSError *error) {
        failure(error);
    };

}
@end
