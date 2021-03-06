//
//  TDHomeRecommendViewModel.m
//  成长之路APP
//
//  Created by mac on 2017/10/30.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDHomeRecommendViewModel.h"
#import "XMLYFindAPI.h"

#define kFindRecomUpdateSignalName @"XMLYFindRecomViewModelUpdateContentSignal"

#define kSectionADImage     0      //顶部广告轮播图
#define kSectionEditCommen  1   //小编推荐
#define kSectionLive        2   //现场直播
#define kSectionSpecial     3   //精品听单

#define kSectionADImageHeight  SCREEN_HEIGHT/5 +90
#define kSectionHeight        200.0
#define kSectionLiveHeight    190.0
#define kSectionSpecialHeight 220.0

@interface TDHomeRecommendViewModel ()

@property (nonatomic, strong) RACSubject *updateContentSignal;

@end

@implementation TDHomeRecommendViewModel

-(instancetype)init
{
    if (self =[super init]) {
        self.updateContentSignal =[[RACSubject subject] setNameWithFormat:kFindRecomUpdateSignalName];
    }
    return self;
}

#pragma mark ---public
-(void)refreshDataSource
{
    @weakify(self);
    RACSignal *signalRecommend = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self requestRecommendList:^{
            [subscriber sendNext:nil];
        }];
        return nil;
    }];
    
    RACSignal *signalHotAndGuess = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self requestHotAndGuessList:^{
            [subscriber sendNext:nil];
        }];
        return nil;
    }];
    
    RACSignal *signalLiving = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self requestLiving:^{
            [subscriber sendNext:nil];
        }];
        return nil;
    }];
    
    [[RACSignal combineLatest:@[signalRecommend,signalHotAndGuess,signalLiving]] subscribeNext:^(id x) {
        @strongify(self);
        [(RACSubject *)self.updateContentSignal sendNext:nil];
    }];
    
}

-(NSInteger)numberOfSections
{
    return 4;
}

-(NSInteger)numberOfItemsInSection:(NSInteger)section
{
    if(section == kSectionADImage) {
        return 1;
    }
    else if(section == kSectionEditCommen) {
        return 1;
    }
    else if(section == kSectionLive) {
        return self.liveModel.data.count == 0 ? 0 : 1;
    }
    else if(section == kSectionSpecial) {
        return self.recommendModel.specialColumn.list == 0 ? 0 : 1;
    }
    return 0;
}

- (CGSize)sizeForRowAtIndex:(NSIndexPath *)indexPath;
{
    if(indexPath.section == kSectionADImage) {
        return CGSizeMake(SCREEN_WIDTH, kSectionADImageHeight);
    }
    if(indexPath.section == kSectionEditCommen) {
        return CGSizeMake(SCREEN_WIDTH, kSectionHeight);
    }
    else if(indexPath.section == kSectionLive) {
        return CGSizeMake(SCREEN_WIDTH, self.liveModel.data.count == 0 ? 0 : kSectionLiveHeight);
    }
    else if(indexPath.section == kSectionSpecial) {
        return CGSizeMake(SCREEN_WIDTH, self.recommendModel.specialColumn.list == 0 ? 0 : kSectionSpecialHeight);
    }
    return CGSizeMake(0, 0);
}

#pragma mark - NetRequest
/**
 *  请求正在直播数据
 */
- (void)requestLiving:(void(^)())completion {
    [XMLYFindAPI requestLiveRecommend:^(id responseObject, BOOL success) {
        if(success) {
            [TDHomeFindLiveModel mj_setupObjectClassInArray:^NSDictionary *{
                return @{
                         @"data":@"TDHomeFindLiveDetailModel"
                         };
            }];
            self.liveModel = [TDHomeFindLiveModel mj_objectWithKeyValues:responseObject];
        }
        if(completion){
            completion();
        }
    }];
}

/**
 *  请求热门、猜你喜欢部分的数据
 */
- (void)requestHotAndGuessList:(void(^)())completion {
    [XMLYFindAPI requestHotAndGuess:^(id responseObject, BOOL success) {
        if(success) {
            [XMLYFindDiscoverColumnsModel mj_setupObjectClassInArray:^NSDictionary *{
                return @{
                         @"list":@"XMLYFindDiscoverDetailModel"
                         };
            }];
            
            [XMLYHotRecommend mj_setupObjectClassInArray:^NSDictionary *{
                return @{
                         @"list":@"XMLYHotRecommendItemModel"
                         };
            }];
            
            [XMLYCityColumnModel mj_setupObjectClassInArray:^NSDictionary *{
                return @{
                         @"list":@"XMLYFindEditorRecommendDetailModel"
                         };
            }];
            
            [XMLYHotRecommendItemModel mj_setupObjectClassInArray:^NSDictionary *{
                return @{
                         @"list":@"XMLYFindEditorRecommendDetailModel"
                         };
            }];
            self.hotGuessModel = [TDHomeFindHotGuessModel mj_objectWithKeyValues:responseObject];
        }
        if(completion){
            completion();
        }
    }];
}


/**
 *  请求热门动态数据
 */
- (void)requestRecommendList:(void(^)())completion {
    [XMLYFindAPI requestRecommends:^(id responseObject, BOOL success) {
        if(success) {
            [XMLYFindEditorRecommendAlbumModel mj_setupObjectClassInArray:^NSDictionary *{
                return @{
                         @"list":@"XMLYFindEditorRecommendDetailModel"
                         };
            }];
            
            [XMLYFindFocusImagesModel mj_setupObjectClassInArray:^NSDictionary *{
                return @{
                         @"list":@"XMLYFindFocusImageDetailModel"
                         };
            }];
            
            [XMLYSpecialColumnModel mj_setupObjectClassInArray:^NSDictionary *{
                return @{
                         @"list":@"XMLYSpecialColumnDetailModel"
                         };
            }];
            
            self.recommendModel = [TDHomeRecommendModel mj_objectWithKeyValues:responseObject];
        }
        
        if(completion) {
            completion();
        }
    }];
}




@end




