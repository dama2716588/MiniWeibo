//
//  AppDelegate.h
//  MiniWeibo
//
//  Created by pandora on 3/14/16.
//  Copyright © 2016 pandora. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndexViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UINavigationController *nav;
@property (nonatomic, strong) IndexViewController *index;

@end

