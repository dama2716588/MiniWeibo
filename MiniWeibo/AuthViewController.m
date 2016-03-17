//
//  AuthViewController.m
//  MiniWeibo
//
//  Created by pandora on 3/15/16.
//  Copyright © 2016 pandora. All rights reserved.
//

#import "AuthViewController.h"
#import "AFNetworking.h"
#import "WBAuthInfo.h"
#import "WBAuthInfoTool.h"

#define WB_Auth_URL @"https://api.weibo.com/oauth2/authorize"
#define WBAppKey @"2503413329" //新浪提供的AppKey
#define WBRedirectURL @"https://www.baidu.com"//回调地址
#define WBAppSecret @"91fc93f53e53e5d33b632376802332d1"//新浪提供的APPSecret

@interface AuthViewController () <UIWebViewDelegate>

{
    UIWebView *_webView;
}

@end

@implementation AuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Login";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initWebView];
}

- (void)initWebView
{
    NSString*str = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@&response_type=code&display=mobile&state=authoriz",WB_Auth_URL,WBAppKey,WBRedirectURL];
    NSURL*url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    _webView = [[UIWebView alloc] init];
    _webView.frame = self.view.frame;
    _webView.delegate = self;
    [self.view addSubview:_webView];
    [_webView loadRequest:request];
}

-(void)accessTokenWithRequestToken:(NSString*)requestToken
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 告诉AFN可以接收 text/plain这种类型的返回数据
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    //参数字典
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"client_id"] = WBAppKey;
    dict[@"client_secret"] = WBAppSecret;
    dict[@"grant_type"] = @"authorization_code";
    dict[@"code"] = requestToken;
    dict[@"redirect_uri"] = WBRedirectURL;
    
    NSString*urlString = @"https://api.weibo.com/oauth2/access_token";
    
    [manager POST:urlString parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        WBAuthInfo *info = [[WBAuthInfo alloc] initWithDictionary:responseObject];
        if ([WBAuthInfoTool saveInfoWith:info]) {
            NSLog(@"save success");
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
    }];
}

#pragma mark - UIWebViewDelegate

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString*urlString = request.URL.absoluteString;
    NSRange range = [urlString rangeOfString:@"code="];
    if (range.length != 0) {
        NSInteger index = range.location + range.length;
        NSString*requestToken = [urlString substringFromIndex:index];
        [self accessTokenWithRequestToken:requestToken];
        return NO;
    }
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{}
- (void)webViewDidFinishLoad:(UIWebView *)webView{}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
