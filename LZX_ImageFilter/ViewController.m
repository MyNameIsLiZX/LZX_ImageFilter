//
//  ViewController.m
//  LZX_ImageFilter
//
//  Created by twzs on 2017/6/8.
//  Copyright © 2017年 LZX. All rights reserved.
//

#import "ViewController.h"

#import "LZXSelectFilterView.h"
#import "LZXImageSaved.h"

@interface ViewController ()
<
UIImagePickerControllerDelegate,
UINavigationControllerDelegate
>

@property (nonatomic, weak) UIImageView  *filterImage;

@property (nonatomic, weak) LZXSelectFilterView  *selectFilterView;

@property (nonatomic, strong) UIImagePickerController  *pickerVC;


@end

@implementation ViewController


- (UIImagePickerController *)pickerVC {
    if (!_pickerVC) {
        UIImagePickerController *picker = [UIImagePickerController new];
        picker.delegate = self;
        picker.allowsEditing = YES;
        _pickerVC = picker;
    }
    return _pickerVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = ({
        UIImageView *imageView = [UIImageView new];
        imageView.image = [UIImage imageNamed:@"timg-2"];
        [imageView sizeToFit];
        imageView;
    });
    [self.view addSubview:imageView];
    self.filterImage = imageView;
    
    [self imageSize];
    
    LZXSelectFilterView *selectFilter = ({
        LZXSelectFilterView *selectFilter = [[LZXSelectFilterView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 152)];;
        selectFilter.filterImage = self.filterImage.image;
        selectFilter.filterImageBlock = ^(UIImage *image){
            self.filterImage.image = image;
        };
        selectFilter;
    });
    [self.view addSubview:selectFilter];
    self.selectFilterView = selectFilter;
    
    UISegmentedControl *segment = ({
        UISegmentedControl *segment= [[UISegmentedControl alloc]initWithItems:@[@"选择滤镜",@"相册选图",@"现场拍照",@"保存到相册",@"取消滤镜"]];
        segment.frame = CGRectMake(10, 50, self.view.frame.size.width-20, 30);
        [segment addTarget:self action:@selector(segmentClickEvent:) forControlEvents:UIControlEventValueChanged];
        segment.tintColor = [UIColor redColor];
        segment;
    });
    [self.view addSubview:segment];
}

- (void)segmentClickEvent:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0: {
            NSLog(@"选择滤镜");
            [UIView animateWithDuration:0.5 animations:^{
                self.selectFilterView.frame = CGRectMake(0, self.view.bounds.size.height-152, self.view.bounds.size.width, 152);
            }];
        }
            break;
        case 1: {
            NSLog(@"相册选图");
            self.pickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:self.pickerVC animated:YES completion:nil];
        }
            break;
        case 2: {
            NSLog(@"现场拍照");
            self.pickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:self.pickerVC animated:YES completion:nil];
        }
            break;
        case 3: {
            NSLog(@"保存到相册");
            [[LZXImageSaved new] savedImage:self.filterImage.image];
        }
            break;
        default: {
            NSLog(@"点击了UISegmentedControl控件");
            [UIView animateWithDuration:0.5 animations:^{
                self.selectFilterView.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 152);
            }];
        }
            break;
    }
}

- (void)imageSize {
    
    float scale = 0;
    if (self.filterImage.bounds.size.width > self.view.bounds.size.width) {
        scale = self.filterImage.bounds.size.width/self.view.bounds.size.width;
    } else if (self.filterImage.bounds.size.height > self.view.bounds.size.height) {
        scale = self.filterImage.bounds.size.height/self.view.bounds.size.height;
    }
    scale == 0 ? [self.filterImage sizeToFit] : (self.filterImage.frame = CGRectMake(0, 0, self.filterImage.bounds.size.width/scale, self.filterImage.bounds.size.height/scale));
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.selectFilterView.filterImage = image;
    self.filterImage.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
