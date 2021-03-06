
//
//  TDAddressProfileViewController.m
//  成长之路APP
//
//  Created by mac on 2017/8/30.
//  Copyright © 2017年 hui. All rights reserved.
//

#import "TDAddressProfileViewController.h"
#import "TDAddressProfileView.h"
#import "TDBAddGoodsAddressViewController.h"
#import "TDMTMapViewController.h"

@interface TDAddressProfileViewController ()

@property(nonatomic ,strong)TDAddressProfileView *addressProfileView; //地址View

@property(nonatomic ,copy)NSString *elmDetailAddress; //饿了么地址
@property(nonatomic ,assign)CLLocationCoordinate2D elmlocation; //饿了么经纬度

@end

@implementation TDAddressProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title =@"地址选择";
    _elmlocation = CLLocationCoordinate2DMake([KDEFAULTLAT doubleValue], [KDEFAULTLNG doubleValue]);
    [self.view addSubview:self.addressProfileView]; //地址View
}


#pragma mark ---private-
//饿了么
-(void)clickElmAddressView
{
    //饿了么地址
    TDBAddGoodsAddressViewController *addGoodsAddressVC = [[TDBAddGoodsAddressViewController alloc] init];
    addGoodsAddressVC.location =_elmlocation;
    addGoodsAddressVC.getAddressBlock = ^(NSString *detailAddress, CLLocationCoordinate2D location) {

        DLog(@"地址:%@--纬度:%f",detailAddress,location.latitude);
        self.addressProfileView.elmTitleLabel.text =detailAddress;
        self.addressProfileView.elmDetailLabel.text =[NSString stringWithFormat:@"纬度:%f 经度:%f",location.latitude,location.longitude];
        self.elmlocation =location;
        
        [self navigationBack];
    };
    [self navigationDetail:addGoodsAddressVC];

}
//跳转美团外卖
-(void)clickMtwmAddressView
{
    TDMTMapViewController *mtMapVC =[[TDMTMapViewController alloc] init];
    mtMapVC.location =_elmlocation;
    mtMapVC.getAddressBlock = ^(NSString *detailAddress, CLLocationCoordinate2D location) {
        
        DLog(@"地址:%@--纬度:%f",detailAddress,location.latitude);
        self.addressProfileView.mtwmTitleLabel.text =detailAddress;
        self.addressProfileView.mtwmDetailLabel.text =[NSString stringWithFormat:@"纬度:%f 经度:%f",location.latitude,location.longitude];
        self.elmlocation =location;
        
        [self navigationBack];
    };

    [self.navigationController pushViewController:mtMapVC animated:YES];
}


#pragma mark --delagate----





#pragma mark ---getter--
//地址View
-(TDAddressProfileView *)addressProfileView
{
    if (!_addressProfileView) {
        
        _addressProfileView =[[TDAddressProfileView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT/4)];
        _addressProfileView.backgroundColor =[UIColor clearColor];
        __weak typeof(self) unself =self;
        _addressProfileView.elmAddressBlock = ^{
          
            [unself clickElmAddressView];
        };
        _addressProfileView.mtwmAddressBlock = ^{
          
            [unself clickMtwmAddressView];
        };
        
        
    }
    return _addressProfileView;
}


@end





