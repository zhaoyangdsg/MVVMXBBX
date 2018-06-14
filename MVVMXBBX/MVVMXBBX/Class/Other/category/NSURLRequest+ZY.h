//
//  NSURLRequest+ZY.h
//  MVVMXBBX
//
//  Created by 扬扬 on 2018/6/3.
//  Copyright © 2018年 me2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLRequest (ZY)
@property(nonatomic,strong)NSURLResponse *response;
@property(nonatomic,strong)NSError *respError;

/**  */
@property (nonatomic,strong)void(^responseJsonWithSuccess)(id respJson);
/**  */
@property (nonatomic,strong)void(^failureHandler)(NSError *error) ;
//responseJsonWithSuccess:success failure:(void(^)(NSError *error))failure;
//- (NSURLRequest *)successHandler:(void(^)(id resp))success;
//- (NSURLRequest *)failureHandler:(void(^)(NSError *error))failuer;
@end
