//
//  ZWAuthorViewController.m
//  ZW微博
//
//  Created by rayootech on 15/12/13.
//  Copyright © 2015年 rayootech. All rights reserved.
//

#import "ZWAuthorViewController.h"
#import "zwAccountTool.h"
//#import "ZWAccount.h"

@interface ZWAuthorViewController ()<UIWebViewDelegate>

@end

@implementation ZWAuthorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //展示登录的网页->webview
    UIWebView *webView=[[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:webView];

    //拼接url+参数
    NSString *baseUrl=ZZWAuthorizeBaseUrl;
    NSString *client_id=ZWClient_id;
    NSString *redirect_uri=ZWRedirect_uri;
    
    NSString *urlStr=[NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",baseUrl,client_id,redirect_uri];
    //创建URL
    NSURL *url=[NSURL URLWithString:urlStr];
    
    //创建请求
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    // 加载请求
    [webView loadRequest:request];
    
    //设置代理
    webView.delegate=self;
}

#pragma mark-delegate
-(void)webViewDidStartLoad:(UIWebView *)webView{

    //提示用户正在加载
    [MBProgressHUD showMessage:@"正在加载..."];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{

    [MBProgressHUD hideHUD];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{

    [MBProgressHUD hideHUD];
    
}

//拦截webView请求
//当webview需要加载一个请求的适合，就会调用这个方法，
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    NSString *urlStr=request.URL.absoluteString;
    
    //获取code（RequestToken）
    NSRange range=[urlStr rangeOfString:@"code="];
    if (range.length)
    {
        //有code
        NSString *code=[urlStr substringFromIndex:range.location+range.length];
        //换取accessToken
        [self accessToKenWithCode:code];
        
        return NO;
    }
    
    return  YES;
}

#pragma mark-换取accessToken
-(void)accessToKenWithCode:(NSString *)code{

    [ZWAccountTool accountWithCode:code success:^{
        NSLog(@"成功");
        [MBProgressHUD hideHUD];
        // 切换窗口的根控制器
        UIWindow *window = ZWKeyWindow;
        [window switchRootViewController];
    } failure:^(NSError *error) {
        
    }];
    
    //发送post请求
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
