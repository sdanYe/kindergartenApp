//
//  SystemEnum.h
//  funiiPhoneApp
//
//  Created by rockyang on 14-5-10.
//  Copyright (c) 2014年 LQ. All rights reserved.
//

#import "AppDelegate.h"

//定义配置数据类型
typedef enum {
	ConfigTypeRegion          = 1,//区域
    ConfigTypeArea            = 2,//面积
    ConfigTypeProperty        = 3,//物业类型
    ConfigTypeListPriceRange  = 4,//价格区间
    ConfigTypeRoomType        = 5,//户型
    ConfigTypeStatus          = 6,//状态
    ConfigTypeBuildUnit       = 7,//栋/单元
    ConfigTypeFloor           = 8, //楼层
    ConfigTypeOffice          = 9, //办公
    ConfigTypeBusiness        = 10,//商业
    ConfigTypeHouse           = 11 //住宅
}APPConfigType;


typedef enum {
    Topic_XYGG = 0,        //校园公告
    Topic_Announcement = 1, //老师公告
    Topic_Articles = 3,   //精品文章
    Topic_ZSJH = 4,       //招生计划
    Topic_Recipes =6,     //食谱
    Topic_JPKC = 7,       //精品课程
    Topic_YEYJS = 8,      //幼儿园介绍
    Topic_Interact = 99,  //班级互动
    Topic_HTML = 10       //html类型,直接去url地址,调用浏览器显示
} KGTopicType;
