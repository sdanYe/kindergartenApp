//
//  FuniHttpUrl.m
//  kindergartenApp
//
//  Created by You on 15/6/1.
//  Copyright (c) 2015年 funi. All rights reserved.
//

#import "KGHttpUrl.h"

#define URL(baseURL, businessURL) [NSString stringWithFormat:@"%@%@", baseURL, businessURL];

#define baseServiceURL       @"http://120.25.248.31/px-mobile/"      //正式
#define loginURL             @"rest/userinfo/login.json"             //登录
#define logoutURL            @"rest/userinfo/logout.json"            //登出
#define regURL               @"rest/userinfo/reg.json"               //注册
//#define updatepasswordURL    @"rest/userinfo/updatepassword.json"    //修改密码
#define updatepasswordURL    @"rest/userinfo/updatepasswordBySms.json"  //修改密码
#define phoneCodeURL         @"rest/sms/sendCode.json"               //短信验证码

#define classNewsMyURL           @"rest/classnews/getClassNewsByMy.json"   //我的孩子班级互动列表
#define classNewsByClassIdURL  @"rest/classnews/getClassNewsByClassuuid.json"   //班级互动列表




#define announcementListURL      @"rest/announcements/queryMyAnnouncements.json"               //公告列表
#define myChildrenURL         @"rest/student/listByMyChildren.json"               //我的孩子列表
#define saveChildrenURL       @"rest/student/save.json"                           //保存孩子


@implementation KGHttpUrl

//login
+ (NSString *)getLoginUrl {
    return URL(baseServiceURL, loginURL);
}


//logout
+ (NSString *)getLogoutUrl {
    return URL(baseServiceURL, logoutURL);
}


//reg
+ (NSString *)getRegUrl {
    return URL(baseServiceURL, regURL);
}


//updatepassword
+ (NSString *)getUpdatepasswordUrl {
    return URL(baseServiceURL, updatepasswordURL);
}


//phone code
+ (NSString *)getPhoneCodeUrl {
    return URL(baseServiceURL, phoneCodeURL);
}


//AnnouncementList
+ (NSString *)getAnnouncementListUrl {
    return URL(baseServiceURL, announcementListURL);
}


//Announcement Info
+ (NSString *)getAnnouncementInfoUrl:(NSString *)uuid {
    return [NSString stringWithFormat:@"%@rest/announcements/%@.json", baseServiceURL, uuid];
}


//MyChildren
+ (NSString *)getMyChildrenUrl {
    return URL(baseServiceURL, myChildrenURL);
}


//SaveChildren
+ (NSString *)getSaveChildrenUrl {
    return URL(baseServiceURL, saveChildrenURL);
}


//根据互动UUID获取单个互动详情
+ (NSString *)getClassNewsByIdUrl:(NSString *)uuid {
    return [NSString stringWithFormat:@"%@rest/classnews/%@.json", baseServiceURL, uuid];
}


//分页获取班级互动列表
+ (NSString *)getClassNewsByClassIdUrl {
    return URL(baseServiceURL, classNewsByClassIdURL);
}


//分页获取我的孩子相关班级互动列表
+ (NSString *)getClassNewsMyByClassIdUrl {
    return URL(baseServiceURL, classNewsMyURL);
}



//更新学生资料
+ (NSString *)getSaveStudentInfoUrl {
    return URL(baseServiceURL, saveChildrenURL);
}


@end
