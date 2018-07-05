//
//  ZYHomeHttpTool.h
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/6/14.
//  Copyright © 2018年 me2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYHomeHttpTool : NSObject
singleH(ZYHomeHttpTool)
- (void)loadHomeDataWithSuccess:(void(^)(id resp))success Failure:(void(^)(NSError *error))failure;
@end
