//
//  ZYHomePdtCellViewModel.m
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/7/6.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYHomePdtCellViewModel.h"
#import "ZYHomeProductItem.h"
#import "ZYProductItem.h"

@interface ZYHomePdtCellViewModel()
@property (nonatomic,strong) ZYHomeProductItem *pdtItem;
@property (nonatomic,strong) ZYProductItem *pdtItem2;
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

- (instancetype)initWithPdtModel:(ZYProductItem *)productItem {
    self = [super init];
    if (self) {
        self.pdtItem2 = productItem;
        self.money = [@"¥" stringByAppendingString:productItem.moeny];
        self.pdtName = productItem.name;
        self.suit = productItem.suit;
        self.imgUrl = [@"" stringByAppendingString: productItem.clogo ];
    }
    return self;
}


@end
