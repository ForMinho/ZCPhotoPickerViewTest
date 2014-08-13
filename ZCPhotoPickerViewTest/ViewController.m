//
//  ViewController.m
//  ZCPhotoPickerViewTest
//
//  Created by For_SHINee on 14-7-28.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) ZCPhotoViewController *_viewCon;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIButton *picBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [picBtn setFrame:CGRectMake(self.view.center.x - 50, self.view.center.y - 50, 100, 100)];
    [picBtn setBackgroundColor:[UIColor grayColor]];
    [picBtn addTarget:self action:@selector(picBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [picBtn setTag:101];
    [picBtn setTitle:@"normal" forState:UIControlStateNormal];
    [self.view addSubview:picBtn];
    
    UIButton *picBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [picBtn1 setFrame:CGRectMake(self.view.center.x - 50, self.view.center.y - 170, 100, 100)];
    [picBtn1 setBackgroundColor:[UIColor grayColor]];
    [picBtn1 setTitle:@"underWindow" forState:UIControlStateNormal];
    [picBtn1 addTarget:self action:@selector(picBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [picBtn1 setTag:102];
    [self.view addSubview:picBtn1];

}
- (void) viewWillAppear:(BOOL)animated
{
    if ([ZCUnderWindowPreView chargeZCUnderPreViewInited]){
        [[ZCUnderWindowPreView sharedZCUnderWindowPreView] setHidden:YES];
    }
}
- (void)viewDidAppear:(BOOL)animated
{
//    [[ZCUnderWindowPreView sharedZCUnderWindowPreView] setHidden:YES];
}
- (void) picBtnClicked:(UIButton *)button
{
    self._viewCon = [[ZCPhotoViewController alloc] init];
    [self._viewCon setDelegate:self];
    if (button.tag == 101) {
        [[ZCUnderWindowPreView sharedZCUnderWindowPreView] setZcPhotoType:ZCPhotoView_NORMAL];
    }else
        [[ZCUnderWindowPreView sharedZCUnderWindowPreView] setZcPhotoType:ZCPhotoView_UNDERWINDOW];
    
    UINavigationController *_nav = [[UINavigationController alloc] initWithRootViewController:self._viewCon];
    [self presentViewController:_nav animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)ZCPhotoViewImgChoose:(NSDictionary *)_dic
{
    NSLog(@"_dic === %@",_dic);
}
@end
