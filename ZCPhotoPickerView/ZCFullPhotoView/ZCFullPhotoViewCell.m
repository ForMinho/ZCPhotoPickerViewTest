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
//        [self setBackgroundColor:[UIColor blackColor]];
        self.imageView = [[UIImageView alloc] initWithFrame:frame];
        [self addSubview:self.imageView];
        
        [self.imageView setImage:[UIImage imageNamed:@"Right.png"]];
        
    }
    return self;
}

- (void) setImgForView:(UIImage *)image
{
//    NSLog(@"height == %f, width == %f",image.size.height,image.size.width);
//    yes width > height,按照高度来设置frame
    BOOL sizeOfImg = ((image.size.width/image.size.height) > WIDTH_HEIGHT)?YES:NO;
    CGRect imgRect = self.imageView.frame;
    imgRect.origin.x = imgRect.origin.y = 0;
    if (!sizeOfImg) {
        imgRect.size.width = (MAINRECT.size.height / image.size.width) * image.size.width;
    }
    else
    {
        imgRect.size.height = image.size.height * (MAINRECT.size.width / image.size.height);
    }
    [self.imageView setFrame:imgRect];
    [self.imageView setCenter:self.center];
    [self.imageView setImage:image];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
