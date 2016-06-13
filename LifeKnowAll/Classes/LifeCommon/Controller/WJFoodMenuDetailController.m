//
//  WJFoodMenuDetailController.m
//  LifeKnowAll
//
//  Created by allen on 16/6/12.
//  Copyright © 2016年 allen. All rights reserved.
//

#import "WJFoodMenuDetailController.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

@interface WJFoodMenuDetailController ()

@end

@implementation WJFoodMenuDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setup2];
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
    scrollView.backgroundColor = [UIColor yellowColor];
    // 是否支持滑动最顶端
    //    scrollView.scrollsToTop = NO;
    //scrollView.delegate = self;
    // 设置内容大小
    scrollView.contentSize = CGSizeMake(320, 460);
    // 是否反弹
    //    scrollView.bounces = NO;
    // 是否分页
    //    scrollView.pagingEnabled = YES;
    // 是否滚动
    //    scrollView.scrollEnabled = NO;
    //    scrollView.showsHorizontalScrollIndicator = NO;
    // 设置indicator风格
    //    scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    // 设置内容的边缘和Indicators边缘
    //    scrollView.contentInset = UIEdgeInsetsMake(0, 50, 50, 0);
    //    scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 50, 0, 0);
    // 提示用户,Indicators flash
    [scrollView flashScrollIndicators];
    // 是否同时运动,lock
    scrollView.directionalLockEnabled = YES;
    [self.view addSubview:scrollView];
    
//    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(self.view.size);
//        [make.center isEqual:self.view];
//    }];
    
    UIView *ctgView = [[UIView alloc] init];
    ctgView.backgroundColor = [UIColor blueColor];
    [scrollView addSubview:ctgView];
    [ctgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(scrollView.mas_left).with.offset(10);
        make.right.equalTo(scrollView.mas_right).with.offset(-10);
        make.top.equalTo(scrollView.mas_top).with.offset(70);
        make.height.equalTo(@300);
        
//        make.size.mas_equalTo(CGSizeMake(300, 300));
//        [make.center isEqual:self.view];
    }];
    
    
}

- (void)setup2{
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    UIView *container = [UIView new];
    container.backgroundColor = [UIColor yellowColor];
    [scrollView addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
    }];
    
    WJLog(@"container.frame:w=%f,h=%f,x=%f,y=%f",container.width,container.height,container.x,container.y);
    
    //大图预览
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.backgroundColor = [UIColor redColor];
    [container addSubview:imgView];
    [imgView sd_setImageWithURL:[NSURL URLWithString:self.food.recipe.img] placeholderImage:[UIImage imageNamed:@"2"] options:SDWebImageProgressiveDownload];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.right.equalTo(container);
        make.height.equalTo(@200);
//        make.left.equalTo(container.mas_left);
//        make.top.equalTo(container.mas_top);
//        make.right.equalTo(container.mas_right);
//        make.height.mas_equalTo(imgView.width);
    }];
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(imgView.mas_bottom);
    }];
    WJLog(@"container.frame:w=%f,h=%f,x=%f,y=%f",container.width,container.height,container.x,container.y);
    
//    //标签VIEW（包含一个LABLE和一个显示值LABLE）
//    UIView *ctgView = [[UIView alloc] init];
//    ctgView.backgroundColor = [UIColor blueColor];
//    [container addSubview:ctgView];
//    [ctgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.and.right.equalTo(container);
//        make.top.equalTo(imgView);
//        make.height.mas_equalTo(@50);
//    }];
    
    
    
//    int count = 10;
//    UIView *lastView = nil;
//    for ( int i = 1 ; i <= count ; ++i )
//    {
//        UIView *subv = [UIView new];
//        [container addSubview:subv];
//        subv.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 )
//                                          saturation:( arc4random() % 128 / 256.0 ) + 0.5
//                                          brightness:( arc4random() % 128 / 256.0 ) + 0.5
//                                               alpha:1];
//        
//        [subv mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.and.right.equalTo(container);
//            make.height.mas_equalTo(@(20*i));
//            
//            if ( lastView )
//            {
//                make.top.mas_equalTo(lastView.mas_bottom);
//            }
//            else
//            {
//                make.top.mas_equalTo(container.mas_top);
//            }
//        }];
//        
//        lastView = subv;
//    }
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
