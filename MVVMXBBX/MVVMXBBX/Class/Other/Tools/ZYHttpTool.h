//
//  ZYHttpTool.h
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/5/21.
//  Copyright © 2018年 me2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYHttpTool : NSObject
+ (ZYHttpTool*)defaultTool;
- (instancetype)init;
- (instancetype)initWithBaseUrl:(NSString *)baseUrl;
- (instancetype)initWithBaseUrl:(NSString *)baseUrl configuration:(NSURLSessionConfiguration *)configuration;
- (NSURLRequest*)postRequestWithUrl:(NSString *) url parameters:(NSDictionary *)params ;
- (NSURLRequest*)getRequestWithUrl:(NSString *) url parameters:(NSDictionary *)params ;
- (void)downloadWithUrl:(NSString *) url success:(NSString*(^)(NSString* address))success failure:(void(^)(NSError *))failure;
@end
