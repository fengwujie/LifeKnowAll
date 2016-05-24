//
//  UIWindow+Extension.m
//  BGWeiBo
//
//  Created by fengwujie on 15/9/22.
//  Copyright © 2015年 BG. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "BGTabBarViewController.h"
#import "BGNewfeatureViewController.h"

@implementation UIWindow (Extension)

- (void)switchRootViewController{
    
    // 切换窗口的根控制器
    NSString *key = @"CFBundleVersion";
    // 上一次的使用版本（存在沙盒中的版本号）
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    // 当前软件的版本号（从Info.plist中获得）
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    if ([currentVersion isEqualToString:lastVersion]) {  //版本相同，则直接进入主界面
        self.rootViewController = [[BGTabBarViewController alloc] init];
    }
    else  //版本不一样，则显示 新特性
    {
        self.rootViewController = [[BGNewfeatureViewController alloc] init];
        
        // 将当前版本号存入在沙盒中
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
