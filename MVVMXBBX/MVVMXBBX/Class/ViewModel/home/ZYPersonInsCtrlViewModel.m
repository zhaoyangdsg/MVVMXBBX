//
//  ZYPersonInsCtrlViewModel.m
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/7/17.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYPersonInsCtrlViewModel.h"
#import "ZYHomeHttpTool.h"
#import "ZYProductItem.h"
#import "ZYHomePdtCellViewModel.h"

@interface ZYPersonInsCtrlViewModel()
@property (nonatomic)ZYPersonInsType insType;
@property (nonatomic,strong)NSMutableArray<ZYProductItem *> *pdtAry;
@property (nonatomic,assign)NSInteger pageCount;

@end

@implementation ZYPersonInsCtrlViewModel
- (instancetype)initWithType:(ZYPersonInsType)insType {
    if (self = [super init]) {
        self.insType = insType;
        self.pdtAry = [NSMutableArray array];
        [self initialBinding];
    }
    return self;
}

- (void)initialBinding {
    
    _loadDataCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable * (id<RACSubscriber> subscriber) {
            
            [ZYHomeHttpTool.shareZYHomeHttpTool loadPersonInsByType:1 pageNo:_pageNo  withSuccess:^(id resp) {
                // @"pdtItemAry":pdtItemAry,@"total":total,@"pageCount"
                self.pdtAry = resp[@"pdtItemAry"];
                self.total = (int)resp[@"total"] ;
                self.pageCount = (NSInteger)resp[@"pageCount"];
                for (ZYHomeProductItem *item in self.pdtAry) {
                    ZYHomePdtCellViewModel *vm = [[ZYHomePdtCellViewModel alloc]initWithModel:item];
                    [self.pdtVMArray addObject:vm];
                }
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
            } failure:^(NSError *error) {
                [subscriber sendError:error];
            }];
            
            return nil;
        }];
        return signal;
    }];
    
}
@end
