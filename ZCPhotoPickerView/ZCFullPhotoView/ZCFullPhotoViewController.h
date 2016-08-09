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
@required
- (NSUInteger) ZCNumberOfFullPhotoViewController;
- (NSArray *)ZCFullViewController:(ZCFullPhotoViewController *)view picForNumber:(NSInteger)picNum;
- (NSString *)ZCFullViewController_Title:(ZCFullPhotoViewController *)view picForNumber:(NSInteger)picNum;
@end



@interface ZCFullPhotoViewController : ZCBasicViewController<UIScrollViewDelegate,UITextViewDelegate>
@property (assign, nonatomic) id<ZCFullPhotoViewControllerDelegate> delegate;


@property (assign, nonatomic) BOOL selectOrNot;//是否有选择按钮



@property (strong, nonatomic) UIScrollView *_scrollView;
@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) UIView *bgTextView;


@property (strong, nonatomic) NSMutableArray *_showArr;//存放ZCFullViewCell
@property (strong, nonatomic) NSMutableArray *_currentArr;//当前展示图片的信息
@property (assign)            NSInteger _showNum;
@property (assign, nonatomic) Scroll_Type scrollType;

@property (assign, nonatomic) NSUInteger numOfImg;
@property (assign, nonatomic) NSInteger  currentNum;
@property (assign, nonatomic) CGFloat  scrollCenterX;
@property (assign, nonatomic) BOOL naviHidden;//全屏yes

- (id)ZCDequeueReusableCellWithIdentifier:(NSString *)identifier;
@end
