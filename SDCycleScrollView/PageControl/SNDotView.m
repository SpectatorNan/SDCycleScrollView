//
//  SNDotView.m
//  SDCycleScrollView
//
//  Created by ios-spec on 2019/1/4.
//  Copyright © 2019 GSD. All rights reserved.
//

#import "SNDotView.h"

static CGFloat const kAnimateDuration = 1;

@implementation SNDotView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialization];
    }

    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialization];
    }

    return self;
}

- (void)setDotColor:(UIColor *)dotColor
{
    _dotColor = dotColor;
//    self.layer.borderColor  = dotColor.CGColor;
}



- (void)initialization
{
    _dotColor = [UIColor grayColor];
    _selectedDotColor = [UIColor whiteColor];
    self.backgroundColor    = _dotColor;
    self.layer.cornerRadius = CGRectGetHeight(self.frame) / 2;
    self.dotSize = self.frame.size;

}

- (void)changeActivityState:(BOOL)active currentPage:(NSInteger)currentPage index:(NSInteger)index
{
    if (active) {
        [self animateToActiveStateWithIndex:index currentPage:currentPage];
    } else {
        [self animateToDeactiveState:index currentPage:currentPage];
    }
}


- (void)animateToActiveStateWithIndex:(NSInteger)index currentPage:(NSInteger)currentPage
{
    self.backgroundColor = self.selectedDotColor;
//    self.transform = CGAffineTransformMakeScale(1.4, 1.4);
    CGRect frame = [self calculateFrameWithIndex:index currentPage:currentPage];
    self.frame = frame;
//    [UIView animateWithDuration:kAnimateDuration delay:0 usingSpringWithDamping:.5 initialSpringVelocity:-20 options:UIViewAnimationOptionCurveLinear animations:^{
//        self.backgroundColor = self.selectedDotColor;
//        self.transform = CGAffineTransformMakeScale(1.4, 1.4);
//        CGRect frame = self.frame;
//        frame.size = self.selectedDotSize;
//        self.frame = frame;
//    } completion:nil];
}

- (void)animateToDeactiveState:(NSInteger)index currentPage:(NSInteger)currentPage
{

    self.backgroundColor = self.dotColor;
//    self.transform = CGAffineTransformIdentity;
    CGRect frame = [self calculateFrameWithIndex:index currentPage:currentPage];
//    frame.size = self.dotSize;
    self.frame = frame;
//    [UIView animateWithDuration:kAnimateDuration delay:0 usingSpringWithDamping:.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
//        self.backgroundColor = self.dotColor;
//        self.transform = CGAffineTransformIdentity;
//        CGRect frame = self.frame;
//        frame.size = self.dotSize;
//        self.frame = frame;
//    } completion:nil];
}

- (CGRect)calculateFrameWithIndex:(NSInteger)index currentPage:(NSInteger)currentPage {
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = 0;
    CGFloat height = 0;

    y = (CGRectGetHeight(self.frame) - self.dotSize.height) / 2;

    if (index == currentPage) {
        x = (self.dotSize.width + self.spacingBetweenDots) * index;
        width = self.selectedDotSize.width;
        height = self.selectedDotSize.height;
    } else if (index < currentPage) {
        x = (self.dotSize.width + self.spacingBetweenDots) * index;
        width = self.dotSize.width;
        height = self.dotSize.height;
    } else {
        x = (self.dotSize.width + self.spacingBetweenDots) * (index - 1) + self.spacingBetweenDots + self.selectedDotSize.width;
        width = self.dotSize.width;
        height = self.dotSize.height;
    }

    return CGRectMake(x, y, width, height);
}

@end
