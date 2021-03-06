//
//  TDForgetPasswordView.h
//  成长之路APP
//
//  Created by mac on 2017/8/10.
//  Copyright © 2017年 hui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDForgetPasswordView : UIView

@property(nonatomic, copy) void(^verificationBlock)(NSString *phoneText,UIButton *sender);
@property(nonatomic, copy) void(^makeSureBlock)(NSString *userText, NSString *verificationText, NSString *passwordText); //确认

@end
