//
//  WBUserModel.h
//  MiniWeibo
//
//  Created by pandora on 3/17/16.
//  Copyright © 2016 pandora. All rights reserved.
//

#import "BaseModel.h"

@interface WBUserModel : BaseModel

@property(nonatomic,copy) NSString *screen_name;
@property(nonatomic,copy) NSString *profile_image_url;

@end
