//
//  ZCFullPhotoViewController.m
//  ZCPhotoPickerViewTest
//
//  Created by For_SHINee on 14-7-29.
//  Copyright (c) 2014年 For_SHINee. All rights reserved.
//

#import "ZCFullPhotoViewController.h"
#import "ZCHeader.h"
@interface ZCFullPhotoViewController ()

@end

@implementation ZCFullPhotoViewController
@synthesize _showArr    = __showArr;
@synthesize _showNum    = __showNum;
@synthesize _scrollView = __scrollView;
@synthesize delegate    = _delegate;
@synthesize numOfImg    = _numOfImg;
@synthesize currentNum  = _currentNum;
@synthesize scrollCenterX=_scrollCenterX;
@synthesize scrollType  = _scrollType;
static int numOfCell = 0,numOfCount = 0;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)dismissViewController
{
    numOfCount = numOfCell = 0;
    [super dismissViewController];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.scrollType = Scroll_Normal;
    [self reloadScrollView];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) reloadScrollView
{
    if ([self.delegate respondsToSelector:@selector(ZCNumberOfFullPhotoViewController)]) {
        self.numOfImg = [self.delegate ZCNumberOfFullPhotoViewController];
    }
     CGRect mainRect = MAINRECT;
    if (self._scrollView == nil) {
       
        self._scrollView = [[UIScrollView alloc] initWithFrame:mainRect];
        [self._scrollView setDelegate:self];
        [self._scrollView setContentSize:CGSizeMake(self.numOfImg * mainRect.size.width, 0)];
        [self._scrollView scrollRectToVisible:CGRectMake(self.numOfImg/2 * mainRect.size.width ,0, mainRect.size.width ,mainRect.size.height) animated:YES];
        
        self._scrollView.pagingEnabled = YES;
        [self.view addSubview:self._scrollView];
        self.scrollCenterX = self._scrollView.contentOffset.x;
    }
    self._showArr = [[NSMutableArray alloc] init];
    
    mainRect = MAINRECT;
//    mainRect.origin.x = self._scrollView.center.x - mainRect.size.width / 2;
    for (int i = 0 ; i<ZCFULLPHOTO_NUM; i ++)
    {
        ZCFullPhotoViewCell *_cell = [[ZCFullPhotoViewCell alloc] initWithFrame:mainRect];
        [self._showArr addObject:_cell];
        [self._scrollView addSubview:_cell];
        mainRect.origin.x += mainRect.size.width/2;
    }
    
    [self startReloadFullPic:self.currentNum];
    
}
//get data have to show
- (void)startReloadFullPic:(NSUInteger)numOfPage
{
    
    NSMutableArray *infoArr = [[NSMutableArray alloc] init];
    if ([self.delegate respondsToSelector:@selector(ZCFullViewController:picForNumber:)]) {
     [infoArr addObjectsFromArray:[self.delegate ZCFullViewController:self picForNumber:numOfPage]];
    }
    
    NSURL *urlStr = (NSURL *)[[infoArr objectAtIndex:0] objectAtIndex:0];
//    NSLog(@"count == %d,urlStr ==%@",numOfCell + numOfCount *10,urlStr);
    static ALAssetsLibrary *assetLibrary=nil;
    if (assetLibrary == nil) {
        assetLibrary = [[ALAssetsLibrary alloc] init];
    }


    [assetLibrary assetForURL:urlStr resultBlock:^(ALAsset *asset)  {
        UIImage *image=[UIImage imageWithCGImage:[asset defaultRepresentation].fullResolutionImage];
        
        ZCFullPhotoViewCell *_cell = (ZCFullPhotoViewCell *)[self._showArr objectAtIndex:numOfCell];
        CGRect mainRect = MAINRECT;
        mainRect.origin.x = (numOfCell + numOfCount * ZCFULLPHOTO_NUM) * mainRect.size.width /2;
        NSLog(@"mainRect.origin.x == %f",mainRect.origin.x);
        [_cell setFrame:mainRect];
        [_cell setImgForView:image];
        
    }failureBlock:^(NSError *error) {

        NSLog(@"error=%@",error);
    }
     ];
}

- (id)ZCDequeueReusableCellWithIdentifier:(NSString *)identifier;
{
    return nil;
}
#pragma mark --
#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x - self.scrollCenterX > 0) {
        self.scrollType = Scroll_Right;
    }
    else if(scrollView.contentOffset.x - self.scrollCenterX < 0)
    {
        self.scrollType = Scroll_Left;
    }
    else{
        self.scrollType = Scroll_Normal;
    }
//    NSLog(@"%@,%f,%f",NSStringFromSelector(_cmd),scrollView.contentOffset.x ,self.scrollCenterX);
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    if (self.scrollType == Scroll_Right)
    {
        if (self.currentNum < self.numOfImg - 1) {
            self.currentNum ++ ;
            numOfCell ++ ;
            if (numOfCell == ZCFULLPHOTO_NUM ) {
                numOfCell = 0;
                numOfCount ++;
            }

        }else
            self.currentNum = self.numOfImg -1;
    }
    else if (self.scrollType == Scroll_Left)
    {
        if (self.currentNum > 0) {
            self.currentNum --;
            
            numOfCell = numOfCell - 1;
            if (numOfCell < 0) {
                numOfCell = ZCFULLPHOTO_NUM -1 ;
                numOfCount --;
                if (numOfCount < 0) {
                    numOfCount = 0;
                    numOfCell = 0;
                }
            }

        }
        else
            self.currentNum = 0;
    }
    self.scrollCenterX = scrollView.contentOffset.x;
    [self startReloadFullPic:self.currentNum];
#if DEBUG
//    NSLog(@"self.currentNum == %ld",(long)self.currentNum);
//    NSLog(@"self.scrollType === %d",self.scrollType);
#endif
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
}
@end
