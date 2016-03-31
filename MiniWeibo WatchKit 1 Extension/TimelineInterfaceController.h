//
//  TimelineInterfaceController.h
//  MiniWeibo
//
//  Created by pandora on 3/18/16.
//  Copyright © 2016 pandora. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface TimelineInterfaceController : WKInterfaceController

@property (weak, nonatomic) IBOutlet WKInterfaceTable *table;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *getNewBtn;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *getMoreBtn;

- (IBAction)getNew;
- (IBAction)getMore;

@end
