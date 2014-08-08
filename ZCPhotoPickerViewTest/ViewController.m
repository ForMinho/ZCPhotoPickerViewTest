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
    [picBtn addTarget:self action:@selector(picBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:picBtn];
}

- (void) picBtnClicked
{
    self._viewCon = [[ZCPhotoViewController alloc] init];
    [self._viewCon setDelegate:self];
    UINavigationController *_nav = [[UINavigationController alloc] initWithRootViewController:self._viewCon];
    [self presentViewController:_nav animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) viewWillAppear:(BOOL)animated
{
}


- (void)ZCPhotoViewImgChoose:(NSDictionary *)_dic
{
    NSLog(@"_dic === %@",_dic);
}
@end
