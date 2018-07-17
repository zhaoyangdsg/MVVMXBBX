//
//  ZYPersonInsController.h
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/7/12.
//  Copyright © 2018年 me2. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZYPersonInsType) {
    ZYPersonInsType_GN = 1,
    ZYPersonInsType_GW,
    ZYPersonInsType_YW,
    ZYPersonInsType_JC,
    ZYPersonInsType_JK

};


@interface ZYPersonInsController : UITableViewController
@property (nonatomic) ZYPersonInsType insType;
@end
