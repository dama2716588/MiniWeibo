//
//  IndexViewController.m
//  MiniWeibo
//
//  Created by pandora on 3/14/16.
//  Copyright © 2016 pandora. All rights reserved.
//

#import "IndexViewController.h"
#import "AuthViewController.h"

@interface IndexViewController ()

@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Index";
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setTitle:@"Login Weibo" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginWeibo:) forControlEvents:UIControlEventTouchUpInside];
    [loginButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    loginButton.frame = CGRectMake(0, 0, 100, 40);
    loginButton.center = self.view.center;
    [self.view addSubview:loginButton];
}

- (void)loginWeibo:(id)sender
{
    AuthViewController *authVC = [[AuthViewController alloc] init];
    [self.navigationController pushViewController:authVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
