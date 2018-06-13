//
//  ZYProfileViewController.m
//  MVVMXBBX
//
//  Created by me2 on 2018/5/9.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYProfileViewController.h"
#import "ZYLoginView.h"
#import "ZYlogViewModel.h"
#import "UIView+ZY.h"
#import "ZYProfileHeaderViewModel.h"
#import "ZYProfileHeaderView.h"
#import "ZYUserTool.h"
#import "SVProgressHUD.h"


@interface ZYProfileViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) ZYLogViewModel *loginViewModel;
/** loginView */
@property (weak,nonatomic)ZYLoginView *loginView;
/** tableView */
@property (weak,nonatomic)UITableView *tableView;
@property(strong,nonatomic)ZYProfileHeaderViewModel *headerViewModel;
@property(weak,nonatomic)ZYProfileHeaderView *headerView;
@end

@implementation ZYProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self setupSubView];
}


- (void)setupSubView {
    Boolean isLogin = ZYUserTool.shareInstance.isLoging;
    
    if (!isLogin ) {
        [self.view addSubview:self.loginView];
        [self setLoginViewKVO];
        [self bindViewAction];

    }else {
        [self.view addSubview:self.tableView];
        
    }
}
- (void)bindViewAction {
    [self.loginView.logPwdField addTarget:self action:@selector(pwdChange:) forControlEvents:UIControlEventEditingChanged];
    [self.loginView.logUserField addTarget:self action:@selector(userChange:) forControlEvents:UIControlEventEditingChanged];
    [self.loginView.loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
}
- (void)userChange:(UITextField *)userField{
    //    UITextField *field = userField;
    self.loginViewModel.user = userField.text;
}
- (void)pwdChange:(UITextField *)sender {
    self.loginViewModel.pwd = sender.text;
}

/// 点击登陆
- (void)loginAction {
    [SVProgressHUD showWithStatus:@"Logining..."];
    [self.loginView.loginBtn setEnabled:NO];
    [self.loginViewModel goLogInSuccess:^(id headerModel) {
        NSLog(@"登录成功 ");
        //        self.headerViewModel = (ZYProfileHeaderViewModel*)headerModel;
        //        self.loginView.hidden = true;
        //        [self.tableView reloadData];
        //
        self.headerView.viewModel = headerModel;
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:1 animations:^{
                self.loginView.alpha = 0.0;
            }];
//            self.loginView.hidden = true;
//            [self.view sendSubviewToBack:self.loginView];
            [self.loginView removeFromSuperview];
//            self.loginView = nil;
            [self setupSubView];
        });
        
    } fail:^(id error) {
        NSLog(@"登录失败 %@",error);
    }];
}
// 退出
- (void)logout{
    [ZYUserTool.shareInstance removeUser];
    [self.tableView removeFromSuperview];
//    self.tableView = nil;
    [self setupSubView];
}
- (void)setLoginViewKVO {
    
    [self.loginViewModel addObserver:self forKeyPath:@"isEnable" options:NSKeyValueObservingOptionNew context:nil];
    [self.loginViewModel addObserver:self forKeyPath:@"isLogging" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"isEnable"]) {
//        NSLog(@"change %@",change);
        
        //        Boolean isEnable = (Boolean)[change valueForKey:@"new"];
        //        NSLog(@"isEnable %d",[change  );
        NSNumber *num = [change objectForKey:@"new"];
        if ([num boolValue]) {
            NSLog(@"it's true");
        }
        
        [self.loginView.loginBtn setEnabled: [num boolValue]];
        
    }
    if ([keyPath isEqualToString:@"isLogging"]) {
        NSNumber *isLogging = [change objectForKey:@"new"];
        if (isLogging.intValue == 0) {
            [SVProgressHUD dismiss];
        }
    }
}

// MARK: lazy
- (ZYLogViewModel *)loginViewModel {
    if (!_loginViewModel) {
      _loginViewModel = [[ZYLogViewModel alloc]init];
    }
    
    return _loginViewModel;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        UITableView *view = [[UITableView alloc]init];
        _tableView = view;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor redColor];
        _tableView.frame = self.view.bounds;
        _tableView.tableHeaderView = self.headerView;
        return _tableView;
    }
    return _tableView;
}

- (ZYLoginView *)loginView {
    if (!_loginView) {
        _loginView = [[NSBundle mainBundle]loadNibNamed:@"ZYLoginView" owner:self options:nil].firstObject;
        _loginView.frame = self.view.bounds;
        _loginView.logUserField.text = @"18565302545";
        _loginView.logPwdField.text = @"123456";
    }
    return _loginView;
}

- (ZYProfileHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[NSBundle mainBundle]loadNibNamed:@"ZYProfileHeaderView" owner:self options:nil].firstObject;
        _headerView.frame = CGRectMake(0, 0, self.view.width, 100);
        _headerView.backgroundColor = [UIColor greenColor];
        self.headerViewModel = [[ZYProfileHeaderViewModel alloc]initWithUser:ZYUserTool.shareInstance.getUser];
        _headerView.viewModel = self.headerViewModel;

    }
    return _headerView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 7;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行", indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor yellowColor];
        return view;
    }else {
        return [[UIView alloc]init];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self logout];
}


/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
