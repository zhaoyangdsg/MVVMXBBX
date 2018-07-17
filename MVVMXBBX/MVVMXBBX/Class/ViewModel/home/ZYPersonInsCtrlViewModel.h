//
//  ZYPersonInsCtrlViewModel.h
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/7/17.
//  Copyright © 2018年 me2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYPersonInsController.h"
@class ZYHomePdtCellViewModel;
@interface ZYPersonInsCtrlViewModel : NSObject

@property (nonatomic,strong)RACCommand *loadDataCommand;
@property (nonatomic,assign)int pageNo;
@property (nonatomic,assign)int total;
@property (nonatomic,strong)NSMutableArray<ZYHomePdtCellViewModel *> *pdtVMArray;
- (instancetype)initWithType:(ZYPersonInsType)insType;
@end
