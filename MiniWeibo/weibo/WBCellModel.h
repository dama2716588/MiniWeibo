//
//  WBCellModel.h
//  MiniWeibo
//
//  Created by pandora on 3/17/16.
//  Copyright © 2016 pandora. All rights reserved.
//

#import "BaseModel.h"
#import "WBUserModel.h"

@interface WBCellModel : BaseModel

@property(nonatomic,copy) NSString *text;
@property(nonatomic,strong) WBUserModel *user;
@property(nonatomic,copy) NSString *idstr;

@end
