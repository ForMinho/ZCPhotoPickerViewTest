//
//  ZCGroupPhotoViewController.m
//  ZCPhotoPickerViewTest
//
//  Created by For_SHINee on 14-7-29.
//  Copyright (c) 2014年 For_SHINee. All rights reserved.
//

#import "ZCGroupPhotoViewController.h"
#import "ZCHeader.h"
#define Collection_identifier @"collection"
@interface ZCGroupPhotoViewController () <ZCUnderWindowPreViewDelegate,ZCFullPhotoViewControllerDelegate>

@end

@implementation ZCGroupPhotoViewController
@synthesize _collectionView = __collectionView;
@synthesize _photoArray     = __photoArray;
@synthesize groupName       = _groupName;
@synthesize _photoChoose    = __photoChoose;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        if ([[ZCUnderWindowPreView sharedZCUnderWindowPreView] zcPhotoType]==ZCPhotoView_UNDERWINDOW) {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(toTheRootView)];

        }else
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"选择" style:UIBarButtonItemStyleBordered target:self action:@selector(photoChooseClicked)];
    }
    return self;
}
- (void)photoChooseClicked
{
    if ([self.delegate respondsToSelector:@selector(imageSelectedInView:)]) {
        ZCUnderWindowPreView *_zcView = [ZCUnderWindowPreView sharedZCUnderWindowPreView];
        [_zcView.imgArr enumerateObjectsUsingBlock:^(id obj,NSUInteger idx,BOOL *stop)
        {
            ZCUnderImageView *_imgView = (ZCUnderImageView *)obj;
           [self._photoChoose setObject:_imgView.infoArr forKey:[NSString stringWithFormat:@"%d",idx]];
        }];
        [[ZCUnderWindowPreView sharedZCUnderWindowPreView] setHidden:YES];
        [_zcView reInitZCUnderView];
        [self.delegate imageSelectedInView:self._photoChoose];
    }
    [super dismissViewController];
}
- (void)toTheRootView
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [[ZCUnderWindowPreView sharedZCUnderWindowPreView] setHidden:YES];
    [[ZCUnderWindowPreView sharedZCUnderWindowPreView] reInitZCUnderView];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     CGRect mainRect = MAINRECT;
    if ([ZCUnderWindowPreView chargeZCUnderPreViewInited] && [[ZCUnderWindowPreView sharedZCUnderWindowPreView] zcPhotoType] == ZCPhotoView_UNDERWINDOW) {
        mainRect.size.height -= 50;
    }
    self.title = self.groupName;
    self._photoArray = [[NSMutableArray alloc] init];
    self._photoChoose= [[NSMutableDictionary alloc] init];
    
    UICollectionViewFlowLayout *layeOut = [[UICollectionViewFlowLayout alloc] init];
    layeOut.itemSize = CGSizeMake(70,70);
    layeOut.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5) ;
    self._collectionView = [[UICollectionView alloc] initWithFrame:mainRect collectionViewLayout:layeOut];
    [self._collectionView setDelegate:self];
    [self._collectionView setDataSource:self];
    self._collectionView.allowsMultipleSelection = YES;
    
    [self.view addSubview:self._collectionView];
    [self._collectionView setBackgroundColor:[UIColor whiteColor]];
    [self._collectionView registerNib:[UINib nibWithNibName:@"ZCGroupPhotoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:Collection_identifier];
    
    _information = [ZCPhotoInfomation sharedZCPhotoInformation];
    NSArray *_tempArr = [_information.imageDic objectForKey:self.groupName];
    self._photoArray = (NSMutableArray *) [[_tempArr reverseObjectEnumerator]allObjects];
}
- (void)viewDidAppear:(BOOL)animated
{
    if ([ZCUnderWindowPreView chargeZCUnderPreViewInited] && [[ZCUnderWindowPreView sharedZCUnderWindowPreView] zcPhotoType] == ZCPhotoView_UNDERWINDOW) {
        [[ZCUnderWindowPreView sharedZCUnderWindowPreView] setHidden:NO];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    self._collectionView = nil;
    self._photoArray = nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark --
#pragma mark -- UICollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
#if DEBUG
    NSLog(@"self._photoArray.count == %d",self._photoArray.count);
#endif
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self._photoArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZCGroupPhotoCollectionViewCell *cell = (ZCGroupPhotoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:Collection_identifier forIndexPath:indexPath];
    [cell getCollectionCellData:[self._photoArray objectAtIndex:indexPath.row] WithTag:indexPath.row];
    cell.delegate = self;
    if ([ZCUnderWindowPreView chargeZCUnderPreViewInited] && [[ZCUnderWindowPreView sharedZCUnderWindowPreView] zcPhotoType] == ZCPhotoView_UNDERWINDOW) {
        [cell.selectBtn setHidden:YES];
    }else
    {
        cell.selectBtn.selected = [self picHasSelected:(NSString *)[cell._infoArr objectAtIndex:0]] ? YES:NO;
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZCGroupPhotoCollectionViewCell *cell = (ZCGroupPhotoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if ([ZCUnderWindowPreView chargeZCUnderPreViewInited] && [[ZCUnderWindowPreView sharedZCUnderWindowPreView] zcPhotoType] == ZCPhotoView_UNDERWINDOW){
         [[ZCUnderWindowPreView sharedZCUnderWindowPreView] addPicToTheView:cell.photoView.image WithData:cell._infoArr];
        return;
    }
    
    ZCFullPhotoViewController *_fullPhotoView = [[ZCFullPhotoViewController alloc] init];
    [_fullPhotoView setDelegate:self];
    _fullPhotoView.currentNum = indexPath.row;
    [self.navigationController pushViewController:_fullPhotoView animated:YES];
//    UINavigationController *_nav = [[UINavigationController alloc] initWithRootViewController:_fullPhotoView];
//    [self presentViewController:_nav animated:YES completion:nil];
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (BOOL)picHasSelected:(NSString *)urlStr
{
    ZCUnderWindowPreView *_zcView = [ZCUnderWindowPreView sharedZCUnderWindowPreView];
    
    for (ZCUnderImageView *_imgView in _zcView.imgArr)
    {
        NSString * tempStr = (NSString *)[_imgView.infoArr objectAtIndex:0];
        if ([tempStr isEqual:urlStr]) {
            return YES;
        }
    }
    return NO;
}
#pragma mark --
#pragma mark -- ZCGroupPhotoCollectionViewCellDelegate
- (void)ZCPhotoChooseInView:(ZCGroupPhotoCollectionViewCell *)cell WithSelected:(UIButton *)button;
{
    UIImage *img =[UIImage imageWithCGImage:(CGImageRef)[cell._infoArr objectAtIndex:1]];
    if (button.selected) {
        
        [[ZCUnderWindowPreView sharedZCUnderWindowPreView] addPicToTheView:img WithData:cell._infoArr];
    }else
    {
        [[ZCUnderWindowPreView sharedZCUnderWindowPreView] removePicFromView:img WithData:cell._infoArr];
    }
#if DEBUG

#endif
}

#pragma mark --
#pragma mark -- UICollectionView
- (void)ZCPhotoImageReLoad:(NSArray *)imageArr
{

}
- (void)ZCPhotoGroupReLoad:(NSArray *)groupArr
{
    
}

#pragma mark --
#pragma mark -- ZCFullPhotoViewControllerDelegate
- (NSUInteger)ZCNumberOfFullPhotoViewController
{
    return self._photoArray.count;
}
- (NSArray *)ZCFullViewController:(ZCFullPhotoViewController *)view picForNumber:(NSInteger)picNum
{
    NSArray *_arr = [NSArray arrayWithObjects:[self._photoArray objectAtIndex:picNum],[NSString stringWithFormat:@"%d",picNum],nil];
    return _arr;
}
- (NSString *)ZCFullViewController_Title:(ZCFullPhotoViewController *)view picForNumber:(NSInteger)picNum
{
    return [NSString stringWithFormat:@"%d / %d",picNum+1,self._photoArray.count];
}
@end
