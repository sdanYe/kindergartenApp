//
//  ClassNewsDomain.h
//  kindergartenApp
//
//  Created by yangyangxun on 15/7/22.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassNewsDomain : NSObject

@property (strong, nonatomic) NSString * cuuid;      //Id

@property (strong, nonatomic) NSString * classuuid;  //关联班级id.需要转换成班级名

@property (strong, nonatomic) NSString * title;      //标题

@property (strong, nonatomic) NSString * content;    //内容

@property (strong, nonatomic) NSString * create_user;      //创建人名

@property (strong, nonatomic) NSString * create_useruuid;  //创建人uuid

@property (strong, nonatomic) NSString * create_time;  //创建时间

@property (strong, nonatomic) NSString * reply_time;   //最新回复时间

@property (strong, nonatomic) NSString * update_time;  //最新更新时间


@end
