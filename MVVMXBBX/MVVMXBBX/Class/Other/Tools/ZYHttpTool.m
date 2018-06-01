//
//  ZYHttpTool.m
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/5/21.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYHttpTool.h"

@interface ZYHttpTool()<NSURLSessionDelegate,NSURLSessionTaskDelegate,NSURLSessionDataDelegate>
@property(nonatomic,strong)NSURLSession * session;
@property(nonatomic,strong)NSURLSessionConfiguration *configuration;
@property(nonatomic,strong)NSOperationQueue *operationQueue;
@property(nonatomic,strong)NSURL *baseUrl;
@end
@implementation ZYHttpTool

+ (ZYHttpTool *)defaultTool {
   return [[ZYHttpTool alloc]initWithBaseUrl:@"http://app.xiaobaibao.com/"];
}
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
    return  self;
}

- (void)postRequestWithUrl:(NSString *)url parameters:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *error))failure {
    
    [self requestWithMethod:@"POST" url:url parameters:params success:success failure:failure];
}

- (void)getRequestWithUrl:(NSString *)url parameters:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [self requestWithMethod:@"GET" url:url parameters:params success:success failure:failure];
}

- (void)downloadWithUrl:(NSString *)url success:(NSString *(^)(NSString *))success failure:(void (^)(NSError *))failure {
    
}

- (void)requestWithMethod:(NSString *)method url:(NSString *)urlStr parameters:(NSDictionary *)params  success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    NSURL * url;

    if (self.baseUrl) {
        url = [NSURL URLWithString:urlStr relativeToURL:self.baseUrl];
    }else {
        url = [NSURL URLWithString:urlStr];
    }
    NSString * str = url.absoluteString;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
    request.HTTPMethod = method;
    if ([method isEqualToString:@"POST"]) {
        NSData *bodyData = [[self queryParameters:params]  dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:bodyData];
    }else {
        NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:false];
        urlComponents.percentEncodedQuery = [self queryParameters:params] ;
        request.URL = urlComponents.URL;
    }
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type" ];// .setValue("application/json", forHTTPHeaderField: "Content-Type")
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            failure(error);
        }else {
            if (((NSHTTPURLResponse*)response).statusCode == 200) {
                success(data);
            }else {
                failure([NSError errorWithDomain:@"response error" code:((NSHTTPURLResponse*)response).statusCode userInfo:nil]);
            }
        }
    }];
    
    [task resume];
}

///  把所有参数拼接成字符串
- (NSString *)queryParameters:(NSDictionary *) parameters {
    
    
    NSMutableArray *params = [NSMutableArray array];
    NSArray<NSString *> *keys = [ parameters.allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ((NSString *)obj1 < (NSString*)obj2 ) {
            return NSOrderedAscending;
        }else {
            return NSOrderedDescending;
        }
    }];
    
    for (NSString *key in keys) {
        [params addObjectsFromArray: [self queryComponentsWithKey:key value:parameters[key]]];
    }
    
    NSMutableString *paramStr = [[NSMutableString alloc]init];
    for (NSDictionary *paramDic in params ) {
        [paramDic enumerateKeysAndObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
            [paramStr appendString: [NSString stringWithFormat:@"%@=%@",key,obj]];
            [paramStr appendString:@"&"];
        }];
    }
    NSLog(@"%@",paramStr);

    return paramStr;
}
/// 遍历所有参数,遇到字典,数组 递归, 返回所有参数的字典数组
- (NSArray*)queryComponentsWithKey:(NSString*)key value:(NSObject*)value {
    NSMutableArray* components = [NSMutableArray array];
    if ([value isKindOfClass:[NSDictionary class]]) {
        [components addObjectsFromArray: [self queryComponentsWithKey:key value:value]];
    }else if ([value isKindOfClass:[NSArray class]]) {
        for (NSObject *aryValue in (NSArray *)value) {
            [components addObjectsFromArray:[self queryComponentsWithKey:key value:aryValue] ];
        }
    }else {
        [components addObject:@{[self escape:key]: [self escape: [NSString stringWithFormat:@"%@",value]]}];
    }
    
    return components;
}

/// 转码
- (NSString *)escape:(NSString *)str {
    return  [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}





//{
//    @"",@"",
//    @"",@2,
//    @"dics",{
//       @"key1",@"xx",
//        @"key2",@3
//    }
//    @"ary",[@"",@"",@""]
//}
//@"":@"",@"":@2,@"dics[key1]":@"",@"dics[key2]":@3,@"ary[]",
/**
public func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
    var components: [(String, String)] = []
    
    if let dictionary = value as? [String: Any] {
        for (nestedKey, value) in dictionary {
            components += queryComponents(fromKey: "\(key)[\(nestedKey)]", value: value)
        }
    } else if let array = value as? [Any] {
        for value in array {
            components += queryComponents(fromKey: "\(key)[]", value: value)
        }
    } else if let value = value as? NSNumber {
        if value.isBool {
            components.append((escape(key), escape((value.boolValue ? "1" : "0"))))
        } else {
            components.append((escape(key), escape("\(value)")))
        }
    } else if let bool = value as? Bool {
        components.append((escape(key), escape((bool ? "1" : "0"))))
    } else {
        components.append((escape(key), escape("\(value)")))
    }
    
    return components
}
*/


@end

@interface ZYHttpTool(SessionDelegate)

@end
