//
//  WJIPAddressController.m
//  LifeKnowAll
//
//  Created by allen on 16/5/23.
//  Copyright © 2016年 allen. All rights reserved.
//

#import "WJIPAddressController.h"
#import "AFNetworking.h"
#import "KVNProgress.h"
#import "MJExtension.h"
#import "WJIPAddressModel.h"
#import "WJIPAddressReturnModel.h"

@interface WJIPAddressController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtIP;

- (IBAction)btnQueryClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewResult;

@property (weak, nonatomic) IBOutlet UILabel *labIP;

@property (weak, nonatomic) IBOutlet UILabel *labCountry;

@property (weak, nonatomic) IBOutlet UILabel *labProvince;

@property (weak, nonatomic) IBOutlet UILabel *labCity;

@property (weak, nonatomic) IBOutlet UIView *viewError;

@property (weak, nonatomic) IBOutlet UILabel *labError;


@end

@implementation WJIPAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.txtIP.delegate = self;
    self.viewResult.hidden = YES;
    self.viewError.hidden = YES;
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
    [self.txtIP resignFirstResponder];
    [KVNProgress showWithStatus:@"正在获取数据，请稍等..."];
    // 初始化Manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 不加上这句话，会报“Request failed: unacceptable content-type: text/plain”错误，因为我们要获取text/plain类型数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // Get请求
    NSString *strURL = [NSString stringWithFormat:@"http://apicloud.mob.com/ip/query?key=%@&ip=%@",appKey,self.txtIP.text];
    [manager GET:strURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        // 这里可以获取到目前的数据请求的进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        WJLog(@"responseObject:%@", responseObject);
        //        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        //        NSLog(@"dic:%@", dic);
        
        // 请求成功，解析数据
        WJIPAddressModel *ipAddressModel = [WJIPAddressModel mj_objectWithKeyValues:responseObject];
        //        WJLog(@"WJNumberLocationModel:%@", numberLocationModel);
        //        WJLog(@"WJNumberLocationResultModel:%@", numberLocationModel.result);
        if ([ipAddressModel.retCode isEqualToString:@"200"]) {
            self.viewError.hidden = YES;
            self.viewResult.hidden = NO;
            self.labIP.text = ipAddressModel.result.ip;
            self.labCountry.text = ipAddressModel.result.country;
            self.labProvince.text = ipAddressModel.result.province;
            self.labCity.text = ipAddressModel.result.city;
        }
        else
        {
            self.viewResult.hidden = YES;
            self.viewError.hidden = NO;
            self.labError.text = [NSString stringWithFormat:@"%@%@",ipAddressModel.retCode,ipAddressModel.msg];
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
    [self.txtIP resignFirstResponder];
}

@end
