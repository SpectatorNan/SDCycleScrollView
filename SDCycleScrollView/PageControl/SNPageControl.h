//
//  SNPageControl.h
//  SDCycleScrollView
//
//  Created by ios-spec on 2019/1/4.
//  Copyright © 2019 GSD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SNPageControl : UIControl

@property (nonatomic, strong) UIColor *dotColor;
@property (nonatomic, strong) UIColor *selectedDotColor;

@property (nonatomic, assign) CGSize dotSize;
@property (nonatomic, assign) CGSize selectedDotSize;

@property (nonatomic) NSInteger spacingBetweenDots;

@property (nonatomic) NSInteger numberOfPages;

@property (nonatomic) NSInteger currentPage;

@property (nonatomic) BOOL hidesForSinglePage;

@property (nonatomic) BOOL shouldResizeFromCenter;

- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount;

@end

NS_ASSUME_NONNULL_END
