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

@interface TimelineInterfaceController ()

@property(nonatomic,strong) NSMutableArray *weiboArray;

@end

@implementation TimelineInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    self.weiboArray = context;
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
    [self.weiboArray enumerateObjectsUsingBlock:^(WBCellModel *cellModel, NSUInteger idx, BOOL *stop) {
        TimelineTableRow *row = (TimelineTableRow*)[self.table rowControllerAtIndex:idx];
        [row.userGroup setCornerRadius:0.0f];
        [row.userGroup setAlpha:cellAlpha];
        [row.iconGroup setCornerRadius:15.0f];
        
        [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
            NSData*imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:cellModel.user.profile_image_url]];
            
            [[WKInterfaceDevice currentDevice]addCachedImageWithData:imgData name:cellModel.user.screen_name];
            
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                [row.userIcon setImageNamed:cellModel.user.screen_name];
            }];
            
        }];
        
        [row.userName setText:cellModel.user.screen_name];
        
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
    
}

- (IBAction)getMore
{
    
}

@end



