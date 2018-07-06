//
//  ZYHomeViewModel.h
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/7/5.
//  Copyright © 2018年 me2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYHomeViewModel : NSObject
@property (nonatomic,strong) RACCommand *loadDataCommand;

@property (nonatomic,strong) NSString *topic1Img;
@property (nonatomic,strong) NSString *topic2Img;
@property (nonatomic,strong) NSString *topic3Img;
@property (nonatomic,strong) NSString *topic1Url;
@property (nonatomic,strong) NSString *topic2Url;
@property (nonatomic,strong) NSString *topic3Url;
@property (nonatomic,strong) RACTuple *topic1Tuple;
@property (nonatomic,strong) NSMutableArray *adImgAry;
@property (nonatomic,strong) NSMutableArray *adUrlAry;
@property (nonatomic,strong) NSMutableArray *pdtVMAry ;
@end
