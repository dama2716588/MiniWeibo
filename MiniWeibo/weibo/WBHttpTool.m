//
//  WBHttpTool.m
//  MiniWeibo
//
//  Created by pandora on 3/18/16.
//  Copyright © 2016 pandora. All rights reserved.
//

#import "WBHttpTool.h"
#import "AFNetworking.h"

@implementation WBHttpTool

+ (void)weiboWithParameters:(WBParametersRequestInfo *)parameters
          statusToolSuccess:(void (^)(id responseObject))success
                    failure:(void(^)(NSError*error))failure
{
    NSString*urlString = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    __block NSDictionary*md;
    if (parameters.since_id.length>0) {
        md = @{@"access_token":parameters.access_token,@"since_id":parameters.since_id,@"count":@"10"};
    } else if (parameters.max_id.length>0){
        md = @{@"access_token":parameters.access_token,@"max_id":parameters.max_id,@"count":@"10"};
    } else {
        md = @{@"access_token":parameters.access_token,@"count":@"10"};
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlString parameters:md progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end
