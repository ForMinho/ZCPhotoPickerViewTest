//
//  ZCGroupPhotoCollectionViewCell.h
//  ZCPhotoPickerViewTest
//
//  Created by For_SHINee on 14-7-29.
//  Copyright (c) 2014年 For_SHINee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
@class ZCGroupPhotoCollectionViewCell;
@protocol ZCGroupPhotoCollectionViewCellDelegate <NSObject>
- (void)ZCPhotoChooseInView:(ZCGroupPhotoCollectionViewCell *)cell WithSelected:(UIButton *)button;

@end

@interface ZCGroupPhotoCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) IBOutlet UIButton *selectBtn;
@property (nonatomic, strong)           NSArray *_infoArr;
@property (nonatomic, strong) IBOutlet UIImageView *photoView;

@property (nonatomic, weak)   id<ZCGroupPhotoCollectionViewCellDelegate>delegate;
- (IBAction)selectBtnClicked:(id)sender;
- (void)getCollectionCellData:(NSArray *)data WithTag:(NSInteger)tag;
@end

