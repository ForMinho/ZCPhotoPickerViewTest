//
//  ZCPhotoViewController.m
//  ZCPhotoPickerViewTest
//
//  Created by For_SHINee on 14-7-28.
//  Copyright (c) 2014年 For_SHINee. All rights reserved.
//

#import "ZCPhotoViewController.h"
#import "ZCHeader.h"
@interface ZCPhotoViewController ()<ZCGroupPhotoControllerDelegate>

@end

@implementation ZCPhotoViewController
//@synthesize imgChoose  = _imgChoose;
@synthesize groupArray = _groupArray;
@synthesize _tableView = __tableView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"照片库";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.groupArray = [[NSMutableArray alloc] init];
//    self.imgChoose  = [[NSMutableDictionary alloc] init];
    
    self._tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self._tableView setDelegate:self];
    [self._tableView setDataSource:self];
    [self.view addSubview:self._tableView];
    [self._tableView setHidden:YES];
    
    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_activityView setCenter:self.view.center];
    [_activityView setColor:[UIColor grayColor]];
    [_activityView setHidesWhenStopped:YES];
    [self.view addSubview:_activityView];
    [_activityView startAnimating];
    
    information = [ZCPhotoInfomation sharedZCPhotoInformation];
    information.delegate = self;
    if (information.groupArr && information.groupArr.count!= 0) {
        [self.groupArray addObjectsFromArray:information.groupArr];
        [self tableReload];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableReload
{
    [self._tableView reloadData];
    [_activityView stopAnimating];
    [self._tableView setHidden:NO];
}
//------------------------根据图片的url反取图片－－－－－


//ALAssetsLibrary *assetLibrary=[[ALAssetsLibrary alloc] init];

//NSURL *url=[NSURL URLWithString:urlStr];
//
//[assetLibrary assetForURL:url resultBlock:^(ALAsset *asset)  {
//    
//    UIImage *image=[UIImage imageWithCGImage:asset.thumbnail];
//    
//    cellImageView.image=image;
//    
//    
//    
//}failureBlock:^(NSError *error) {
//    
//    NSLog(@"error=%@",error);
//    
//}
// 
// ];

//}
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
#pragma mark -- UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.groupArray.count;
}
/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELLVIEW_HEIGHT;
}
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"index"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"index"];
    }
    
    NSString *text =(NSString *)[[self.groupArray objectAtIndex:indexPath.row] objectAtIndex:0];
    cell.textLabel.text = text;

    CGRect imageRect = cell.imageView.frame;
    imageRect.size.width = imageRect.size.height = cell.frame.size.width;
    [cell.imageView setFrame:imageRect];
    

        [cell.imageView setImage:[UIImage imageWithCGImage:(CGImageRef) [[self.groupArray objectAtIndex:indexPath.row] objectAtIndex:1]]];
    /*
    NSString *urlStr = [self.groupArray objectAtIndex:indexPath.row*2+1];
    
    static ALAssetsLibrary *assetLibrary=nil;
    if (assetLibrary == nil) {
        assetLibrary = [[ALAssetsLibrary alloc] init];
    }

    NSURL *url=[NSURL URLWithString:urlStr];

    [assetLibrary assetForURL:url resultBlock:^(ALAsset *asset)  {
            UIImage *image=[UIImage imageWithCGImage:asset.thumbnail];
            cell.imageView.image=image;
//            NSString *text = [self.groupArray objectAtIndex:indexPath.row];
//            cell.textLabel.text = text;

        }failureBlock:^(NSError *error) {

            NSLog(@"error=%@",error);
        }
     ];
   */
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *groupName = cell.textLabel.text;
    ZCGroupPhotoViewController *_groupView = [[ZCGroupPhotoViewController alloc] init];
    _groupView.groupName = groupName;
    [_groupView setDelegate:self];
    if (self.navigationController.viewControllers.count>=1  ) {
        [self.navigationController pushViewController:_groupView animated:YES];
    }else{
      [self presentViewController:_groupView animated:YES completion:nil];
    }
}
#pragma mark-- ZCPhotoInfomationDelegate
- (void)ZCPhotoGroupReLoad:(NSArray *)groupArr
{
    [self.groupArray addObject:groupArr];
    [self tableReload];
}
#pragma mark --
#pragma mark -- ZCGroupPhotoControllerDelegate
- (void) imageSelectedInView:(NSDictionary *)_imgDic;
{
    if ([self.delegate respondsToSelector:@selector(ZCPhotoViewImgChoose:)]) {
        [self.delegate ZCPhotoViewImgChoose:_imgDic];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
