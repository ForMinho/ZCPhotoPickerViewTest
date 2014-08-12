//
//  ZCUnderWindowPreView.h
//  ZCPhotoPickerViewTest
//
//  Created by For_SHINee on 14-8-11.
//  Copyright (c) 2014年 For_SHINee. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ImgSize 60
#define ImgBetween 10
#define IMGCOUNT(num) (num+1)
@class ZCUnderWindowPreView;

@protocol ZCUnderWindowPreViewDelegate <NSObject>
- (void) ZCUnderPreViewDoneBtn:(NSArray *)infoArray;
- (void) ZCUnderPreViewPreViewBtn:(NSArray *)infoArray;

@end

@interface ZCUnderWindowPreView : UIView<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *imgArr;
@property (nonatomic, strong) UIScrollView *_scrollView;
@property (assign)            id<ZCUnderWindowPreViewDelegate> delegate;

+ (id) sharedZCUnderWindowPreView;
+ (BOOL) chargeZCUnderPreViewInited;//yes,init;no,nil;
- (void) setZCUnderViewFrame:(CGRect)rect;
- (void) addPicToTheView:(UIImage *)img WithData:(NSArray *)data;
- (void) removePicFromView:(UIImage *)img WithData:(NSArray *)data;
- (void)reInitZCUnderView;


@end
