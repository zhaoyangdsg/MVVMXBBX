//
//  ZYPersonInsController.m
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/7/12.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYPersonInsController.h"
#import "ZYHomeHttpTool.h"
#import "ZYProductItem.h"
#import "ZYPersonInsCtrlViewModel.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "ZYHomePdtCell.h"
#import "ZYHomePdtCellViewModel.h"

@interface ZYPersonInsController ()
@property (nonatomic,strong)ZYPersonInsCtrlViewModel *viewModel;
@property (nonatomic,assign)int totalCount;
@end

@implementation ZYPersonInsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.insType) {
        self.insType = ZYPersonInsType_GN;
    }
//    self.view.backgroundColor = UIColor.blueColor;
    [self bindViewModel];
}

- (void)bindViewModel {
    
    
    
    [SVProgressHUD show];
    ZYPersonInsCtrlViewModel *vm = [[ZYPersonInsCtrlViewModel alloc]initWithType:self.insType];
    self.viewModel = vm;
    
    RAC(self,totalCount) = RACObserve(vm, total);
    // 加载数据
    @weakify(self)
    [vm.loadDataCommand.executionSignals.switchToLatest subscribeNext:^(id  x) {
        @strongify(self)
        [SVProgressHUD dismiss];
        [self.tableView reloadData];
       
    } error:^(NSError * _Nullable error) {
        [SVProgressHUD showErrorWithStatus:error.domain];
        [SVProgressHUD dismissWithDelay:2];
    }];
    [vm.loadDataCommand execute:nil];
    //    [[[vm.loadDataCommand  execute:nil ] subscribeError:^(NSError * error) {
    //
    //    } deliverOnMainThread] subscribeCompleted:^{
    //        @strongify(self)
    //        [self.tableView reloadData];
    //    } ]  ;
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

    return self.viewModel.pdtVMArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZYHomePdtCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    if (!cell) {
        cell = [[ZYHomePdtCell alloc]init];
        [cell bindViewModel:self.viewModel.pdtVMArray[indexPath.row]];
    }
    
    return cell;
}


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
