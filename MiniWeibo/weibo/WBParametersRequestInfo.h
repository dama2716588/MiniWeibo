//
//  WBParametersRequestInfo.h
//  MiniWeibo
//
//  Created by pandora on 3/16/16.
//  Copyright © 2016 pandora. All rights reserved.
//

#import "BaseModel.h"

@interface WBParametersRequestInfo : BaseModel

@property(nonatomic,copy)NSString *since_id;
@property(nonatomic,copy)NSString *max_id;
@property(nonatomic,copy)NSString *access_token;

@end
