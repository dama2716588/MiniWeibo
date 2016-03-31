//
//  DetailInterfaceController.h
//  MiniWeibo
//
//  Created by pandora on 3/31/16.
//  Copyright © 2016 pandora. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface DetailInterfaceController : WKInterfaceController

@property (weak, nonatomic) IBOutlet WKInterfaceGroup *textGroup;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *textLabel;

@end
