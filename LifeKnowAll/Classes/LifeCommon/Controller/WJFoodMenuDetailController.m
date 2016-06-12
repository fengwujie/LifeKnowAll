//
//  WJFoodMenuDetailController.m
//  LifeKnowAll
//
//  Created by allen on 16/6/12.
//  Copyright © 2016年 allen. All rights reserved.
//

#import "WJFoodMenuDetailController.h"
#import "Masonry.h"

@interface WJFoodMenuDetailController ()

@end

@implementation WJFoodMenuDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  初始化UI控件
 */
- (void) setup{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.view.size);
        [make.center isEqual:self.view];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
