//
//  EaseLiveConfig.h
//  成长之路APP
//
//  Created by mac on 2017/10/20.
//  Copyright © 2017年 hui. All rights reserved.
//

#ifndef EaseLiveConfig_h
#define EaseLiveConfig_h

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define SysVersion [[[UIDevice currentDevice] systemVersion] floatValue]

#define KScreenHeight [[UIScreen mainScreen] bounds].size.height
#define KScreenWidth  [[UIScreen mainScreen] bounds].size.width

#define kEaseDefaultIconFont @"iconfont"

#define kDefaultChatroomId @"203138578711052716"

#define kDefaultSystemTextGrayColor RGBACOLOR(197, 197, 197, 1)
#define kDefaultSystemTextColor RGBACOLOR(38, 38, 38, 1)
#define kDefaultSystemBgColor RGBACOLOR(51, 51, 51, 1)
#define kDefaultSystemLightGrayColor RGBACOLOR(197, 197, 197, 1)
#define kDefaultLoginButtonColor RGBACOLOR(25, 163, 255, 1)

//demo中的推流地址仅供demo测试使用，如果更换推流域名地址，请联系客服或者客户经理索取对应的CGIKey
#define CGIKey @"publish3-key"
#define RecordDomain(id) [NSString stringWithFormat:@"rtmp://publish3.cdn.ucloud.com.cn/ucloud/%@", id];
#define PlayDomain(id) [NSString stringWithFormat:@"rtmp://vlive3.rtmp.cdn.ucloud.com.cn/ucloud/%@", id];

#define kLiveDemoVersion @"1.0.0"

#define kNotificationRefreshList @"em_nofity_LiveListRefresh"

#define kLiveLastLoginUsername @"em_last_username"

#import <Hyphenate/Hyphenate.h>   //环信SDK
#import <EaseUI.h>                //EaseUI
#import "MBProgressHUD+Add.h"
#import "UIView+Position.h"
#import "EaseHttpManager.h"

#endif /* EaseLiveConfig_h */
