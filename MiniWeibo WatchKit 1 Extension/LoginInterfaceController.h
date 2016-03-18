//
//  LoginInterfaceController.h
//  MiniWeibo
//
//  Created by pandora on 3/18/16.
//  Copyright © 2016 pandora. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface LoginInterfaceController : WKInterfaceController

@property (weak, nonatomic) IBOutlet WKInterfaceButton *returnBtn;

- (IBAction)returnBtnTouch;

@end
