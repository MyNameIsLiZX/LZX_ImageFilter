//
//  LZXImageSaved.m
//  LZX_ImageFilter
//
//  Created by twzs on 2017/6/8.
//  Copyright © 2017年 LZX. All rights reserved.
//

#import "LZXImageSaved.h"

@implementation LZXImageSaved

- (void)savedImage:(UIImage *)image {
    /**
     *  C语言方法  把图片保存到 相机胶卷
     *
     *  @param imageview.image                             将要保存的图片
     *  @param self                                        指定执行者(谁来执行该方法)
     *  @param image:didFinishSavingWithError:contextInfo: 绑定触发事件(苹果规定的固定格式)
     *  @contextInfo                                       要往方法中传入的参数(不传就填nil)
     *
     */
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        NSLog(@"保存图片失败");
    } else {
        NSLog(@"保存图片成功");
    }
}

@end
