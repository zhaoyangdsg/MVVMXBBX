//
//  ZYHomePdtCell.h
//  MVVMXBBX
//
//  Created by 扬扬 on 2018/7/8.
//  Copyright © 2018年 me2. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZYHomePdtCellViewModel;
@interface ZYHomePdtCell : UITableViewCell
- (void)bindViewModel:(ZYHomePdtCellViewModel *)viewModel;
@end
