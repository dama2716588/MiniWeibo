//
//  TimelineTableRow.h
//  MiniWeibo
//
//  Created by pandora on 3/31/16.
//  Copyright © 2016 pandora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchKit/WatchKit.h>

@interface TimelineTableRow : NSObject

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *userName;
@property (weak, nonatomic) IBOutlet WKInterfaceImage *userIcon;
@property (weak, nonatomic) IBOutlet WKInterfaceGroup *iconGroup;
@property (weak, nonatomic) IBOutlet WKInterfaceGroup *userGroup;
@property (weak, nonatomic) IBOutlet WKInterfaceGroup *firstTextGroup;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *firstTextLabel;
@end
