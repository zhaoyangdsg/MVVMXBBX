//
//  ZYHomeViewModel.m
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/7/5.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYHomeViewModel.h"
#import "ZYHomeHttpTool.h"
#import "ZYHomeItem.h"


@implementation ZYHomeViewModel

- (RACCommand *)loadDataCommand {
    if (!_loadDataCommand ) {
        _loadDataCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            RACSignal * signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [ZYHomeHttpTool.shareZYHomeHttpTool loadHomeDataWithSuccess:^(id resp) {
                    ZYHomeItem *item = resp;
                    NSLog(@"%@",item);
                } Failure:^(NSError *error) {
                    
                }];
                return  nil;
            }];
            return signal;
        }];
    }
   
    return _loadDataCommand;
}
@end
