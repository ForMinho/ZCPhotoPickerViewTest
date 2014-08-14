//
//  ZCFullPhotoViewCell.h
//  ZCPhotoPickerViewTest
//
//  Created by For_SHINee on 14-8-13.
//  Copyright (c) 2014年 For_SHINee. All rights reserved.
//

#import <UIKit/UIKit.h>
#define WIDTH_HEIGHT (MAINRECT.size.width/MAINRECT.size.height)
#define TEXTVIEWHEIGHT 100
@interface ZCFullPhotoViewCell : UIView

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UITextView  *textView;

- (void) setImgForView:(UIImage *)image;
@end
