//
//  ZYHttpTool.m
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/5/21.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYHttpTool.h"

@interface ZYHttpTool()<NSURLSessionDelegate>
@property(nonatomic,strong)NSURLSession * session;
@property(nonatomic,strong)NSURLSessionConfiguration *configuration;
@property(nonatomic,strong)NSOperationQueue *operationQueue;
@property(nonatomic,strong)NSURL *baseUrl;
@end
@implementation ZYHttpTool

- (instancetype)init {
    return [self initWithBaseUrl:nil];
}
- (instancetype)initWithBaseUrl:(NSString *)baseUrl {
    return  [self initWithBaseUrl:baseUrl configuration:nil];
    
}

- (instancetype)initWithBaseUrl:(NSString *)baseUrl configuration:(NSURLSessionConfiguration *)configuration {
    if (self = [super init]) {
        // 如果没有设置configuration 设置默认configuration
        if (!configuration) {
            self.configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        }
        self.configuration = configuration;
        NSURL *url = [NSURL URLWithString:baseUrl];
        if (url) {
            // 如果url最后不包含'/' 通过URLByAppendingPathComponent:@"" 添加/
            if (![baseUrl hasSuffix:@"/"]) {
                [url URLByAppendingPathComponent:@""];
            }
            
            self.baseUrl = url;
        }
        
        self.session = [NSURLSession sessionWithConfiguration:self.configuration delegate:self delegateQueue:self.operationQueue];
    }
    return  nil;
}

- (void)postRequestWithUrl:(NSString *)url parameters:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    [self requestWithMethod:@"GET" url:url parameters:params success:success failure:failure];
}

- (void)getRequestWithUrl:(NSString *)url parameters:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [self requestWithMethod:@"POST" url:url parameters:params success:success failure:failure];
}

- (void)downloadWithUrl:(NSString *)url success:(NSString *(^)(NSString *))success failure:(void (^)(NSError *))failure {
    
}

- (void)requestWithMethod:(NSString *)method url:(NSString *)urlStr parameters:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSURL * url;
    
        
        if (self.baseUrl) {
            url = [NSURL URLWithString:urlStr relativeToURL:self.baseUrl];
        }else {
            url = [NSURL URLWithString:urlStr];
        }
    

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
    request.HTTPMethod = method;
    if ([method isEqualToString:@"POST"]) {
        
    }
}


@end
