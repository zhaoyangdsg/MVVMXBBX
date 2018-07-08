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
#import "ZYHomeTopicItem.h"
#import "ZYHomeProductItem.h"
#import "ZYHomeAdItem.h"
#import "ZYHomePdtCellViewModel.h"

@implementation ZYHomeViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialBinding];
    }
    return self;
}
- (void)initialBinding {
    _loadDataCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal * signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [ZYHomeHttpTool.shareZYHomeHttpTool loadHomeDataWithSuccess:^(id resp) {
                ZYHomeItem *item = resp;
//                NSLog(@"%@",item);
                // 专题
                for (int i = 0; i<item.featureList.count; i++) {
                    ZYHomeTopicItem *topicItem = item.featureList[i];
                    if (i == 0) {
                        self.topic1Img = [k_img_Url stringByAppendingString: topicItem.homeImgUrl];
                        self.topic1Url = [@"" stringByAppendingString: topicItem.pdtId];
                    }
                    if (i == 1) {
                        self.topic2Img = [k_img_Url stringByAppendingString:topicItem.homeImgUrl];
                        self.topic2Url = [@"" stringByAppendingString: topicItem.pdtId];
                    }
                    if (i == 2) {
                        self.topic3Img = [k_img_Url stringByAppendingString:topicItem.homeImgUrl];
                        self.topic3Url = [@"" stringByAppendingString: topicItem.pdtId];
                    }
                }
                // 轮播图
                for (ZYHomeAdItem *adItem in item.result) {
                    [self.adImgAry addObject: [k_img_Url stringByAppendingString: adItem.picUrl]];
                    [self.adUrlAry addObject:[@"" stringByAppendingString: adItem.adUrl]];
                }
                
                // 推荐产品
                for (ZYHomeProductItem *pdtItem in item.recommend ) {
                    ZYHomePdtCellViewModel * model = [[ZYHomePdtCellViewModel alloc]initWithModel:pdtItem];
                    [self.pdtVMAry addObject:model];
                }
                
                [subscriber sendNext: nil];
                [subscriber sendCompleted];
                
            } Failure:^(NSError *error) {
                [subscriber sendError:error];
            }];
            return  nil;
        }];
        return signal;
    }];
    
    
}

- (NSMutableArray *)pdtVMAry {
    if (!_pdtVMAry) {
        _pdtVMAry = [NSMutableArray array];
    }
    return _pdtVMAry;
}

- (NSMutableArray *)adUrlAry {
    if (!_adUrlAry) {
        _adUrlAry = [NSMutableArray array];
    }
    return _adUrlAry;
}

- (NSMutableArray *)adImgAry {
    if (!_adImgAry) {
        _adImgAry = [NSMutableArray array];
    }
    return  _adImgAry;
}

@end
