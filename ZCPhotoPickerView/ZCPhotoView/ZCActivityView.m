//
//  ZCActivityView.m
//  ZCPhotoPickerViewTest
//
//  Created by For_SHINee on 14-8-1.
//  Copyright (c) 2014年 For_SHINee. All rights reserved.
//

#import "ZCActivityView.h"

@implementation ZCActivityView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
+(id)sharedZCActivityView
{
    static ZCActivityView *_activityView = nil;
    if (_activityView == nil) {
        _activityView = [[ZCActivityView alloc] initWithFrame:CGRectMake(0, 0, 1001, 100)];
        [_activityView setBackgroundColor:[UIColor grayColor]];
    }
    return _activityView;
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
