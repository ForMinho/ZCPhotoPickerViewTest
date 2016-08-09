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

typedef enum
{
    ZCPhotoView_NORMAL = 1,
    ZCPhotoView_UNDERWINDOW,
}ZCPhotoViewType;

@class ZCUnderWindowPreView;

@protocol ZCUnderWindowPreViewDelegate <NSObject>
- (void) ZCUnderPreViewDoneBtn:(NSArray *)infoArray;
- (void) ZCUnderPreViewPreViewBtn:(NSArray *)infoArray;

@end

@interface ZCUnderWindowPreView : UIView<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *imgArr;
@property (nonatomic, strong) UIScrollView *_scrollView;
@property (nonatomic, assign) id<ZCUnderWindowPreViewDelegate> delegate;
@property (nonatomic, assign) ZCPhotoViewType zcPhotoType;


+ (id) sharedZCUnderWindowPreView;
+ (BOOL) chargeZCUnderPreViewInited;//yes,init;no,nil;
- (void) setZCUnderViewFrame:(CGRect)rect;
- (CGRect)returnZCUnderViewFrame;
- (void) addPicToTheView:(UIImage *)img WithData:(NSArray *)data;
- (void) removePicFromView:(UIImage *)img WithData:(NSArray *)data;
- (void)reInitZCUnderView;


@end
