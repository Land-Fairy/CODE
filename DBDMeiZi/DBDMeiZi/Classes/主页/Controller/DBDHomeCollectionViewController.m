//
//  DBDHomeCollectionViewController.m
//  DBDMeiZi
//
//  Created by Mac on 17/3/31.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "DBDHomeCollectionViewController.h"
#import "DBDHomeCollectionViewCell.h"
#import <AFNetworking/AFNetworking.h>
#import "DBDHomeCellModel.h"
#import <MJRefresh/MJRefresh.h>
#import <MWPhotoBrowser/MWPhotoBrowser.h>
#import <PopMenu/PopMenu.h>
typedef NS_ENUM(NSUInteger, MeiziCategory) {
    MeiziCategoryAll = 0,
    MeiziCategoryDaXiong,
    MeiziCategoryQiaoTun,
    MeiziCategoryHeisi,
    MeiziCategoryMeiTui,
    MeiziCategoryQingXin,
    MeiziCategoryZaHui
};
@interface DBDHomeCollectionViewController ()<UICollectionViewDelegateFlowLayout,MWPhotoBrowserDelegate>
@property (nonatomic, assign) MeiziCategory currentType;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray<MWPhoto*> *photos;
@property (nonatomic, strong) UIButton *midBut;
@end

@implementation DBDHomeCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

/**
 *  重写 init方法，外部调用的时候，不需要设置 layout
 */
- (instancetype)init{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 1.;
    flowLayout.minimumInteritemSpacing = 1.;
    if (self = [super initWithCollectionViewLayout:flowLayout]) {
        
    }
    return self;
}
/**
 *  UICollectionView 的数据
 */
- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
/**
 *  图片 浏览器 的 数据
 */
- (NSMutableArray<MWPhoto *> *)photos{
    if (!_photos) {
        _photos = [NSMutableArray array];
    }
    return _photos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    /**
     *  设置 导航栏 中间按钮
     */
    [self setNavigation];
    /**
     *  注册 cell
     */
    [self.collectionView registerClass:[DBDHomeCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    /**
     *  默认 加载类型 为 MeiziCategoryAll
     */
    self.currentType = MeiziCategoryAll;
    /**
     *  添加下拉刷新
     */
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewDataFromServer)];
    /**
     *  第一次加载，刷新数据
     */
    [self.collectionView.mj_header beginRefreshing];
    /**
     *  添加 上拉刷新
     */
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}
/**
 *  设置导航栏
 */
- (void)setNavigation{
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(0, 0, 30, 20);
    [but setTitle:@"所有" forState:UIControlStateNormal];
    [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(changePicType:) forControlEvents:UIControlEventTouchUpInside];
    self.midBut = but;
    self.navigationItem.titleView = but;
}
/**
 *  点击 按钮  更换 图片 种类
 */
- (void)changePicType:(UIButton *)but{
    /**
     *  为 pop menu 添加 内容
     */
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:3];
    MenuItem *menuItem = [[MenuItem alloc] initWithTitle:@"所有" iconName:@"post_type_bubble_flickr" glowColor:[UIColor grayColor] index:0];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:@"大胸" iconName:@"post_type_bubble_googleplus" glowColor:[UIColor colorWithRed:0.000 green:0.840 blue:0.000 alpha:1.000] index:1];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:@"翘臀" iconName:@"post_type_bubble_instagram" glowColor:[UIColor colorWithRed:0.687 green:0.000 blue:0.000 alpha:1.000] index:2];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:@"黑丝" iconName:@"post_type_bubble_twitter" glowColor:[UIColor colorWithRed:0.687 green:0.000 blue:0.000 alpha:1.000] index:3];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:@"美腿" iconName:@"post_type_bubble_youtube" glowColor:[UIColor colorWithRed:0.687 green:0.000 blue:0.000 alpha:1.000] index:4];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:@"清新" iconName:@"post_type_bubble_facebook" glowColor:[UIColor colorWithRed:0.687 green:0.000 blue:0.000 alpha:1.000] index:5];
    [items addObject:menuItem];
    
    /**
     *  pop menu 设置
     */
    PopMenu *popMenu = [[PopMenu alloc] initWithFrame:self.view.bounds items:items];
    popMenu.menuAnimationType = kPopMenuAnimationTypeNetEase; // kPopMenuAnimationTypeSina
    popMenu.perRowItemCount = 3; // or 2
    [popMenu showMenuAtView:self.view];
    /**
     *  点击 pop menu 的 item时
     */
    __weak typeof(self) weakSelf = self;
    popMenu.didSelectedItemCompletion = ^(MenuItem *selectedItem){
        /**
         *  修改为 当前 选中 类型
         */
        weakSelf.currentType = selectedItem.index;
        /**
         *  更换 导航栏 中间 按钮 的 内容
         */
        [but setTitle:selectedItem.title forState:UIControlStateNormal];
        /**
         *  刷新数据
         */
        [weakSelf.collectionView.mj_header beginRefreshing];
    };
}

/**
 *  下拉刷新 加载 数据
 */
- (void)loadNewDataFromServer{
    /**
     *  下拉刷新，先清空所有数据
     */
    [self.dataArray removeAllObjects];
    /**
     *  每次将 page 设置 为 1
     */
    self.currentPage = 1;
    NSInteger page = 1;
    NSString *category = [self getStringFromType:self.currentType];
    NSString *urlStr = [NSString stringWithFormat:@"https://meizi.leanapp.cn/category/%@/page/%@",category,@(page)];
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleDataWith:responseObject];
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
/**
 *  上啦 刷新 加载 更多数据
 *
 */
- (void)loadMoreData{
    /**
     *  加载下一页
     */
    self.currentPage++;
    NSString *category = [self getStringFromType:self.currentType];
    NSString *urlStr = [NSString stringWithFormat:@"https://meizi.leanapp.cn/category/%@/page/%@",category,@(self.currentPage)];
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleDataWith:responseObject];
        [self.collectionView reloadData];
        [self.collectionView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

/**
 *  根据 妹子 类型，得到 对应的 category 字符串
 */
- (NSString *)getStringFromType:(MeiziCategory)type{
    NSString *category = @"";
    switch (self.currentType) {
        case MeiziCategoryAll:
            category = @"All";
            break;
        case MeiziCategoryDaXiong:
            category = @"DaXiong";
            break;
        case MeiziCategoryQiaoTun:
            category = @"QiaoTun";
            break;
        case MeiziCategoryHeisi:
            category = @"HeiSi";
            break;
        case MeiziCategoryMeiTui:
            category = @"MeiTui";
            break;
        case MeiziCategoryQingXin:
            category = @"QingXin";
            break;
        default:
            category = @"All";
            break;
    }
    return category;
}

/**
 *  数据 转 模型
 */
- (void)handleDataWith:(NSDictionary *)dict{
    NSArray *rootArray = dict[@"results"];
    for (NSDictionary *tmpDict in rootArray) {
        DBDHomeCellModel *model = [DBDHomeCellModel homeCellModelWithThumbUrl:tmpDict[@"thumb_url"] andImageUrl:tmpDict[@"image_url"]];
        [self.dataArray addObject:model];
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DBDHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    DBDHomeCellModel *model = self.dataArray[indexPath.row];
    cell.url = model.thumbUrl;
    return cell;
}
/**
 *  设置 ietm  size
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    /**
     *  竖屏
     */
    if ([UIDevice currentDevice].orientation == UIDeviceOrientationPortrait) {
        CGFloat itemW = ScreenW/3.- 1;
        return CGSizeMake(itemW, itemW);
    }
    else if([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft || [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight){
        CGFloat itemW = ScreenW/5. - 5;
        return CGSizeMake(itemW, itemW);
    }
    return CGSizeZero;
}
/**
 *  点击 图片的时候
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.photos removeAllObjects];
    for (DBDHomeCellModel *model in self.dataArray) {
        [self.photos addObject:[MWPhoto photoWithURL:model.imageUrl]];
    }
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = YES; // Show action button to allow sharing, copying, etc (defaults to YES)
    browser.displayNavArrows = NO; // Whether to display left and right nav arrows on toolbar (defaults to NO)
    browser.displaySelectionButtons = NO; // Whether selection buttons are shown on each image (defaults to NO)
    browser.zoomPhotosToFill = YES; // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
    browser.alwaysShowControls = NO; // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
    browser.enableGrid = YES; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
    browser.startOnGrid = NO; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
    browser.autoPlayOnAppear = NO; // Auto-play first video
    
    browser.customImageSelectedIconName = @"ImageSelected.png";
    browser.customImageSelectedSmallIconName = @"ImageSelectedSmall.png";
    [browser setCurrentPhotoIndex:indexPath.row];
    
    [self.navigationController pushViewController:browser animated:YES];
    [browser showNextPhotoAnimated:YES];
    [browser showPreviousPhotoAnimated:YES];
    
}
#pragma mark <MWPhotoBrowserDelegate>
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count) {
        return [self.photos objectAtIndex:index];
    }
    return nil;
}

@end
