//
//  ZCUnderWindowPreView.m
//  ZCPhotoPickerViewTest
//
//  Created by For_SHINee on 14-8-11.
//  Copyright (c) 2014年 For_SHINee. All rights reserved.
//

#import "ZCUnderWindowPreView.h"
#import "ZCHeader.h"
@interface ZCUnderWindowPreView() <ZCUnderImageViewDelegate>
@end

@implementation ZCUnderWindowPreView
static ZCUnderWindowPreView *_view = nil;
//@synthesize selectImgNum = _selectImgNum;
@synthesize _scrollView = __scrollView;
@synthesize imgArr  = _imgArr;
@synthesize zcPhotoType =_zcPhotoType;
+ (id)sharedZCUnderWindowPreView
{
    if (_view == nil) {
        _view = [[ZCUnderWindowPreView alloc] init];
        [_view setBackgroundColor:[UIColor grayColor]];
    }
    return _view;
}
+ (BOOL)chargeZCUnderPreViewInited
{
    if (_view !=nil) {
        return YES;
    }
    else
        return NO;
}

- (void) setZCUnderViewFrame:(CGRect)rect
{
    [self setFrame:rect];
    [self initScrollView];
}
- (void)initScrollView
{
    CGRect rect = self.frame;
    UIButton *preViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rect.origin.x = 10;
    rect.origin.y = 5;
    rect.size.width = ImgSize;
    rect.size.height = rect.size.height - ImgSize - 2*rect.origin.y;
    [preViewBtn setFrame:rect];
    [preViewBtn setTitle:@"preView" forState:UIControlStateNormal];
    [preViewBtn addTarget:self action:@selector(preViewBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:preViewBtn];
    
    rect.origin.x = self.frame.size.width - rect.origin.x - rect.size.width;
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneBtn setFrame:rect];
    [doneBtn setTitle:@"done" forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(doneBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:doneBtn];
    
    rect = self.frame;
    if (self._scrollView == nil) {
        rect.origin.y = rect.size.height - ImgSize;
        self._scrollView = [[UIScrollView alloc] initWithFrame:rect];
        [self._scrollView setBackgroundColor:[UIColor blackColor]];
        [self insertSubview:self._scrollView atIndex:100];
    }
}
//    charge the pic in the view already
- (BOOL) chargePicHadIn:(NSString *)urlStr
{
 
    for (ZCUnderImageView *obj in self.imgArr) {
        NSString *tempStr = [obj.infoArr objectAtIndex:0];
        if ([tempStr isEqual:urlStr]) {
            return YES;
        }
    }
    return NO;
}
- (void) addPicToTheView:(UIImage *)img WithData:(NSArray *)data
{
    if (self.imgArr == nil) {
        self.imgArr = [[NSMutableArray alloc] init];
    }
    if ([self chargePicHadIn:(NSString *)[data objectAtIndex:0]]) {
        return;
    }
    [self initScrollView];
    CGRect viewRect = self.frame;
        viewRect.size.width = viewRect.size.height = ImgSize;
    viewRect.origin.x += ImgBetween * IMGCOUNT(self.imgArr.count) + viewRect.size.width * self.imgArr.count;

    viewRect.origin.y = ImgBetween;
    ZCUnderImageView *_imgView = [[ZCUnderImageView alloc] initWithFrame:viewRect];
    _imgView.infoArr = [NSMutableArray arrayWithArray:data];
    [_imgView setDelegate:self];
    [self._scrollView addSubview:_imgView];
    [_imgView setSelectImg:img];
    
    viewRect = self.frame;
    
    [self._scrollView setContentSize:CGSizeMake(IMGCOUNT(self.imgArr.count)* (ImgSize + ImgBetween * 2), self.frame.size.height)];
    if (viewRect.size.height - _imgView.frame.origin.x <ImgSize){
        viewRect = _imgView.frame;
        viewRect.size.width += ImgBetween;
        [self._scrollView scrollRectToVisible:viewRect animated:YES];
    }
    [self.imgArr addObject:_imgView];
}
- (void) removePicFromView:(UIImage *)img WithData:(NSArray *)data
{
    NSString *urlStr = nil;
    if (data.count) {
        urlStr = (NSString *)[data objectAtIndex:0];
    }
    [self.imgArr enumerateObjectsUsingBlock:^(id obj,NSUInteger idx,BOOL *stop)
    {
        NSLog(@"%d",idx);
        ZCUnderImageView *imgView = (ZCUnderImageView *)obj;
        if (imgView.infoArr && imgView.infoArr.count) {
            NSString *tempStr = (NSString *)[imgView.infoArr objectAtIndex:0];
            if ([tempStr isEqual:urlStr]) {
                [self reloadScrollView:idx];
                [self.imgArr removeObject:obj];
                [imgView removeFromSuperview];
                *stop = YES;
            }
        }
    }];
}
- (void)reloadScrollView:(NSInteger) deleteNum
{
    if (deleteNum < self.imgArr.count) {
        for (int i = deleteNum;i < self.imgArr.count; i ++) {
            ZCUnderImageView *_zcImgView = (ZCUnderImageView *)[self.imgArr objectAtIndex:i];
            CGRect imgRect = _zcImgView.frame;
            imgRect.origin.x -= (ImgBetween + ImgSize);
            [UIView animateWithDuration:0.2f animations:^{
                [_zcImgView setFrame:imgRect];
                CGRect  viewRect = self.frame;
                [self._scrollView setContentSize:CGSizeMake(self.imgArr.count * (ImgSize + ImgBetween * 2), self.frame.size.height)];
                if (viewRect.size.height - imgRect.origin.x <ImgSize){
                    viewRect = imgRect;
                    viewRect.size.width += ImgBetween;
                    [self._scrollView scrollRectToVisible:viewRect animated:YES];
                }

            }];
            
        }
    }
}
- (void)reInitZCUnderView
{
    _view = nil;
}

#pragma mark --
#pragma mark -- UIButton
- (void) preViewBtnClicked
{
    if ([self.delegate respondsToSelector:@selector(ZCUnderPreViewPreViewBtn:)]) {
        [self.delegate ZCUnderPreViewPreViewBtn:self.imgArr];
    }
}
- (void) doneBtnClicked
{
    if ([self.delegate respondsToSelector:@selector(ZCUnderPreViewDoneBtn:)]) {
        [self.delegate ZCUnderPreViewDoneBtn:self.imgArr];
    }
}

#pragma mark -- 
#pragma mark -- ZCUnderImageViewDelegate
- (void)deleteZCImageView:(UIImage *)img withData:(NSArray *)data
{
    [self removePicFromView:img WithData:data];
}

@end
