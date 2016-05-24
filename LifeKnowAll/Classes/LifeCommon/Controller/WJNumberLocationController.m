//
//  WJNumberLocationController.m
//  LifeKnowAll
//
//  Created by allen on 16/5/21.
//  Copyright © 2016年 allen. All rights reserved.
//

#import "WJNumberLocationController.h"
#import "AFNetworking.h"
#import "KVNProgress.h"
#import "WJNumberLocationModel.h"
#import "WJNumberLocationResultModel.h"
#import "MJExtension.h"

@interface WJNumberLocationController ()
/**
 *  手机号码
 */
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;

/**
 *  查询事件
 */
- (IBAction)btnQueryClick:(id)sender;


/**
 *  结果View
 */
@property (weak, nonatomic) IBOutlet UIView *viewResult;
/**
 *  省份
 */
@property (weak, nonatomic) IBOutlet UILabel *labProvince;
/**
 *  城市
 */
@property (weak, nonatomic) IBOutlet UILabel *labCity;
/**
 *  城市区号
 */
@property (weak, nonatomic) IBOutlet UILabel *labCityCode;
/**
 *  邮编
 */
@property (weak, nonatomic) IBOutlet UILabel *labZipCode;
/**
 *  运营商信息
 */
@property (weak, nonatomic) IBOutlet UILabel *labOperator;

/**
 *  错误VIEW
 */
@property (weak, nonatomic) IBOutlet UIView *viewError;
/**
 *  错误信息
 */
@property (weak, nonatomic) IBOutlet UILabel *labError;
@end

@implementation WJNumberLocationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.viewResult.hidden = YES;
    self.viewError.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnQueryClick:(id)sender {
//    WJLog(@"手机号码 ：%@",self.txtPhone.text);
//    if (self.txtPhone.text == nil || self.txtPhone.text.length == 0) {
//        [KVNProgress showErrorWithStatus:@"手机号码不能为空！"];
//        return;
//    }
    [self.txtPhone resignFirstResponder];
    [KVNProgress showWithStatus:@"正在获取数据，请稍等..."];
    // 初始化Manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 不加上这句话，会报“Request failed: unacceptable content-type: text/plain”错误，因为我们要获取text/plain类型数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // Get请求
    NSString *strURL = [NSString stringWithFormat:@"http://apicloud.mob.com/v1/mobile/address/query?key=%@&phone=%@",appKey,self.txtPhone.text];
    [manager GET:strURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        // 这里可以获取到目前的数据请求的进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        WJLog(@"responseObject:%@", responseObject);
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
//        NSLog(@"dic:%@", dic);
        
        // 请求成功，解析数据
        WJNumberLocationModel *numberLocationModel = [WJNumberLocationModel mj_objectWithKeyValues:responseObject];
//        WJLog(@"WJNumberLocationModel:%@", numberLocationModel);
//        WJLog(@"WJNumberLocationResultModel:%@", numberLocationModel.result);
        if ([numberLocationModel.retCode isEqualToString:@"200"]) {
            self.viewError.hidden = YES;
            self.viewResult.hidden = NO;
            self.labProvince.text = numberLocationModel.result.province;
            self.labCity.text = numberLocationModel.result.city;
            self.labCityCode.text = numberLocationModel.result.cityCode;
            self.labZipCode.text = numberLocationModel.result.zipCode;
            self.labOperator.text = numberLocationModel.result.operatorTemp;
        }
        else
        {
            self.viewResult.hidden = YES;
            self.viewError.hidden = NO;
            self.labError.text = [NSString stringWithFormat:@"%@%@",numberLocationModel.retCode,numberLocationModel.msg];
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
    [self.txtPhone resignFirstResponder];
}
@end
