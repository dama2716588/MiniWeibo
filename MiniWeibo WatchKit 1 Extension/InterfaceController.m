//
//  InterfaceController.m
//  MiniWeibo WatchKit 1 Extension
//
//  Created by pandora on 3/14/16.
//  Copyright © 2016 pandora. All rights reserved.
//

#import "InterfaceController.h"
#import "WBParametersRequestInfo.h"
#import "WBCellModel.h"
#import "WBDataManager.h"
#import "WBAuthInfoTool.h"
#import "MJExtension.h"

@interface InterfaceController()

@end


@implementation InterfaceController

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

- (IBAction)loadBtnTouch
{
    NSLog(@"start loading weibo");
    
    [[WBDataManager sharedInstance] clearWeiboCache];
    
    // 初始化 WBParametersRequestInfo
    NSDictionary *requestInfo = @{@"since_id":@"",@"max_id":@"",@"access_token":@""};
    WBParametersRequestInfo *parameters = [[WBParametersRequestInfo alloc] initWithDictionary:requestInfo];
    
    if (parameters.access_token.length == 0) {
        [self pushControllerWithName:@"notLogin" context:nil];
        NSLog(@"not login, return");
        return;
    }

    NSDictionary*userInfo = [parameters dic];
    [WKInterfaceController openParentApplication:userInfo reply:^(NSDictionary *replyInfo, NSError *error) {
        if ([[replyInfo objectForKey:@"code"]isEqualToString:@"0000"]) {
            NSArray*newModels = [[WBDataManager sharedInstance] getAllWeibo];
            [self pushControllerWithName:@"timeline" context:newModels];
        }
    }];
}

@end



