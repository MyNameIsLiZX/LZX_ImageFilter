//
//  LZXImageFilter.m
//  LZX_ImageFilter
//
//  Created by twzs on 2017/6/8.
//  Copyright © 2017年 LZX. All rights reserved.
//

#import "LZXImageFilter.h"

@implementation LZXImageFilter

- (UIImage *)outputImageWithFilterName:(NSString *)filterName OldImage:(UIImage *)oldImage {
    // 创建基于GPU的CIContext对象
    CIContext *ctx = [CIContext contextWithOptions:nil];
    // 创建过滤器
    CIFilter *filter = [CIFilter filterWithName:filterName];
    // 转换image对象
    CIImage *ciImage = [[CIImage alloc]initWithImage:oldImage];
    // 过滤ciImage
    [filter setValue:ciImage forKey:kCIInputImageKey];
    // 输出过滤后的image
    CIImage *newCiimage = [filter outputImage];
    // 转换对象为CGImageRef
    CGImageRef newImageRef = [ctx createCGImage:newCiimage fromRect:[ciImage extent]];
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    // 释放c语音指针, 防止内存泄露
    CGImageRelease(newImageRef);
    
    
    return newImage;
}


@end
