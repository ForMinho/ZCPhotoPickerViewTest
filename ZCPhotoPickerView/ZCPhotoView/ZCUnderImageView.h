//
//  ZCUnderImageView.h
//  ZCPhotoPickerViewTest
//
//  Created by For_SHINee on 14-8-11.
//  Copyright (c) 2014年 For_SHINee. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZCUnderImageView;
@protocol ZCUnderImageViewDelegate <NSObject>

- (void) deleteZCImageView:(UIImage *)img withData:(NSArray *) data;
@end
@interface ZCUnderImageView : UIView
@property (nonatomic, strong)  UIImage *img;
@property (nonatomic, strong)  UIImageView *imgView;
@property (nonatomic, strong) NSMutableArray *infoArr;
@property (assign)      id<ZCUnderImageViewDelegate>delegate;
@property (nonatomic, strong) UIButton *delBtn;
- (void) setSelectImg:(UIImage *)img;
- (void) deleBtnClicked;
- (void) setInfoData:(NSMutableArray *)data;
@end
