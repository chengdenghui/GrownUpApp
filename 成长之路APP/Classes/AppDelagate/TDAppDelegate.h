//
//  TDAppDelegate.h
//  成长之路APP
//
//  Created by mac on 2017/7/19.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDMainViewController.h"

@interface TDAppDelegate : UIResponder<UIApplicationDelegate>

@property(strong,nonatomic)UIWindow *window;
@property(strong,nonatomic)TDMainViewController *rootViewController;
@property (strong, nonatomic) BMKMapManager *mapManager;

@end
