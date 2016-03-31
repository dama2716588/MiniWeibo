//
//  DetailInterfaceController.m
//  MiniWeibo
//
//  Created by pandora on 3/31/16.
//  Copyright © 2016 pandora. All rights reserved.
//

#import "DetailInterfaceController.h"
#import "WBCellModel.h"

@interface DetailInterfaceController ()

@property (nonatomic, strong) WBCellModel *cellModel;

@end

@implementation DetailInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    self.cellModel = context;
    [self setUpDetail];
}

- (void)setUpDetail
{
    [self setTitle:self.cellModel.user.screen_name];
    [self.textLabel setText:self.cellModel.text];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



