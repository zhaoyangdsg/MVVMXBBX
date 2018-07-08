//
//  ZYHomeViewController.m
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/6/13.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYHomeViewController.h"
#import "SDCycleScrollView.h"
#import "ZYHomeTopicView.h"
#import "ZYHomeCategoryView.h"
#import "ZYHomeHttpTool.h"
#import "ZYHomeItem.h"
#import "ZYHomeViewModel.h"
#import "ZYHomePdtCell.h"

@interface ZYHomeViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) ZYHomeViewModel *homeViewModel;
@property (nonatomic,weak) SDCycleScrollView *carouseView;
@property (nonatomic,weak) ZYHomeTopicView *topicView;
@end

@implementation ZYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubview];
    
    [self bindViewModel];
}
- (void)setupSubview {
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell1"];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell2"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZYHomePdtCell" bundle:nil] forCellReuseIdentifier:@"cell3"];

    
    SDCycleScrollView *scrollView =  [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.width , 0.6*self.view.width) delegate:self placeholderImage:[UIImage imageNamed:@"pic_1"]];
    //    [self.tableView addSubview:scrollView];
    self.tableView.tableHeaderView = scrollView;
    self.carouseView = scrollView;
    //    scrollView.localizationImageNamesGroup = @[@"pic_1",@"pic_1"];
}

- (void)bindViewModel {
    self.homeViewModel = [[ZYHomeViewModel alloc]init];
    [[[self.homeViewModel.loadDataCommand execute:nil] deliverOnMainThread] subscribeCompleted:^{
        [self.topicView bindHomeViewModel:self.homeViewModel];
        self.carouseView.imageURLStringsGroup = self.homeViewModel.adImgAry;
        [self.tableView reloadData];
    }];
}

- (void)loadData {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *view = [[UITableView alloc]init];
        view.dataSource = self;
        view.delegate = self;
        _tableView = view;
    }
    return _tableView;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

// MARK:- SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"%ld",self.homeViewModel.adUrlAry[index]);
    
}

// MARK:- UITableViewDataSource
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        ZYHomeCategoryView *view = [[NSBundle mainBundle]loadNibNamed:@"ZYHomeCategoryView" owner:self options:nil].firstObject;
        if (view) {
            [[view.btn1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                NSLog(@"点击btn1");
            }] ;
            [[view.btn2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                NSLog(@"点击btn2");
            }] ;
            view.btn3ClkSubject = [[RACSubject alloc]init];
            // subscribeNext:^(id x)  ->信号接收方获取发送方传过来的数据x的方法
            [view.btn3ClkSubject subscribeNext:^(UIButton *btn) {
                NSLog(@"点击btn3");
                [btn setImage:nil forState:UIControlStateNormal];
            }];
            view.btn4ClkCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * (NSString *input) {
                RACSignal *signal = [RACSignal createSignal:^RACDisposable * (id<RACSubscriber>  subscriber) {
                    NSLog(@"点击btn4");
                    [subscriber sendNext:@"点击btn4"];
                    [subscriber sendCompleted];
                    return nil;
                }];
                return signal;
            }];
            [cell.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.bottom.equalTo(cell.contentView);
            }];
        }
        return cell;
    } else if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        //        ZYHomeTopicView *view = [[NSBundle mainBundle]loadNibNamed:@"ZYHomeTopicView" owner:self options:nil].firstObject;
        
        //        if (view) {
        NSLog(@"%@",cell.contentView.subviews);
        [cell.contentView addSubview:self.topicView];
        
        [self.topicView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(cell.contentView);
        }];
        
        return cell;
    }else {
        ZYHomePdtCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
        if (self.homeViewModel.pdtVMAry.count >0) {
            [cell bindViewModel:self.homeViewModel.pdtVMAry[indexPath.row]];
        }
        
        return cell;
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return self.homeViewModel.pdtVMAry.count<=6?self.homeViewModel.pdtVMAry.count:6;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return self.tableView.width * 0.267;
    }else if (indexPath.section == 1) {
        return 240;
    }else {
        return 150;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (ZYHomeTopicView *)topicView {
    if (!_topicView) {
        ZYHomeTopicView *view = [[NSBundle mainBundle]loadNibNamed:@"ZYHomeTopicView" owner:self options:nil].firstObject;
        _topicView = view;
        
        
        self.topicView.btn1ClickSubject = [RACSubject subject];
        [self.topicView.btn1ClickSubject subscribeNext:^(UIButton *btn) {
            NSLog(@"点击btn1 %@",self.homeViewModel.topic1Url);
        }];
        self.topicView.btn2ClickSubject = [RACSubject subject];
        [self.topicView.btn2ClickSubject subscribeNext:^(UIButton *btn) {
            NSLog(@"点击btn2 %@",self.homeViewModel.topic2Url);
        }];
        self.topicView.btn3ClickSubject = [RACSubject subject];
        [self.topicView.btn3ClickSubject subscribeNext:^(UIButton *btn) {
            NSLog(@"点击btn3 %@",self.homeViewModel.topic3Url);
        }];
        
    }
    return _topicView;
}

@end
