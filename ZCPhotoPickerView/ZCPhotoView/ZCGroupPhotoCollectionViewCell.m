//
//  ZCGroupPhotoCollectionViewCell.m
//  ZCPhotoPickerViewTest
//
//  Created by For_SHINee on 14-7-29.
//  Copyright (c) 2014年 For_SHINee. All rights reserved.
//

#import "ZCGroupPhotoCollectionViewCell.h"

@implementation ZCGroupPhotoCollectionViewCell
@synthesize _infoArr = __infoArr;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}
- (IBAction)selectBtnClicked:(id)sender
{
    self.selectBtn.selected = !self.selectBtn.selected;
    if ([self.delegate respondsToSelector:@selector(ZCPhotoChooseInView: WithSelected:)]) {
        [self.delegate ZCPhotoChooseInView:self WithSelected:self.selectBtn];
    }
}
- (void)getCollectionCellData:(NSArray *)data WithTag:(NSInteger)tag
{
    self._infoArr = [[NSArray alloc] initWithArray:data];
    self.tag = tag;
    UIImage *img =[UIImage imageWithCGImage:(CGImageRef)[self._infoArr objectAtIndex:1]];
    [self.photoView setImage:img];
//    NSString *urlStr = [self._infoArr objectAtIndex:0];
//    
//    static ALAssetsLibrary *assetLibrary=nil;
//    if (assetLibrary == nil) {
//        assetLibrary = [[ALAssetsLibrary alloc] init];
//    }
//    
//    NSURL *url=[NSURL URLWithString:urlStr];
//    
//    [assetLibrary assetForURL:url resultBlock:^(ALAsset *asset)  {
//        UIImage *img=[UIImage imageWithCGImage:asset.thumbnail];
//            [self.photoView setImage:img];
//    }failureBlock:^(NSError *error) {
//        
//        NSLog(@"error=%@",error);
//    }
//     ];
//

    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    NSLog(@" ZCGroupPhotoCollectionViewCell.h %@",NSStringFromSelector(_cmd));
}
*/

@end
