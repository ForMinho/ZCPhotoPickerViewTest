//
//  ZCFullPhotoViewController.h
//  ZCPhotoPickerViewTest
//
//  Created by For_SHINee on 14-7-29.
//  Copyright (c) 2014年 For_SHINee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCBasicViewController.h"
@class ZCFullPhotoViewController;
@protocol  ZCFullPhotoViewControllerDelegate<NSObject>


@end
@interface ZCFullPhotoViewController : ZCBasicViewController<UIScrollViewDelegate>

@property (strong, nonatomic) NSArray *_showArr;
@property (assign)            NSInteger _showNum;
@property (strong, nonatomic) UIScrollView *_scrollView;
@end
