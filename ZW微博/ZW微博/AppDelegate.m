//
//  AppDelegate.m
//  ZW微博
//
//  Created by rayootech on 15/11/1.
//  Copyright © 2015年 rayootech. All rights reserved.
//

#import "AppDelegate.h"
#import "ZWMainTabBarController.h"
#import "ZWNewFeatureController.h"
#import "ZWAuthorViewController.h"
#import "ZWAccountTool.h"
#import "ZWAuthorViewController.h"

#import "UIImageView+WebCache.h"
#import <AVFoundation/AVFoundation.h>
@interface AppDelegate ()
{
    AVAudioPlayer *_player;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //注册通知
    UIUserNotificationSettings *setting=[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [application registerUserNotificationSettings:setting];
    
    //在真机后台播放，设置音频会话
    AVAudioSession *session=[AVAudioSession sharedInstance];
    
    //设置回话类型
//    AVAudioSessionCategoryAmbient   混合播放，会把后台播放的音乐混合起来播放
//    AVAudioSessionCategorySoloAmbient   进入后台，先把之前的后台音乐停止，再播放自己的
//    AVAudioSessionCategoryPlayback   进入后台的时候播放音乐
    
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    //激活
    [session setActive:YES error:nil];
    
    //创建窗口
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor=[UIColor whiteColor];
    
    // 2.设置根控制器
    ZWAccount *account = [ZWAccountTool account];
    if (account) { // 之前已经登录成功过
        [self.window switchRootViewController];
    } else {
        self.window.rootViewController = [[ZWAuthorViewController alloc] init];
    }

    [self.window makeKeyAndVisible];
    
    return YES;
}

-(void)chooseRootController{
    //获取当前版本号
    NSString *currentVersion=[NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    
    //获取上一次的版本号
    NSString *lastVersion=[[NSUserDefaults standardUserDefaults]objectForKey:ZWVersionKey];
    
    //判断当前是否有新的版本
    if ([currentVersion isEqualToString:lastVersion]) {
        //没有新版本
        //创建TabBarVC
        ZWMainTabBarController *tabVC=[[ZWMainTabBarController alloc]init];
        
        self.window.rootViewController=tabVC;
        
    }else{
        
        //有新版本
        //如果有新特性，进入新特性界面
        ZWNewFeatureController *newFeatureVC=[[ZWNewFeatureController alloc]init];
        self.window.rootViewController=newFeatureVC;
        
        //保持当前版本
        [[NSUserDefaults standardUserDefaults]setObject:currentVersion forKey:ZWVersionKey];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}

#pragma mark-接收到内存警告的时候调用
-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{

    //停止所有下载
    [[SDWebImageManager sharedManager]cancelAll];
    
    //删除缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}

//即将失去焦点的时候调用
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    //后台播放音频
    NSURL *url=[[NSBundle mainBundle] URLForResource:@"xx" withExtension:@"mp3"];
    AVAudioPlayer *player=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    [player prepareToPlay];
    player.numberOfLoops=-1;//无限次播放
    [player play];
    _player=player;
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    //应用进入后台,开启一个后台任务,时间不确定，优先级比较低，假如系统要关闭应用，首先就考虑
    UIBackgroundTaskIdentifier ID=[application beginBackgroundTaskWithExpirationHandler:^{
        //当后台任务结束的时候调用
        [application endBackgroundTask:ID];
        
    }];
    
    //如何提高后台任务的优先级，欺骗苹果
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
