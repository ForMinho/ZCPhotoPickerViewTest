//
//  ZCFullPhotoViewController.h
//  ZCPhotoPickerViewTest
//
//  Created by For_SHINee on 14-7-29.
//  Copyright (c) 2014年 For_SHINee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCBasicViewController.h"
#import "ZCFullPhotoViewCell.h"

#define ZCFULLPHOTO_NUM 10
typedef enum {
    Scroll_Normal ,
    Scroll_Right,
    Scroll_Left,
}Scroll_Type;
@class ZCFullPhotoViewController;
@protocol  ZCFullPhotoViewControllerDelegate<NSObject>

- (NSUInteger) ZCNumberOfFullPhotoViewController;
- (NSArray *)ZCFullViewController:(ZCFullPhotoViewController *)view picForNumber:(NSInteger)picNum;
@end



@interface ZCFullPhotoViewController : ZCBasicViewController<UIScrollViewDelegate>
@property (assign, nonatomic) id<ZCFullPhotoViewControllerDelegate> delegate;
@property (strong, nonatomic) NSMutableArray *_showArr;
@property (assign)            NSInteger _showNum;
@property (assign, nonatomic) Scroll_Type scrollType;
@property (strong, nonatomic) UIScrollView *_scrollView;
@property (assign, nonatomic) NSUInteger numOfImg;
@property (assign, nonatomic) NSInteger currentNum;
@property (assign, nonatomic) CGFloat  scrollCenterX;

- (id)ZCDequeueReusableCellWithIdentifier:(NSString *)identifier;
@end
