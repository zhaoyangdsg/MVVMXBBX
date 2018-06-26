//
//  ZYGetMoneyView.h
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/6/25.
//  Copyright © 2018年 me2. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZYGetMoneyViewModel;
@interface ZYGetMoneyView : UIView
@property (weak, nonatomic) IBOutlet UILabel *taxLabel;
@property (weak, nonatomic) IBOutlet UILabel *serviceLabel;
@property (weak, nonatomic) IBOutlet UILabel *finalLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *finalLabel2;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;
- (instancetype)initWithViewModel:(ZYGetMoneyViewModel *)viewModel;
@end
