//
//  WBCellModel.h
//  MiniWeibo
//
//  Created by pandora on 3/17/16.
//  Copyright © 2016 pandora. All rights reserved.
//

#import "BaseModel.h"
#import "WBUserModel.h"

@interface WBCellModel : NSObject

@property(nonatomic,copy) NSString *text;
@property(nonatomic,strong) WBUserModel *user;
@property(nonatomic,copy) NSString *idstr;

@property(nonatomic, assign) int weiboId;              //id
@property(nonatomic, copy)   NSString *mid;            //mid
@property(nonatomic, assign) int comments_count;       //评论数
@property(nonatomic, assign) int reposts_count;        //转发数
@property(nonatomic, strong) NSString *thumbnail_pic;  //小图url
@property(nonatomic, strong) NSString *bmiddle_pic;    //中图url
@property(nonatomic, strong) NSString *original_pic;   //原图url
@property(nonatomic, strong) NSArray *pic_urls;

@property(nonatomic, strong) NSString *content;
@property(nonatomic, strong) NSString *image;
@property(nonatomic, strong) NSString *image_url;
@property(nonatomic, assign) float image_height;
@property(nonatomic, assign) float image_width;
@property(nonatomic, assign) int repin_count;
@property(nonatomic, strong) NSString *short_content;
@property(nonatomic, strong) NSString *content_id;

@end
