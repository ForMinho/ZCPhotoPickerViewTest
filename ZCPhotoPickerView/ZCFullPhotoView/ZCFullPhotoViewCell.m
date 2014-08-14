//
//  ZCFullPhotoViewCell.m
//  ZCPhotoPickerViewTest
//
//  Created by For_SHINee on 14-8-13.
//  Copyright (c) 2014年 For_SHINee. All rights reserved.
//

#import "ZCFullPhotoViewCell.h"
#import "ZCHeader.h"
@implementation ZCFullPhotoViewCell
@synthesize imageView = _imageView;
@synthesize textView  = _textView;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.imageView = [[UIImageView alloc] initWithFrame:frame];
        [self addSubview:self.imageView];
        [self setBackgroundColor:[UIColor clearColor]];
    

        
    }
    return self;
}

- (void) setImgForView:(UIImage *)image
{
    float scaleOfImg = image.size.width / image.size.height;
    
    BOOL sizeOfImg = (scaleOfImg > WIDTH_HEIGHT) ? YES:NO;
    CGRect imgRect = self.imageView.frame;
    if (sizeOfImg) {
        imgRect.size.height = (imgRect.size.width / image.size.width) * image.size.height;
    }
    else
    {
        imgRect.size.width = (imgRect.size.height / image.size.height) * image.size.width;
    }
    [self.imageView setFrame:imgRect];
    CGPoint centerPoint = CGPointMake(self.center.x, (imgRect.size.height / 2 + (self.frame.size.height - imgRect.size.height ) / 2));
    [self.imageView setCenter:centerPoint];
    [self.imageView setImage:image];
}

@end
