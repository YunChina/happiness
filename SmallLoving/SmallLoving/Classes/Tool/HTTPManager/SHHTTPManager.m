//
//  SHHTTPManager.m
//  SmallLoving
//
//  Created by xIang on 16/4/6.
//  Copyright © 2016年 Cheney. All rights reserved.
//

#import "SHHTTPManager.h"
#import <AVQuery.h>
#import "CYAccount.h"
#import "CYAccountTool.h"
#import "SHAccountTool.h"
#import "SHImageTool.h"
#import <MJExtension.h>
#import "CYOtherAccountTool.h"


@implementation SHHTTPManager
+ (SHHTTPManager *)shareHTTPManager{
    static SHHTTPManager *shareHM = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareHM = [[SHHTTPManager alloc] init];
    });
    return shareHM;
}


- (void)synchronizationAccountWithCyAccount:(CYAccount *)cyAccount{
    AVQuery *query = [CYAccount query];
    self.cyAccount = cyAccount;
    __weak typeof(self) weakSelf = self;
    [query whereKey:@"userName" equalTo:cyAccount.userName];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            weakSelf.cyAccount = [objects objectAtIndex:0];
            //同步home数据到本地
            AVQuery *query = [AVQuery queryWithClassName:@"SHAccountHome"];
            [query getObjectInBackgroundWithId:weakSelf.cyAccount.accountHomeObjID block:^(AVObject *object, NSError *error) {
                NSDictionary *accountHomeDic = [object objectForKey:@"accountHome"];
                SHAccountHome *accountHome = [SHAccountTool account];
                accountHome = [SHAccountHome mj_objectWithKeyValues:accountHomeDic];
                
                SHImageModel *imageModel = [SHImageTool imageModel];
                if (accountHome.photoUrlArray) {
                    dispatch_async(dispatch_get_global_queue(0, 0), ^{
                        NSMutableArray *photoArr = [NSMutableArray array];
                        for (NSString *photoUrl in accountHome.photoUrlArray) {
                            NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:photoUrl]];
                            [photoArr addObject:[UIImage imageWithData:data]];
                        }
                        CYLog(@"同步云端相册成功");
                        imageModel.photosArr = photoArr;
                        [SHImageTool saveImageModel:imageModel];
                    });
                }
                [SHImageTool saveImageModel:imageModel];
                [SHAccountTool saveAccount:accountHome];
                dispatch_async(dispatch_get_main_queue(), ^{
                    //让C中刷新界面
                    weakSelf.reloadDataBlock();
                });
                CYLog(@"同步首页数据成功");
                [CYAccountTool saveAccount:weakSelf.cyAccount];
                if (weakSelf.cyAccount.otherUserName) {
                    AVQuery *query = [CYAccount query];
                    [query whereKey:@"userName" equalTo:weakSelf.cyAccount.otherUserName];
                    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                        if (!error) {
                            CYAccount *otherAccount = [objects objectAtIndex:0];
                            [CYOtherAccountTool saveOtherAccount:otherAccount];
                        }
                    }];
                }
            }];
        }
    }];

}

@end
