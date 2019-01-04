//
//  SNDotView.h
//  SDCycleScrollView
//
//  Created by ios-spec on 2019/1/4.
//  Copyright © 2019 GSD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SNDotView : UIView

@property (nonatomic, strong) UIColor *dotColor;
@property (nonatomic, strong) UIColor *selectedDotColor;

@property (nonatomic, assign) CGSize dotSize;
@property (nonatomic, assign) CGSize selectedDotSize;

@property (nonatomic) NSInteger spacingBetweenDots;

- (void)changeActivityState:(BOOL)active currentPage:(NSInteger)currentPage index:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
