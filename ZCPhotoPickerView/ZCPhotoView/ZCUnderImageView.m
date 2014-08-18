//
//  ZCUnderImageView.m
//  ZCPhotoPickerViewTest
//
//  Created by For_SHINee on 14-8-11.
//  Copyright (c) 2014年 For_SHINee. All rights reserved.
//

#import "ZCUnderImageView.h"

@implementation ZCUnderImageView
@synthesize infoArr = _infoArr;
@synthesize img = _img;
@synthesize imgView = _imgView;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        if (self.infoArr == nil) {
            self.infoArr = [[NSMutableArray alloc] init];
        }
        self.imgView = [[UIImageView alloc] initWithFrame:frame];
        [self addSubview:self.imgView];
        
        frame.origin.x =frame.origin.y = 0;
        self.imgView = [[UIImageView alloc] initWithFrame:frame];
        [self addSubview:self.imgView];
        
        frame.origin.x =frame.origin.y = -5;
        frame.size.height = frame.size.width = 20;
        
        self.delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.delBtn setFrame:frame];
        [self.delBtn setBackgroundImage:[UIImage imageNamed:@"delBtn.png"] forState:UIControlStateNormal];
        [self.delBtn addTarget:self action:@selector(deleBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.delBtn];
    }
    return self;
}
- (void) setInfoData:(NSMutableArray *)data
{
    [self.infoArr addObjectsFromArray:data];
}
- (void) setSelectImg:(UIImage *)img{
    self.img = img;
    [self.imgView setImage:self.img];
}
- (void) deleBtnClicked
{
//    NSLog(@"1222222222");
    if ([self.delegate respondsToSelector:@selector(deleteZCImageView:withData:)]) {
        [self.delegate deleteZCImageView:self.img withData:self.infoArr];
    }
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
