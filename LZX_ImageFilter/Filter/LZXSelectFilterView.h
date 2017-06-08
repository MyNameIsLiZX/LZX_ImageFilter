//
//  LZXSelectFilterView.h
//  LZXCameraFilters
//
//  Created by twzs on 2017/6/8.
//  Copyright © 2017年 LZX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZXSelectFilterView : UIView
/** 原图 */
@property (nonatomic, strong) UIImage  *filterImage;
/** 返回滤镜后的图片 */
@property (nonatomic, copy) void(^filterImageBlock)(UIImage *image);

@end
