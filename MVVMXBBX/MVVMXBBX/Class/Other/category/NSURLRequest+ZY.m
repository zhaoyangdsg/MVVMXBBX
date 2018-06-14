//
//  NSURLRequest+ZY.m
//  MVVMXBBX
//
//  Created by 扬扬 on 2018/6/3.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "NSURLRequest+ZY.h"
#import <objc/runtime.h>
#import "NSURLResponse+ZY.h"
@implementation NSURLRequest (ZY)

//typedef OBJC_ENUM(uintptr_t, objc_AssociationPolicy) {
//    OBJC_ASSOCIATION_ASSIGN = 0,           /**< Specifies a weak reference to the associated object. */
//    OBJC_ASSOCIATION_RETAIN_NONATOMIC = 1, /**< Specifies a strong reference to the associated object.
//                                            *   The association is not made atomically. */
//    OBJC_ASSOCIATION_COPY_NONATOMIC = 3,   /**< Specifies that the associated object is copied.
//                                            *   The association is not made atomically. */
//    OBJC_ASSOCIATION_RETAIN = 01401,       /**< Specifies a strong reference to the associated object.
//                                            *   The association is made atomically. */
//    OBJC_ASSOCIATION_COPY = 01403          /**< Specifies that the associated object is copied.
//                                            *   The association is made atomically. */
//};

const char ZYResponseKey;
- (void)setResponse:(NSURLResponse *)response {

    objc_setAssociatedObject(self, &ZYResponseKey, response, 1);
    if (response != nil && self.responseJsonWithSuccess) {
        id resp = [NSJSONSerialization JSONObjectWithData:self.response.data   options:NSJSONReadingAllowFragments error:nil];
                NSLog(@"%@",resp);
        
        self.responseJsonWithSuccess(resp);
    }
}
- (NSURLResponse *)response {
    return  objc_getAssociatedObject(self, &ZYResponseKey);
}


- (void)setRespError:(NSError *)respError {
    objc_setAssociatedObject(self, @"respError", respError, 1);
    if (respError != nil && self.failureHandler) {
        self.failureHandler(respError);
    }
}
- (NSError *)respError {
    return objc_getAssociatedObject(self, @"respError");
}


- (void)setResponseJsonWithSuccess:(void (^)(id))responseJsonWithSuccess {
    objc_setAssociatedObject(self, @"successHandler", responseJsonWithSuccess, 1);
}
- (void (^)(id))responseJsonWithSuccess {
    return  objc_getAssociatedObject(self, @"successHandler");
}

- (void)setFailureHandler:(void (^)(NSError *))failureHandler {
    objc_setAssociatedObject(self, @"failureHandler", failureHandler, 1);
}
- (void (^)(NSError *))failureHandler {
    return objc_getAssociatedObject(self, @"failureHandler");
}
//- (void)responseJsonWithSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure {
//    if (self.response) {
//        id resp = [NSJSONSerialization JSONObjectWithData:self.response.data   options:NSJSONReadingAllowFragments error:nil];
//        NSLog(resp);
//        success(resp);
//    }
//    if (self.respError) {
//        failure(self.respError);
//    }
//}

@end
