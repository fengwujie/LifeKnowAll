//
//  WJHistoryTodayController.m
//  LifeKnowAll
//
//  Created by allen on 16/6/22.
//  Copyright © 2016年 allen. All rights reserved.
//

#import "WJHistoryTodayController.h"
#import "AFNetworking.h"
#import "KVNProgress.h"
#import "MJExtension.h"
//#import "MJRefresh.h"
#import "WJHistoryTodayModel.h"
#import "WJHistoryTodayResultModel.h"

@interface WJHistoryTodayController ()
/**
 *  历史事件数组
 */
@property (nonatomic, strong) NSArray *arrayEvent;

@end

@implementation WJHistoryTodayController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self loadData];
    //self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        [self loadData];
    //}];
    
    //[self.tableView.mj_footer beginRefreshing];
    
}

- (NSArray *)arrayEvent
{
    if (_arrayEvent == nil) {
        _arrayEvent = [NSArray array];
    }
    return _arrayEvent;
}

- (void) loadData{
    
    [KVNProgress showWithStatus:@"正在获取数据，请稍等..."];
    // 初始化Manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 不加上这句话，会报“Request failed: unacceptable content-type: text/plain”错误，因为我们要获取text/plain类型数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // Get请求
    NSString *strURL = [NSString stringWithFormat:@"http://apicloud.mob.com/appstore/history/query?key=%@&day=%@",appKey, [NSDate date].dateWithMD];
    [manager GET:strURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        // 这里可以获取到目前的数据请求的进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        WJLog(@"responseObject:%@", responseObject);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSLog(@"dic:%@", dic);
        
        // 请求成功，解析数据
        WJHistoryTodayModel *historyTodayModel = [WJHistoryTodayModel mj_objectWithKeyValues:responseObject];
        WJLog(@"historyTodayModel:%@", historyTodayModel);
        WJLog(@"historyTodayModel:%@", historyTodayModel.result);
        [KVNProgress dismiss];
        if ([historyTodayModel.retCode isEqualToString:@"200"]) {
            self.arrayEvent = historyTodayModel.result;
            [self.tableView reloadData];
        }
        else
        {
            NSString *strError = [NSString stringWithFormat:@"%@%@", historyTodayModel.retCode,historyTodayModel.msg];
            WJLog(@"%@", strError);
            [KVNProgress showErrorWithStatus:strError];
        }
        //[self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [KVNProgress dismiss];
        // 请求失败
        WJLog(@"%@", [error localizedDescription]);
        //[self.tableView.mj_footer endRefreshing];
        [KVNProgress showErrorWithStatus:[error localizedDescription]];
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.arrayEvent.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"historyToday";
    // 根据标识去缓存池找cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 不写这句直接崩掉，找不到循环引用的cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    WJHistoryTodayResultModel *model = [self.arrayEvent objectAtIndex:indexPath.row];
    
    cell.textLabel.text =[NSString stringWithFormat:@"%@  %@",model.date, model.title];
    return cell;}


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
