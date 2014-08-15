//
//  ZCPhotoViewController.h
//  ZCPhotoPickerViewTest
//
//  Created by For_SHINee on 14-7-28.
//  Copyright (c) 2014年 For_SHINee. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ZCHeader.h"
#import "ZCPhotoInfomation.h"
#import "ZCBasicViewController.h"
#define CELLVIEW_HEIGHT 50

@class ZCPhotoViewController;
@protocol ZCPhotoViewControllerDelegate <NSObject>

- (void)ZCPhotoViewImgChoose:(NSDictionary *)_dic;

@end
@interface ZCPhotoViewController : ZCBasicViewController<UITableViewDataSource,UITableViewDelegate,ZCPhotoInfomationDelegate>
{
    ZCPhotoInfomation *information;
    UIActivityIndicatorView *_activityView;
}
@property (weak  , nonatomic) id<ZCPhotoViewControllerDelegate> delegate;
//@property (assign, nonatomic) ZCPhotoViewType zcPhotoViewType;
@property (strong, nonatomic) NSMutableArray *groupArray;//所有的图片信息
@property (strong, nonatomic) UITableView *_tableView;
@property (assign, nonatomic) BOOL selectWhenFullScreen;//在查看大图时是否可选
@end


