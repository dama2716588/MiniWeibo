//
//  WBHttpTool.h
//  MiniWeibo
//
//  Created by pandora on 3/18/16.
//  Copyright © 2016 pandora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBParametersRequestInfo.h"

@interface WBHttpTool : NSObject

+ (void)weiboWithParameters:(WBParametersRequestInfo *)parameters
          statusToolSuccess:(void (^)(id responseObject))success
                    failure:(void(^)(NSError*error))failure;

@end
