//
//  WJWeatherForecastController.m
//  LifeKnowAll
//
//  Created by allen on 16/7/4.
//  Copyright © 2016年 allen. All rights reserved.
//

#import "WJWeatherForecastController.h"
#import <CoreLocation/CoreLocation.h>
#import "AFNetworking.h"
#import "KVNProgress.h"

@interface WJWeatherForecastController ()<CLLocationManagerDelegate>

@property(strong, nonatomic) CLLocationManager *locationManager;

@property (nonatomic, copy) NSString *currentCity;

@end

@implementation WJWeatherForecastController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self locate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 开始定位
- (void)locate {
    self.currentCity = [[NSString alloc] init];
    // 判断是否开启定位
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        [self.locationManager startUpdatingLocation];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法进行定位" message:@"请检查您的设备是否开启定位功能" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

#pragma mark - CoreLocation Delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    CLLocation *newLocation = [locations lastObject];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    // 反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (! error) {
            if ([placemarks count] > 0) {
                CLPlacemark *placemark = [placemarks firstObject];
                
                // 获取城市
                NSString *city = placemark.locality;
                if (! city) {
                    // 6
                    city = placemark.administrativeArea;
                    WJLog(@"定位城市：%@", city);
                }
                
                self.currentCity = city;
            } else if ([placemarks count] == 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"GPS故障" message:@"定位城市失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络错误" message:@"请检查您的网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
    [self.locationManager stopUpdatingLocation];
    
    /*
    CLLocation *currentLocation = [locations lastObject]; // 最后一个值为最新位置
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    // 根据经纬度反向得出位置城市信息
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            self.currentCity = placeMark.locality;
            // ? placeMark.locality : placeMark.administrativeArea;
            if (!self.currentCity) {
                self.currentCity = NSLocalizedString(@home_cannot_locate_city, comment:@无法定位当前城市);
            }
            // 获取城市信息后, 异步更新界面信息.      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                self.cityDict[@*] = @[self.currentCity];
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
            });
        });
    } else if (error == nil && placemarks.count == 0) {
        NSLog(@No location and error returned);
    } else if (error) {
        NSLog(@Location error: %@, error);
    }
     }];
    
    [manager stopUpdatingLocation];
     */
}


-(void)getCategoryInfoFoodModel
{
    /*
    [KVNProgress showWithStatus:@"正在获取数据，请稍等..."];
    // 初始化Manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 不加上这句话，会报“Request failed: unacceptable content-type: text/plain”错误，因为我们要获取text/plain类型数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // Get请求
    NSString *strURL = @"http://apicloud.mob.com/v1/weather/query";
    NSMutableDictionary *dicParameters = [NSMutableDictionary dictionary];
    [dicParameters setObject:appKey forKey:@"key"];
    [dicParameters setObject:self.currentCity forKey:@"city"];
    [manager GET:strURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        // 这里可以获取到目前的数据请求的进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        WJLog(@"responseObject:%@", responseObject);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSLog(@"dic:%@", dic);
        
        // 请求成功，解析数据
        WJAllCategoryInfoModel *allCategoryInfoModel = [WJAllCategoryInfoModel mj_objectWithKeyValues:responseObject];
        WJLog(@"allCategoryInfoModel:%@", allCategoryInfoModel);
        WJLog(@"allCategoryInfoModel:%@", allCategoryInfoModel.result);
        [KVNProgress dismiss];
        if ([allCategoryInfoModel.retCode isEqualToString:@"200"]) {
            [self allCategoryInfoModelToNodes:allCategoryInfoModel];
        }
        else
        {
            NSString *strError = [NSString stringWithFormat:@"%@%@", allCategoryInfoModel.retCode,allCategoryInfoModel.msg];
            WJLog(@"%@", strError);
            [KVNProgress showErrorWithStatus:strError];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [KVNProgress dismiss];
        // 请求失败
        WJLog(@"%@", [error localizedDescription]);
        [KVNProgress showErrorWithStatus:[error localizedDescription]];
    }];
     */
}
@end
