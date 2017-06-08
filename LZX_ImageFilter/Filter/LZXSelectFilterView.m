//
//  LZXSelectFilterView.m
//  LZXCameraFilters/Users/twzs/Desktop/wanwan/LZX_ImageFilter/LZX_ImageFilter
//
//  Created by twzs on 2017/6/8.
//  Copyright © 2017年 LZX. All rights reserved.
//

#import "LZXSelectFilterView.h"

#import "LZXImageFilter.h"

static NSString *cellIdentifier = @"Identifier";

@interface LZXSelectFilterView ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>

@property (nonatomic, weak) UICollectionView  *collectionView;

@property (nonatomic, strong) NSArray  *filterNameArray;

@end

@implementation LZXSelectFilterView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (NSArray *)filterNameArray {
    /*
     CIPhotoEffectChrome,(铭黄色)
     CIPhotoEffectFade,(褪色)
     CIPhotoEffectInstant,(怀旧)
     CIPhotoEffectMono,(单色)
     CIPhotoEffectNoir,(黑白)
     CIPhotoEffectProcess,(冲印)
     CIPhotoEffectTonal,(色调)
     CIPhotoEffectTransfer,(岁月)
     */
    if (!_filterNameArray) {
        NSArray *filterNameArray = @[@"CIPhotoEffectChrome",@"CIPhotoEffectFade",@"CIPhotoEffectInstant",@"CIPhotoEffectMono",@"CIPhotoEffectNoir",@"CIPhotoEffectProcess",@"CIPhotoEffectTonal",@"CIPhotoEffectTransfer"];
        _filterNameArray = filterNameArray;
    }
    return _filterNameArray;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
}

- (void)setupUI {
    
    UICollectionView *collectionView = ({
    
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(88, 132);
        layout.minimumLineSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView;
    });
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.filterNameArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    UIImageView *bgImage = [[UIImageView alloc]initWithFrame:cell.bounds];
    bgImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",indexPath.row]];
    cell.backgroundView = bgImage;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.filterImageBlock([[LZXImageFilter new]outputImageWithFilterName:self.filterNameArray[indexPath.row] OldImage:self.filterImage]);
}

@end
