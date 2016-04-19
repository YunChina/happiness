//
//  SHAlbumViewController.m
//  Happiness
//
//  Created by xIang on 16/3/21.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHAlbumViewController.h"
#import "SHPhotoCollectionViewCell.h"
#import "SHAccountTool.h"
#import "SHAlbumToolBarView.h"
#import "ZLPhotoPickerBrowserViewController.h"
#import "SHImageTool.h"
#import "CYAccountTool.h"
#import "CYAccount.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>


#define kWAndH ([UIScreen mainScreen].bounds.size.width - 25) / 4

@interface SHAlbumViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ZLPhotoPickerBrowserViewControllerDelegate>
@property(nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray * photoArr;
@property (nonatomic, assign) CellState cellState;
@property (nonatomic, strong) SHAlbumToolBarView * toolBarView;
@property (nonatomic, strong) NSMutableArray * selectPhotoArr;


@end

@implementation SHAlbumViewController


- (NSMutableArray *)selectPhotoArr{
    if (!_selectPhotoArr) {
        _selectPhotoArr = [NSMutableArray array];
    }
    return _selectPhotoArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [self setNavigationBar];
    //设置内容视图
    [self setupContentView];
}

//设置视图
- (void)setupContentView{
    //获取照片
    SHImageModel *imageModel = [SHImageTool imageModel];
    
    //添加图片到photoArray中
    
    self.photoArr = [NSMutableArray arrayWithArray:imageModel.photosArr];
    
    //1.创建对象
    //1.1先创建UICollectionViewFlowLayout对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //1.2配置UICollectionViewFlowLayout的相关属性
    //行间距
    flowLayout.minimumLineSpacing = 5;
    
    //列间距
    flowLayout.minimumInteritemSpacing = 5;
    //每个item的大小
    flowLayout.itemSize = CGSizeMake(kWAndH, kWAndH);
    //设置距屏幕边缘的距离
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 0, 5);
    
    //滚动方向(默认上下滚动)
    //    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //1.3实例化UICollectionViewFlowLayout并设置flowLayout
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    //2.配置属性
    
    //3.添加到父视图
    [self.view addSubview:self.collectionView];
    
    //设置代理
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView registerClass:[SHPhotoCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    self.tabBarController.tabBar.hidden = YES;
    
    //设置工具条
    self.toolBarView = [[SHAlbumToolBarView alloc] initWithFrame:CGRectMake(0, kScreenH-108, kScreenW, 44)];
    [self.view addSubview:self.toolBarView];
    [self.toolBarView.cancelBtn addTarget:self action:@selector(cancelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.toolBarView.deleteBtn addTarget:self action:@selector(deleteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.toolBarView.hidden = YES;
}

//设置导航栏
- (void)setNavigationBar{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"私密相册";
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"管理" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    //左键返回
    SHLeftBackButton *backButton = [[SHLeftBackButton alloc] init];
    [backButton setSelfWithImageName:@"nav-bar-white-back-btn" title:@"小幸福"];
    [backButton addTarget:self action:@selector(leftItemAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftItem;
}

//左键返回
- (void)leftItemAction:(UIBarButtonItem *)leftItem{
    [self.navigationController popViewControllerAnimated:YES];
}

//右键管理
- (void)rightItemAction:(UIBarButtonItem *)rightItem{
    if ([self.navigationItem.rightBarButtonItem.title isEqualToString:@"管理"]) {
        CYAlertController *alertVC = [CYAlertController showAlertControllerWithTitle:[NSString stringWithFormat:@"已存储%lu张",(unsigned long)self.photoArr.count] message:nil preferredStyle:UIAlertControllerStyleActionSheet isSucceed:YES viewController:self];
        // 添加事件
        //上传照片
        CYAlertAction *actionPhoto = [CYAlertAction actionWithTitle:@"上传照片" handler:^(UIAlertAction *action) {
            CYAlertController *alertPhotoVC = [CYAlertController showAlertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet isSucceed:YES viewController:self];
            // 添加事件
            //拍照
            CYAlertAction *actionCamera = [CYAlertAction actionWithTitle:@"拍照" handler:^(UIAlertAction *action) {
                [self openCamera];
            }];
            
            //从相册上传
            CYAlertAction *actionAlbum = [CYAlertAction actionWithTitle:@"从相册上传" handler:^(UIAlertAction *action) {
                [self openAlbum];
            }];
            alertPhotoVC.allActions = @[actionCamera,actionAlbum];
        }];
        
        //编辑
        CYAlertAction *actionEdit = [CYAlertAction actionWithTitle:@"编辑" handler:^(UIAlertAction *action) {
            self.toolBarView.hidden = NO;
            [self.toolBarView.deleteBtn setEnabled:NO];
            
            self.cellState = DeleteState;
            self.navigationItem.rightBarButtonItem.title = @"完成";
            [self.collectionView reloadData];
        }];
        alertVC.allActions = @[actionPhoto,actionEdit];
    } else {
        [self cancelBtnAction:self.toolBarView.cancelBtn];
    }
}

//工具条取消按钮
- (void)cancelBtnAction:(UIButton *)sender{
    [self.selectPhotoArr removeAllObjects];
    self.cellState = NormalState;
    self.toolBarView.hidden = YES;
    [self.collectionView reloadData];
    self.navigationItem.rightBarButtonItem.title = @"管理";
}

//工具条删除按钮
- (void)deleteBtnAction:(UIButton *)sender{
    CYAlertController *alertVC = [CYAlertController showAlertControllerWithTitle:@"提示" message:@"确定删除" preferredStyle:UIAlertControllerStyleActionSheet isSucceed:YES viewController:self];
    CYAlertAction *actionYes = [CYAlertAction actionWithTitle:@"确定" handler:^(UIAlertAction *action) {
        //获取图片model
        SHImageModel *imageModel = [SHImageTool imageModel];
        //获取账户信息
        SHAccountHome *accountHome = [SHAccountTool account];
        NSMutableArray *photoUrlArr = [NSMutableArray arrayWithArray:accountHome.photoUrlArray];
        for (NSIndexPath *indexPath in self.selectPhotoArr) {
            [photoUrlArr removeObjectAtIndex:indexPath.row];
            [self.photoArr removeObjectAtIndex:indexPath.row];
        }
        accountHome.photoUrlArray = photoUrlArr;
        [self.selectPhotoArr removeAllObjects];
        [self.toolBarView.deleteBtn setEnabled:NO];
        imageModel.photosArr = self.photoArr;
        
        CYAccount *cyAccount = [CYAccountTool account];
        //上传到云端
        if (cyAccount.accountHomeObjID) {
            AVObject *accountAV = [AVObject objectWithoutDataWithClassName:@"SHAccountHome" objectId:cyAccount.accountHomeObjID];
            [accountAV setObject:accountHome.mj_keyValues forKey:@"accountHome"];
            [accountAV saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    //存储到本地
                    CYLog(@"存储相册图片成功");
                    //存入沙盒
                    [SHAccountTool saveAccount:accountHome];
                    [SHImageTool saveImageModel:imageModel];
                }
            }];
        }
        //存入沙盒
        [SHAccountTool saveAccount:accountHome];
        [SHImageTool saveImageModel:imageModel];
        
        [self.collectionView reloadData];
        if (self.photoArr.count == 0) {
            [self.toolBarView.deleteBtn setEnabled:NO];
        }
        
    }];
    alertVC.allActions = @[actionYes];
}

- (void)openCamera{
    //先设定sourceType为相机，然后判断相机是否可用（ipod）没相机
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        //提示相机不可用
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"相机不可用" preferredStyle:(UIAlertControllerStyleAlert)];
        // 添加事件
        //拍照
        UIAlertAction *actionCamera = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            
        }];
        [alertVC addAction:actionCamera];
        // 模态显示
        [self presentViewController:alertVC animated:YES completion:nil];
        return;
    }
    //sourceType = UIImagePickerControllerSourceTypeCamera; //照相机
    //sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //图片库
    //sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum; //保存的相片
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate = self;
    picker.allowsEditing = YES;//设置可编辑
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];//进入照相界面
}

- (void)openAlbum{
    
    // 创建图片多选控制器
    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
    // 默认显示相册里面的内容SavePhotos
    pickerVc.status = PickerViewShowStatusSavePhotos;
    pickerVc.maxCount = 9;
    [pickerVc showPickerVc:self];
    // block回调或者代理
    // 用block来代替代理
    //    pickerVc.delegate = self;
    
    //     传值可以用代理，或者用block来接收，以下是block的传值
    //获取账户信息
    SHAccountHome *accountHome = [SHAccountTool account];
    //获取图片model
    SHImageModel *imageModel = [SHImageTool imageModel];
    CYAccount *cyAccount = [CYAccountTool account];
    NSMutableArray *photoUrlArr = [NSMutableArray arrayWithArray:accountHome.photoUrlArray];
    __weak typeof(self) weakSelf = self;
    pickerVc.callBack = ^(NSArray<ZLPhotoAssets *> *status){
        for (ZLPhotoAssets *photoAssets in status) {
            [weakSelf.photoArr addObject:photoAssets.originImage];
            //添加图片到photoArray中
            imageModel.photosArr = weakSelf.photoArr;
            //保存到沙盒上传到云端
            if (cyAccount.accountHomeObjID) {
                NSData *imageData = UIImagePNGRepresentation(photoAssets.originImage);
                AVFile *file = [AVFile fileWithName:@"photoImage.png" data:imageData];
                [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        [photoUrlArr addObject:file.url];
                        accountHome.photoUrlArray = photoUrlArr;
                        //上传到云端
                        AVObject *accountAV = [AVObject objectWithoutDataWithClassName:@"SHAccountHome" objectId:cyAccount.accountHomeObjID];
                        [accountAV setObject:accountHome.mj_keyValues forKey:@"accountHome"];
                        [accountAV saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                            if (succeeded) {
                                //存储到本地
                                CYLog(@"存储相册图片成功");
                                //存储到沙盒
                                [SHAccountTool saveAccount:accountHome];
                                [SHImageTool saveImageModel:imageModel];
                            }
                        }];
                    }
                    }
                ];
            }
        }
        [weakSelf.collectionView reloadData];
        [SHAccountTool saveAccount:accountHome];
        [SHImageTool saveImageModel:imageModel];
    };
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photoArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SHPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    UIImage *photoImage = self.photoArr[indexPath.row];
    cell.photoImageView.image = photoImage;
    if (self.cellState == NormalState) {
        cell.selectBtn.hidden = YES;
    }else{
        cell.selectBtn.hidden = NO;
        [cell.selectBtn addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    cell.selectBtn.selected = NO;
    return cell;
}


- (void)selectBtnAction:(UIButton *)button{
    button.selected = !button.selected;
    UICollectionViewCell *cell = (UICollectionViewCell *)button.superview.superview;
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    
//    UIImage *image = self.photoArr[indexPath.row];

    if (button.selected) {
        [self.selectPhotoArr addObject:indexPath];
    }else{
        [self.selectPhotoArr removeObject:indexPath];
    }

    if (self.selectPhotoArr.count) {
        [self.toolBarView.deleteBtn setEnabled:YES];
        [self.toolBarView.deleteBtn setTitle:[NSString stringWithFormat:@"删除(%ld)",self.selectPhotoArr.count] forState:UIControlStateNormal];
    }else{
        [self.toolBarView.deleteBtn setEnabled:NO];
    }
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SHPhotoCollectionViewCell *cell = (SHPhotoCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    if (!cell.selectBtn.hidden) {
        [self selectBtnAction:cell.selectBtn];
    }else{
        // 图片游览器
        ZLPhotoPickerBrowserViewController *pickerBrowser = [[ZLPhotoPickerBrowserViewController alloc] init];
        // 淡入淡出效果
        // pickerBrowser.status = UIViewAnimationAnimationStatusFade;
        // 数据源/delegate
        pickerBrowser.editing = YES;
        pickerBrowser.photos = self.photoArr;
        // 能够删除
        pickerBrowser.delegate = self;
        // 当前选中的值
        pickerBrowser.currentIndex = indexPath.row;
        // 展示控制器
        [pickerBrowser showPickerVc:self];
    }
    return;
}

- (void)photoBrowser:(ZLPhotoPickerBrowserViewController *)photoBrowser removePhotoAtIndex:(NSInteger)index{
    if (self.photoArr.count > index) {
        [self.photoArr removeObjectAtIndex:index];
        //获取账户信息
        SHAccountHome *accountHome = [SHAccountTool account];
        //删除图片到photoUrlArray中
        [accountHome.photoUrlArray removeObjectAtIndex:index];
        //获取图片model
        SHImageModel *imageModel = [SHImageTool imageModel];
        imageModel.photosArr = self.photoArr;
        
        CYAccount *cyAccount = [CYAccountTool account];
        //上传到云端
        if (cyAccount.accountHomeObjID) {
            AVObject *accountAV = [AVObject objectWithoutDataWithClassName:@"SHAccountHome" objectId:cyAccount.accountHomeObjID];
            [accountAV setObject:accountHome.mj_keyValues forKey:@"accountHome"];
            [accountAV saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    //存储到本地
                    CYLog(@"存储相册图片成功");
                    //存储到沙盒
                    [SHAccountTool saveAccount:accountHome];
                    [SHImageTool saveImageModel:imageModel];
                }
            }];
        }
        [SHAccountTool saveAccount:accountHome];
        [SHImageTool saveImageModel:imageModel];

        [self.collectionView reloadData];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    //info中包含了选择的图片
    UIImage *image = info[UIImagePickerControllerEditedImage];
    //添加图片到photosView中
    //获取账户信息
    SHAccountHome *accountHome = [SHAccountTool account];
    //获取图片model
    SHImageModel *imageModel = [SHImageTool imageModel];
    CYAccount *cyAccount = [CYAccountTool account];
    NSMutableArray *photoUrlArr = [NSMutableArray arrayWithArray:accountHome.photoUrlArray];
    [self.photoArr addObject:image];
    
    //添加图片到photoArray中
    imageModel.photosArr = self.photoArr;
    
    //保存到沙盒上传到云端
    if (cyAccount.accountHomeObjID) {
        NSData *imageData = UIImagePNGRepresentation(image);
        AVFile *file = [AVFile fileWithName:@"photoImage.png" data:imageData];
        [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [photoUrlArr addObject:file.url];
                accountHome.photoUrlArray = photoUrlArr;
                //上传到云端
                AVObject *accountAV = [AVObject objectWithoutDataWithClassName:@"SHAccountHome" objectId:cyAccount.accountHomeObjID];
                [accountAV setObject:accountHome.mj_keyValues forKey:@"accountHome"];
                [accountAV saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        //存储到本地
                        CYLog(@"存储相册图片成功");
                        //存储到沙盒
                        [SHAccountTool saveAccount:accountHome];
                        [SHImageTool saveImageModel:imageModel];
                    }
                }];
            }
        }
         ];
    }
    [self.collectionView reloadData];
    [SHAccountTool saveAccount:accountHome];
    [SHImageTool saveImageModel:imageModel];

}


@end
