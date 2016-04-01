//
//  TimelineInterfaceController.m
//  MiniWeibo
//
//  Created by pandora on 3/18/16.
//  Copyright © 2016 pandora. All rights reserved.
//

#import "TimelineInterfaceController.h"
#import "TimelineTableRow.h"
#import "WBCellModel.h"
#import "WBParametersRequestInfo.h"
#import "WBDataManager.h"
#import "WBAuthInfoTool.h"
#import "MJExtension.h"

@interface TimelineInterfaceController ()

@property(nonatomic,strong) NSMutableArray *weiboArray;
@property(nonatomic,strong) NSOperationQueue *q;

@end

@implementation TimelineInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    self.weiboArray = context;
    _q = [[NSOperationQueue alloc] init];
    [self reloadData];
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

- (void)reloadData
{
    [self clearTableRows];

    [self.table insertRowsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [self.weiboArray count])] withRowType:@"TimelineTableRow"];
    __block CGFloat cellAlpha = 1.0f;
    __weak TimelineInterfaceController *weakSelf = self;
    
    [self.weiboArray enumerateObjectsUsingBlock:^(NSDictionary *cellDic, NSUInteger idx, BOOL *stop) {
        
        WBCellModel *cellModel = [WBCellModel mj_objectWithKeyValues:cellDic];
        
        TimelineTableRow *row = (TimelineTableRow*)[self.table rowControllerAtIndex:idx];
        [row.userGroup setCornerRadius:0.0f];
        [row.userGroup setAlpha:cellAlpha];
        [row.iconGroup setCornerRadius:15.0f];
        
        if (cellModel.user.profile_image_url.length>0 && cellModel.user.screen_name.length>0) {
            [weakSelf.q addOperationWithBlock:^{
                NSData*imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:cellModel.user.profile_image_url]];
                BOOL ceched = [[WKInterfaceDevice currentDevice]addCachedImageWithData:imgData name:cellModel.user.screen_name];
                if (ceched) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        [row.userIcon setImageNamed:cellModel.user.screen_name];
                    }];
                }
            }];
            
            [row.userName setText:cellModel.user.screen_name];
        }
        
        [row.firstTextGroup setBackgroundColor:[UIColor darkGrayColor]];
        [row.firstTextGroup setCornerRadius:4.0f];
        [row.firstTextGroup setAlpha:1.0];
        NSString *text = cellModel.text;
        NSString *firstText = [text substringToIndex:1];
        
        [row.firstTextLabel setText:firstText];
    }];
}

- (void)clearTableRows
{
    [self.table removeRowsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [self.table numberOfRows])]];
}

- (void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex
{
    WBCellModel *cellModel = [self.weiboArray objectAtIndex:rowIndex];
    [self pushControllerWithName:@"weiboDetail" context:cellModel];
}

- (IBAction)getNew
{
    NSString *accessToken = [WBAuthInfoTool authInfo].access_token;
    NSDictionary *requestInfo = @{@"since_id":@"",@"max_id":@"",@"access_token":accessToken};
    WBParametersRequestInfo *info = [[WBParametersRequestInfo alloc] initWithDictionary:requestInfo];
    WBCellModel *firstWeibo = [WBCellModel mj_objectWithKeyValues:self.weiboArray.firstObject];
    info.since_id = firstWeibo.idstr;
    
    NSDictionary*userInfo = [info dic];
    [WKInterfaceController openParentApplication:userInfo reply:^(NSDictionary *replyInfo, NSError *error) {
        NSLog(@"replyInfo : %@",replyInfo);
        if ([[replyInfo objectForKey:@"code"]isEqualToString:@"0000"]) {

            NSArray *newModels = [replyInfo objectForKey:@"replyData"];
            NSMutableArray *newWeibos = [NSMutableArray array];
            
            if (newModels.count == 0) {
                NSLog(@"没有新微博");
                return;
            }
            
            for (NSDictionary *dic in newModels) {
                WBCellModel *model = [WBCellModel mj_objectWithKeyValues:dic];
                [newWeibos addObject:model];
            }
            
            NSRange range = NSMakeRange(0, newWeibos.count);
            NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
            [self.weiboArray insertObjects:newWeibos atIndexes:set];
            [self reloadData];
        }
    }];    
}

- (IBAction)getMore
{
    NSString *accessToken = [WBAuthInfoTool authInfo].access_token;
    NSDictionary *requestInfo = @{@"since_id":@"",@"max_id":@"",@"access_token":accessToken};
    WBParametersRequestInfo *info = [[WBParametersRequestInfo alloc] initWithDictionary:requestInfo];
    info.since_id = [[self.weiboArray lastObject]idstr];
    
    NSDictionary*userInfo = [info dic];
    [WKInterfaceController openParentApplication:userInfo reply:^(NSDictionary *replyInfo, NSError *error) {
        NSLog(@"replyInfo : %@",replyInfo);
        if ([[replyInfo objectForKey:@"code"]isEqualToString:@"0000"]) {
            
            NSArray*newModels = [[WBDataManager sharedInstance] getAllWeibo];
            
            if (newModels.count == 0) {
                NSLog(@"没有更多微博");
                return;
            }
            
            [self.weiboArray addObjectsFromArray:newModels];
            [self reloadData];
        }
    }];
}

@end



