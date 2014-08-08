//
//  ZCPhotoInfomation.h
//  ZCPhotoPickerViewTest
//
//  Created by For_SHINee on 14-7-29.
//  Copyright (c) 2014年 For_SHINee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@protocol ZCPhotoInfomationDelegate <NSObject>

- (void)ZCPhotoGroupReLoad:(NSArray *)groupArr;
//- (void)ZCPhotoImageReLoad:(NSArray *)imageArr;
//
//- (void)ZCPhotoReload:(NSDictionary *)groupDic;
@end

@interface ZCPhotoInfomation : NSObject
//@property (strong, nonatomic) NSString       *groupName;
@property (strong, nonatomic) NSMutableArray *groupArr;
@property (strong, nonatomic) NSMutableDictionary *imageDic;
@property (strong, nonatomic) NSMutableArray *tempArr;
@property (weak  , nonatomic) id<ZCPhotoInfomationDelegate>delegate;
+ (id) sharedZCPhotoInformation;

- (id) initWithZCPhotoInfomation:(NSString *)groupName;
- (void) getSystemPhoto;
@end

