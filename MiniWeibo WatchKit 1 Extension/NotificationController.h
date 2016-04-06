//
//  NotificationController.h
//  MiniWeibo WatchKit 1 Extension
//
//  Created by pandora on 3/14/16.
//  Copyright © 2016 pandora. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface NotificationController : WKUserNotificationInterfaceController

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *dyAlertLabel;

@end
