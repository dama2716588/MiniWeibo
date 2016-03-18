//
//  LoginInterfaceController.m
//  MiniWeibo
//
//  Created by pandora on 3/18/16.
//  Copyright © 2016 pandora. All rights reserved.
//

#import "LoginInterfaceController.h"

@interface LoginInterfaceController ()

@end

@implementation LoginInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)returnBtnTouch
{
    [self popController];
}

@end



