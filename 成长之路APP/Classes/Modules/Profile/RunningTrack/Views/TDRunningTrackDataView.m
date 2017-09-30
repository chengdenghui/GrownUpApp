//
//  TDRunningTrackDataView.m
//  成长之路APP
//
//  Created by mac on 2017/9/28.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDRunningTrackDataView.h"

@interface TDRunningTrackDataView ()<MZTimerLabelDelegate>

@property(nonatomic, weak)UILabel *distanceLabel; //距离
@property(nonatomic, weak)UILabel *timeLabel; //时间
@property(nonatomic, strong)MZTimerLabel *timerFormatLabel; //计时器
@property(nonatomic, weak)UILabel *calorieLabel; //卡路里(热量)
@property(nonatomic, weak)UILabel *speedLabel; //速度
@property(nonatomic, weak)UILabel *stepNumberlabel; //步数
@property(nonatomic, weak)UIButton *continueButton; //继续 / 暂停按钮
@property(nonatomic, weak)UIButton *endButton; //结束
@property(nonatomic, strong)UIBezierPath *currentPath; //当前的贝塞尔曲线

@end

@implementation TDRunningTrackDataView

-(void)setModelDic:(NSDictionary *)modelDic
{
    _modelDic =modelDic;
    self.distanceLabel.text =@"12.56";
    self.calorieLabel.text =@"16.49";
    self.speedLabel.text =@"17.38";
    self.stepNumberlabel.text =@"1234400";
    [self.timerFormatLabel start];
}

#pragma mark -----布局---
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(@60);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@120);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.distanceLabel.mas_bottom).offset(40);
        make.width.equalTo(self.distanceLabel.mas_width);
        make.height.equalTo(@80);
    }];
    [self.calorieLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(-SCREEN_WIDTH/4);
        make.top.equalTo(@(SCREEN_HEIGHT/2 +40));
        make.width.equalTo(@80);
        make.height.equalTo(@100);
    }];
    [self.speedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.calorieLabel.mas_top);
        make.width.equalTo(self.calorieLabel.mas_width);
        make.height.equalTo(self.calorieLabel.mas_height);
    }];
    [self.stepNumberlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(SCREEN_WIDTH/4);
        make.top.equalTo(self.speedLabel.mas_top);
        make.width.equalTo(self.speedLabel.mas_width);
        make.height.equalTo(self.speedLabel.mas_height);
    }];
    [self.continueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(-SCREEN_WIDTH/5);
        make.top.equalTo(self.stepNumberlabel.mas_bottom).offset(40);
        make.width.equalTo(@(100));
        make.height.equalTo(@100);
    }];
    [self.endButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(SCREEN_WIDTH/5);
        make.top.equalTo(self.continueButton.mas_top);
        make.width.equalTo(self.continueButton.mas_width);
        make.height.equalTo(self.continueButton.mas_height);
    }];
    
    
}

#pragma mark --private--
//触摸点击地图区域
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
    BOOL is =[self.currentPath  containsPoint:point];
    if (![self.currentPath  containsPoint:point]) {
        NSLog(@"####点击对了-----%id----",is);
        if (self.clickIntoMapBlock) {
            self.clickIntoMapBlock();
        }
    }
}
//按钮点击事件----
-(void)changeContinueAndEndButton:(UIButton *)button
{
    [UIView animateWithDuration:0.4 animations:^{
        
        if ([button.currentTitle isEqualToString:@"继续"]) {
            CGRect frame =button.frame;
            frame.origin.x =SCREEN_WIDTH/2-40;
            button.frame =frame;
            [button setTitle:@"暂停" forState:UIControlStateNormal];
            
            CGRect endframe =_endButton.frame;
            endframe.origin.x =SCREEN_WIDTH/2-40;
            _endButton.frame =endframe;
            
        } else{
            
            CGRect frame =button.frame;
            frame.origin.x =SCREEN_WIDTH/2 -SCREEN_WIDTH/5 -50;
            button.frame =frame;
            [button setTitle:@"继续" forState:UIControlStateNormal];
            
            CGRect endframe =_endButton.frame;
            endframe.origin.x =SCREEN_WIDTH/2 +SCREEN_WIDTH/5 -50;
            _endButton.frame =endframe;
        }
    }];
}

#pragma mark --Delagate---
- (NSString*)timerLabel:(MZTimerLabel *)timerLabel customTextToDisplayAtTime:(NSTimeInterval)time
{
    if([timerLabel isEqual:_timerFormatLabel]){
        int second = (int)time  % 60;
        int minute = ((int)time / 60) % 60;
        int hours = time / 3600;
        int day;
        if (hours>24) {
            day=hours/24;
        }else
        {
            day=0;
        }
        hours=hours-24*day;
        return [NSString stringWithFormat:@"%02d:%02d:%02d ",hours,minute,second];
    }
    else
        return nil;
}



#pragma mark ---getter----
-(UILabel *)distanceLabel
{
    if (!_distanceLabel) {
        UILabel *distanceLabel =[[UILabel alloc] init];
        distanceLabel.textColor =[UIColor whiteColor];
        distanceLabel.textAlignment =NSTextAlignmentCenter;
        distanceLabel.font =[UIFont systemFontOfSize:70 weight:0.4];
        distanceLabel.backgroundColor =[UIColor redColor];
        [self addSubview:distanceLabel];
        _distanceLabel =distanceLabel;
    }
    return _distanceLabel;
}

-(UILabel *)timeLabel
{
    if (!_timeLabel) {
        UILabel *timeLabel =[[UILabel alloc] init];
        timeLabel.textColor =[UIColor whiteColor];
        timeLabel.textAlignment =NSTextAlignmentCenter;
        timeLabel.font =[UIFont systemFontOfSize:55 weight:0.1];
        timeLabel.backgroundColor =[UIColor clearColor];
        [self addSubview:timeLabel];
        _timeLabel =timeLabel;
    }
    return _timeLabel;
}

- (MZTimerLabel *)timerFormatLabel
{
    if (!_timerFormatLabel) {
        _timerFormatLabel = [[MZTimerLabel alloc] initWithLabel:self.timeLabel andTimerType:MZTimerLabelTypeStopWatch];
        _timerFormatLabel.delegate = self;
    }
    return _timerFormatLabel;
}

-(UILabel *)calorieLabel
{
    if (!_calorieLabel) {
        UILabel *calorieLabel =[[UILabel alloc] init];
        calorieLabel.textColor =[UIColor whiteColor];
        calorieLabel.textAlignment =NSTextAlignmentCenter;
        calorieLabel.font =[UIFont systemFontOfSize:18 weight:0.2];
        calorieLabel.backgroundColor =[UIColor redColor];
        [self addSubview:calorieLabel];
        _calorieLabel =calorieLabel;
    }
    return _calorieLabel;
}

-(UILabel *)speedLabel
{
    if (!_speedLabel) {
        UILabel *speedLabel =[[UILabel alloc] init];
        speedLabel.textColor =[UIColor whiteColor];
        speedLabel.textAlignment =NSTextAlignmentCenter;
        speedLabel.font =[UIFont systemFontOfSize:18 weight:0.2];
        speedLabel.backgroundColor =[UIColor redColor];
        [self addSubview:speedLabel];
        _speedLabel =speedLabel;
    }
    return _speedLabel;
}

-(UILabel *)stepNumberlabel
{
    if (!_stepNumberlabel) {
        UILabel *stepNumberlabel =[[UILabel alloc] init];
        stepNumberlabel.textColor =[UIColor whiteColor];
        stepNumberlabel.textAlignment =NSTextAlignmentCenter;
        stepNumberlabel.font =[UIFont systemFontOfSize:18 weight:0.2];
        stepNumberlabel.backgroundColor =[UIColor redColor];
        [self addSubview:stepNumberlabel];
        _stepNumberlabel =stepNumberlabel;
    }
    return _stepNumberlabel;
}

-(UIButton *)continueButton
{
    if (!_continueButton) {
        UIButton *continueButton =[[UIButton alloc] init];
        continueButton.layer.masksToBounds =YES;
        continueButton.layer.cornerRadius =50;
        [continueButton setTitle:@"继续" forState:UIControlStateNormal];
        continueButton.titleLabel.font =[UIFont systemFontOfSize:18 weight:0.6];
        [self addSubview:continueButton];
        [self bringSubviewToFront:continueButton];
        continueButton.backgroundColor =RGBA(37, 200, 140, 1.0);
         _continueButton =continueButton;
        __weak typeof(self) unself =self;
        [continueButton addGesture_TapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
                //获得该相应手势，被添加到哪个View
            UIButton *button= (UIButton *)gestureRecoginzer.view;
            [unself changeContinueAndEndButton:button];
            
            if (unself.clickButtonBlock) {
                unself.clickButtonBlock(button.currentTitle);
            }
            
        }];
    }
    return _continueButton;
}

-(UIButton *)endButton
{
    if (!_endButton) {
        UIButton *endButton =[[UIButton alloc] init];
        endButton.backgroundColor =[UIColor redColor];
        endButton.layer.masksToBounds =YES;
        endButton.layer.cornerRadius =50;
        [endButton setTitle:@"结束" forState:UIControlStateNormal];
        endButton.titleLabel.font =[UIFont systemFontOfSize:18 weight:0.6];
        [self addSubview:endButton];
        [self sendSubviewToBack:endButton];
        _endButton =endButton;
        __weak typeof(self) unself =self;
        [endButton addGesture_LongPressActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            //获得该相应手势，被添加到哪个View
            UIButton *button= (UIButton *)gestureRecoginzer.view;
            if (unself.clickButtonBlock) {
                unself.clickButtonBlock(button.currentTitle);
            }
        }];
    }
    return _endButton;
}

#pragma mark ---贝塞尔曲线重绘视图----
-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    UIBezierPath* aPath = [UIBezierPath bezierPath];
    aPath.lineWidth = 15.0;
    /* kCGLineCapButt,
     kCGLineCapRound,
     kCGLineCapSquare
     */
    aPath.lineCapStyle = kCGLineCapButt ;//终点(起点)样式
    /* kCGLineJoinMiter,
     kCGLineJoinRound,
     kCGLineJoinBevel
     */
    aPath.lineJoinStyle = kCGLineJoinBevel;//拐点样式
    [aPath moveToPoint:CGPointMake(0, 0)];//设置起始点
    [aPath addLineToPoint:CGPointMake(SCREEN_WIDTH, 0)];//途经点
    [aPath addLineToPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT-100)];//途经点
    [aPath addLineToPoint:CGPointMake(SCREEN_WIDTH-100, SCREEN_HEIGHT)];//途经点
    [aPath addLineToPoint:CGPointMake(0, SCREEN_HEIGHT)];//途经点
    
    [aPath closePath];//通过调用closePath方法得到最后一条线
    UIColor *strokeColor = [UIColor clearColor];
    [strokeColor set];
    [aPath stroke];//设置线条颜色
    UIColor *fillColor = [UIColor colorWithWhite:0.1 alpha:0.85];
    [fillColor set];
    [aPath fill];//填充
    
     self.currentPath =aPath;
}



@end
