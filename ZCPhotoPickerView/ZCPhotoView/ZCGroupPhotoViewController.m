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
@interface ZCGroupPhotoViewController ()

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
//        if ([ZCUnderWindowPreView chargeZCUnderPreViewInited]) {
//            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(toTheRootView)];
//
//        }else
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
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     CGRect mainRect = [UIScreen mainScreen].bounds;
    if ([ZCUnderWindowPreView chargeZCUnderPreViewInited]) {
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    self._collectionView = nil;
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
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZCFullPhotoViewController *_fullPhotoView = [[ZCFullPhotoViewController alloc] init];
    UINavigationController *_nav = [[UINavigationController alloc] initWithRootViewController:_fullPhotoView];
    [self presentViewController:_nav animated:YES completion:nil];
//    [self.navigationController pushViewController:_fullPhotoView animated:YES];
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark --
#pragma mark -- ZCGroupPhotoCollectionViewCellDelegate
- (void)ZCPhotoChooseInView:(ZCGroupPhotoCollectionViewCell *)cell WithSelected:(UIButton *)button;
{
    UIImage *img =[UIImage imageWithCGImage:(CGImageRef)[cell._infoArr objectAtIndex:1]];
    if (button.selected) {
//        [self._photoChoose setObject:cell._infoArr forKey:[NSString stringWithFormat:@"%d",cell.tag]];
        
        [[ZCUnderWindowPreView sharedZCUnderWindowPreView] addPicToTheView:img WithData:cell._infoArr];
    }else
    {
//        [self._photoChoose removeObjectForKey:[NSString stringWithFormat:@"%d",cell.tag]];
        [[ZCUnderWindowPreView sharedZCUnderWindowPreView] removePicFromView:img WithData:cell._infoArr];
    }
#if DEBUG
//    NSLog(@"self._photoChoose == %@",self._photoChoose);
#endif
}

#pragma mark --
#pragma mark -- UICollectionView
- (void)ZCPhotoImageReLoad:(NSArray *)imageArr
{
    /*
    [self._photoArray removeAllObjects];
    [self._photoArray addObjectsFromArray:imageArr];
    [self._collectionView reloadData];
    [_activityView setHidden:YES];
     */
}
- (void)ZCPhotoGroupReLoad:(NSArray *)groupArr
{
    
}


@end
