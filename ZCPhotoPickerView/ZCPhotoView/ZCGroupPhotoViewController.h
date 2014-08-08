//
//  ZCGroupPhotoViewController.h
//  ZCPhotoPickerViewTest
//
//  Created by For_SHINee on 14-7-29.
//  Copyright (c) 2014年 For_SHINee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCPhotoInfomation.h"
#import "ZCBasicViewController.h"
#import "ZCGroupPhotoCollectionViewCell.h"
@class ZCGroupPhotoViewController;
@protocol ZCGroupPhotoControllerDelegate <NSObject>

- (void) imageSelectedInView:(NSDictionary *)_imgDic;

@end
@interface ZCGroupPhotoViewController : ZCBasicViewController<ZCPhotoInfomationDelegate,ZCGroupPhotoCollectionViewCellDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    ZCPhotoInfomation *_information;
  
}
@property (nonatomic, weak)   id<ZCGroupPhotoControllerDelegate> delegate;
@property (nonatomic, strong) UICollectionView *_collectionView;
@property (nonatomic, strong) NSMutableArray *_photoArray;
@property (nonatomic, strong) NSMutableDictionary *_photoChoose;
@property (nonatomic, strong) NSString *groupName;
@end
