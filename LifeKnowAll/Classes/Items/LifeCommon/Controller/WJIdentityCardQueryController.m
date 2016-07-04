//
//  WJIdentityCardQueryController.m
//  LifeKnowAll
//
//  Created by allen on 16/5/22.
//  Copyright © 2016年 allen. All rights reserved.
//

#import "WJIdentityCardQueryController.h"
#import "AFNetworking.h"
#import "WJIdentityCardQueryModel.h"
#import "WJIdentityCardQueryReturnModel.h"
#import "MJExtension.h"
#import "KVNProgress.h"

@interface WJIdentityCardQueryController ()<UITextFieldDelegate>
/**
 *  身份证号
 */
@property (weak, nonatomic) IBOutlet UITextField *txtcardno;
/**
 *  查询事件
 *
 *  @param sender <#sender description#>
 */
- (IBAction)btnQueryClick:(id)sender;
/**
 *  所属地区
 */
@property (weak, nonatomic) IBOutlet UILabel *labarea;
/**
 *  生日
 */
@property (weak, nonatomic) IBOutlet UILabel *labbirthday;
/**
 *  性别
 */
@property (weak, nonatomic) IBOutlet UILabel *labsex;

@property (weak, nonatomic) IBOutlet UIView *viewError;
@property (weak, nonatomic) IBOutlet UIView *viewResult;
@property (weak, nonatomic) IBOutlet UILabel *labError;
@end

@implementation WJIdentityCardQueryController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.viewResult.hidden = YES;
    self.viewError.hidden = YES;
    self.txtcardno.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self btnQueryClick:nil];
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnQueryClick:(id)sender {
    
    [self.txtcardno resignFirstResponder];
    
    [KVNProgress showWithStatus:@"正在获取数据，请稍等..."];
    // 初始化Manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 不加上这句话，会报“Request failed: unacceptable content-type: text/plain”错误，因为我们要获取text/plain类型数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // Get请求
    NSString *strURL = [NSString stringWithFormat:@"http://apicloud.mob.com/idcard/query?key=%@&cardno=%@",appKey,self.txtcardno.text];
    [manager GET:strURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        // 这里可以获取到目前的数据请求的进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        WJLog(@"responseObject:%@", responseObject);
        //        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        //        NSLog(@"dic:%@", dic);
        
        // 请求成功，解析数据
        WJIdentityCardQueryModel *identityCardQueryModel = [WJIdentityCardQueryModel mj_objectWithKeyValues:responseObject];
        //        WJLog(@"WJNumberLocationModel:%@", numberLocationModel);
        //        WJLog(@"WJNumberLocationResultModel:%@", numberLocationModel.result);
        if ([identityCardQueryModel.retCode isEqualToString:@"200"]) {
            self.viewError.hidden = YES;
            self.viewResult.hidden = NO;
            self.labarea.text = identityCardQueryModel.result.area;
            self.labbirthday.text = identityCardQueryModel.result.birthday;
            self.labsex.text = identityCardQueryModel.result.sex;
        }
        else
        {
            self.viewResult.hidden = YES;
            self.viewError.hidden = NO;
            self.labError.text = [NSString stringWithFormat:@"%@%@",identityCardQueryModel.retCode,identityCardQueryModel.msg];
        }
        [KVNProgress dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        WJLog(@"%@", [error localizedDescription]);
        self.viewResult.hidden = YES;
        self.viewError.hidden = NO;
        self.labError.text = @"请求网络失败，请检查网络是否正常！";
        [KVNProgress dismiss];
    }];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.txtcardno resignFirstResponder];
}
@end
