//
//  ZYHomePdtCellViewModel.m
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/7/6.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYHomePdtCellViewModel.h"
#import "ZYHomeProductItem.h"

@interface ZYHomePdtCellViewModel()
@property (nonatomic,strong) ZYHomeProductItem *pdtItem;
@end
@implementation ZYHomePdtCellViewModel
- (instancetype)initWithModel:(ZYHomeProductItem *)productItem {
    self = [super init];
    if (self) {
        self.pdtItem = productItem;
        self.money = [@"¥" stringByAppendingString:productItem.sellMoney];
        self.pdtName = productItem.name;
        self.suit = productItem.suit;
        self.imgUrl = [@"" stringByAppendingString: productItem.logo ];
    }
    return self;
}


@end
