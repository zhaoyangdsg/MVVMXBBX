//
//  ZYHomePdtCellViewModel.h
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/7/6.
//  Copyright © 2018年 me2. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZYHomeProductItem;
@interface ZYHomePdtCellViewModel : NSObject
- (instancetype)initWithModel:(ZYHomeProductItem *)productItem;
@property (nonatomic,copy) NSString *imgUrl;
@property (nonatomic,copy) NSString *money;
@property (nonatomic,copy) NSString *pdtName;
@property (nonatomic,copy) NSString *suit;
@end
