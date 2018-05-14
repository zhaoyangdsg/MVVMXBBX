//
//  ZYProfileViewController.m
//  MVVMXBBX
//
//  Created by me2 on 2018/5/9.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYProfileViewController.h"
#import "ZYLoginView.h"
#import "ZYLogViewModel.h"
#import "UIView+ZY.h"

@interface ZYProfileViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) ZYLogViewModel *logViewModel;
/** loginView */
@property (weak,nonatomic)ZYLoginView *loginView;
/** tableView */
@property (weak,nonatomic)UITableView *tableView;
@end

@implementation ZYProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self setupSubView];
    [self bindViewAction];
    [self setKVO];
    
}


- (void)setupSubView {
    Boolean isLogin = false;
    if (!isLogin) {
      ZYLoginView *loginView = [[[NSBundle mainBundle] loadNibNamed:@"ZYLoginView" owner:self options:nil] firstObject];
        
        loginView.frame = self.view.bounds;
        self.loginView = loginView;
//        loginView.log
        [self.view addSubview:loginView];
    }else {
        [self.view addSubview:self.tableView];
        self.tableView.frame = self.view.bounds;
        UIView *headerView =  [[UIView alloc]init];
        headerView.backgroundColor = [UIColor redColor];
        headerView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
        self.tableView.tableHeaderView = headerView;
        
    }
}
- (void)bindViewAction {
    [self.loginView.logPwdField addTarget:self action:@selector(pwdChange:) forControlEvents:UIControlEventEditingChanged];
    [self.loginView.logUserField addTarget:self action:@selector(userChange:) forControlEvents:UIControlEventEditingChanged];
    [self.loginView.loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
}
- (void)userChange:(UITextField *)userField{
    //    UITextField *field = userField;
    self.logViewModel.user = userField.text;
}
- (void)pwdChange:(UITextField *)sender {
    self.logViewModel.pwd = sender.text;
}
- (void)loginAction {
    
    [self.logViewModel goLogInSuccess:^(id json) {
        NSLog(@"登录成功 %@",json);
        self.loginView.hidden = true;
    } fail:^(id error) {
        NSLog(@"登录失败 %@",error);
    }];
}

- (void)setKVO {
    [self.logViewModel addObserver:self forKeyPath:@"isEnable" options:NSKeyValueObservingOptionNew context:nil];
    [self.logViewModel addObserver:self forKeyPath:@"isLogging" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"isEnable"]) {
        NSLog(@"change %@",change);
        
        //        Boolean isEnable = (Boolean)[change valueForKey:@"new"];
        //        NSLog(@"isEnable %d",[change  );
        NSNumber *num = [change objectForKey:@"new"];
        if ([num boolValue]) {
            NSLog(@"it's true");
        }
        
        [self.loginView.loginBtn setEnabled: [num boolValue]];
        
    }
}

- (ZYLogViewModel *)logViewModel {
    if (_logViewModel != nil) {
        return _logViewModel;
    }
    ZYLogViewModel * model = [[ZYLogViewModel alloc]init];
    _logViewModel = model;
    return _logViewModel;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        UITableView *view = [[UITableView alloc]init];
        _tableView = view;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        return _tableView;
    }
    return _tableView;
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
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor greenColor];
        return view;
    }else {
        return [[UIView alloc]init];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
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
