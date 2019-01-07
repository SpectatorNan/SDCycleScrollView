//
//  SNPageControl.m
//  SDCycleScrollView
//
//  Created by ios-spec on 2019/1/4.
//  Copyright © 2019 GSD. All rights reserved.
//

#import "SNPageControl.h"
#import "SNDotView.h"

static NSInteger const kDefaultNumberOfPages = 0;

static NSInteger const kDefaultCurrentPage = 0;

static BOOL const kDefaultHideForSinglePage = NO;

static BOOL const kDefaultShouldResizeFromCenter = YES;

static NSInteger const kDefaultSpacingBetweenDots = 8;

static CGSize const kDefaultDotSize = {8, 8};

@interface SNPageControl()

@property (strong, nonatomic) NSMutableArray *dots;

@end

@implementation SNPageControl

#pragma mark - init

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialization];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {

    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialization];
    }

    return self;
}

- (void)initialization
{
//    self.dotViewClass           = [TAAnimatedDotView class];
    self.spacingBetweenDots     = kDefaultSpacingBetweenDots;
    self.numberOfPages          = kDefaultNumberOfPages;
    self.currentPage            = kDefaultCurrentPage;
    self.hidesForSinglePage     = kDefaultHideForSinglePage;
    self.shouldResizeFromCenter = kDefaultShouldResizeFromCenter;
}

#pragma mark - Touch event
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

}

#pragma mark - frame
- (void)sizeToFit {

     [self updateFrame: YES];
}

- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount
{
    return CGSizeMake((self.dotSize.width + self.spacingBetweenDots) * (pageCount -1) + self.selectedDotSize.width, self.dotSize.height);
}

- (void)updateDots {

    if (self.numberOfPages == 0) {
        return ;
    }

    for (NSInteger i = 0; i < self.numberOfPages; i++) {

        UIView *dot;
        if (i < self.dots.count) {
            dot = [self.dots objectAtIndex:i];
        } else {
            dot = [self generateDotView];
        }

        [self updateDotFrame: dot atIndex: i];

    }

    [self changeActivity: YES atIndex: self.currentPage];

    [self hideForSinglePage];
}

- (void)updateFrame:(BOOL)overrideExistingFrame
{
    CGPoint center = self.center;
    CGSize requiredSize = [self sizeForNumberOfPages:self.numberOfPages];

    // We apply requiredSize only if authorize to and necessary
    if (overrideExistingFrame || ((CGRectGetWidth(self.frame) < requiredSize.width || CGRectGetHeight(self.frame) < requiredSize.height) && !overrideExistingFrame)) {
        self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), requiredSize.width, requiredSize.height);
        if (self.shouldResizeFromCenter) {
            self.center = center;
        }
    }

    [self resetDotViews];
}

- (void)updateDotFrame:(UIView *)dot atIndex:(NSInteger)index
{
    // Dots are always centered within view

    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = 0;
    CGFloat height = 0;

    y = (CGRectGetHeight(self.frame) - self.dotSize.height) / 2;

    if (index == self.currentPage) {
        x = (self.dotSize.width + self.spacingBetweenDots) * index;
        width = self.selectedDotSize.width;
        height = self.selectedDotSize.height;
    } else if (index < self.currentPage) {
        x = (self.dotSize.width + self.spacingBetweenDots) * index;
        width = self.dotSize.width;
        height = self.dotSize.height;
    } else {
        x = (self.dotSize.width + self.spacingBetweenDots) * (index - 1) + self.spacingBetweenDots + self.selectedDotSize.width;
        width = self.dotSize.width;
        height = self.dotSize.height;
    }

    dot.frame = CGRectMake(x, y, width, height);
}

#pragma mark - Utils
- (UIView *)generateDotView
{

    SNDotView *dotView = [[SNDotView alloc] initWithFrame:CGRectMake(0, 0, self.dotSize.width, self.dotSize.height)];

    if (self.dotColor) {
        dotView.dotColor = self.dotColor;
    }

    if (self.selectedDotColor) {
        dotView.selectedDotColor = self.selectedDotColor;
    }

        dotView.dotSize = self.dotSize;
        dotView.selectedDotSize = self.selectedDotSize;
    dotView.spacingBetweenDots = self.spacingBetweenDots;

    if (dotView) {
        [self addSubview:dotView];
        [self.dots addObject:dotView];
    }

    dotView.userInteractionEnabled = YES;
    return dotView;
}

- (void)changeActivity:(BOOL)active atIndex:(NSInteger)index
{
    SNDotView *dotView = (SNDotView *)[self.dots objectAtIndex:index];
    [dotView changeActivityState:active];

}


- (void)resetDotViews
{
    for (UIView *dotView in self.dots) {
        [dotView removeFromSuperview];
    }

    [self.dots removeAllObjects];
    [self updateDots];
}


- (void)hideForSinglePage
{
    if (self.dots.count == 1 && self.hidesForSinglePage) {
        self.hidden = YES;
    } else {
        self.hidden = NO;
    }
}

#pragma mark - Setters


- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    _numberOfPages = numberOfPages;

    // Update dot position to fit new number of pages
    [self resetDotViews];
}


- (void)setSpacingBetweenDots:(NSInteger)spacingBetweenDots
{
    _spacingBetweenDots = spacingBetweenDots;

    [self resetDotViews];
}


- (void)setCurrentPage:(NSInteger)currentPage
{
    // If no pages, no current page to treat.
    if (self.numberOfPages == 0 || currentPage == _currentPage) {
        _currentPage = currentPage;
//        [self updateDots];
        return;
    }

    // Pre set
    [self changeActivity:NO atIndex:_currentPage];
    _currentPage = currentPage;
    // Post set
    [self changeActivity:YES atIndex:_currentPage];

//    [self resetDotViews];
    [self updateDots];
}

#pragma mark - Getters


- (NSMutableArray *)dots
{
    if (!_dots) {
        _dots = [[NSMutableArray alloc] init];
    }

    return _dots;
}


- (CGSize)dotSize
{
    if ( CGSizeEqualToSize(_dotSize, CGSizeZero)) {
        _dotSize = kDefaultDotSize;
        return _dotSize;
    }

    return _dotSize;
}

- (CGSize)selectedDotSize {

    if (CGSizeEqualToSize(_selectedDotSize, CGSizeZero)) {
        _selectedDotSize = kDefaultDotSize;
        return _selectedDotSize;
    }

    return _selectedDotSize;
}

@end
