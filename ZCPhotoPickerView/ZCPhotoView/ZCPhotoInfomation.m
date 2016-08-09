//
//  ZCPhotoInfomation.m
//  ZCPhotoPickerViewTest
//
//  Created by For_SHINee on 14-7-29.
//  Copyright (c) 2014年 For_SHINee. All rights reserved.
//

#import "ZCPhotoInfomation.h"
@implementation ZCPhotoInfomation
@synthesize delegate  = _delegate;
//@synthesize groupName = _groupName;
@synthesize groupArr  = _groupArr;
@synthesize imageDic  = _imageDic;
@synthesize tempArr   = _tempArr;
+ (id) sharedZCPhotoInformation
{
    
    
    
    static ZCPhotoInfomation *_info = nil;
    if (_info == nil) {
        _info = [[ZCPhotoInfomation alloc] init];
        _info.groupArr  = [[NSMutableArray alloc] init];
        _info.imageDic  = [[NSMutableDictionary alloc] init];
        _info.tempArr   = [[NSMutableArray alloc] init];
        [_info getSystemPhoto];
    }
    return _info;
}
- (id) initWithZCPhotoInfomation:(NSString *)groupName
{
    self = [super init];
    if (self) {
//        self.groupArr  = [[NSMutableArray alloc] init];
//        self.imageArr  = [[NSMutableArray alloc] init];
//        self.tempArr   = [[NSMutableArray alloc] init];
    }
    return self;
}
- (void) getSystemPhoto
{
    dispatch_async(dispatch_get_main_queue(), ^{
        ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error)
        {
            if ([error.localizedDescription rangeOfString:@"Global denied access"].location != NSNotFound) {
                NSLog(@"无法访问相册,请在'设置->定位服务'设置为打开状态");
            }
            else{
                NSLog(@"访问相册失败");
            }
        };
        ALAssetsGroupEnumerationResultsBlock groupEnumeration = ^(ALAsset *result,NSUInteger index,BOOL *stop){
            if (result != NULL) {
                if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                    NSString *url = (NSString *)result.defaultRepresentation.url;
                    CGImageRef thumbImg = result.thumbnail;
                    [self.tempArr addObject:[NSArray arrayWithObjects:url,thumbImg, nil]];
                }
            }
        };
        ALAssetsLibraryGroupsEnumerationResultsBlock libraryGroupsEnumeration = ^(ALAssetsGroup *group,BOOL *stop)
        {
            if (group ==nil) {
                
            }else{
                
                NSString *g = [NSString stringWithFormat:@"%@",group];
                NSString *g1= [g substringFromIndex:16];

                NSArray *arr = [[NSArray alloc] init];
                arr = [g1 componentsSeparatedByString:@","];
                NSString *g2 = [[arr objectAtIndex:0] substringFromIndex:5];
                if ([g2 isEqualToString:@"Camera Roll"]) {
                    g2 = @"相机胶卷";
                }
                else if([g2 isEqualToString:@"My Photo Stream"])
                {
                    g2 = @"我的照片流";
                }

                {
                    [group enumerateAssetsUsingBlock:groupEnumeration];

                    if (self.tempArr && self.tempArr.count != 0) {
                        NSArray *_array = [NSArray arrayWithObjects:g2,[[self.tempArr objectAtIndex:0] objectAtIndex:1], nil];
                        
                        if ([self.delegate respondsToSelector:@selector(ZCPhotoGroupReLoad:)]) {
                            [self.delegate ZCPhotoGroupReLoad:_array];
                        }
                        [self.groupArr addObject:_array];
                        [self.imageDic setObject:[NSArray arrayWithArray:self.tempArr] forKey:g2];
                        
                        [self.tempArr removeAllObjects];
                    }
                }
            }
        };
        ALAssetsLibrary *library =[[ALAssetsLibrary alloc] init];
        [library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:libraryGroupsEnumeration failureBlock:failureBlock];
    });
}

@end
