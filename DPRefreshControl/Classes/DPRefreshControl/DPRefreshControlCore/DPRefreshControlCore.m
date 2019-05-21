//
//  DPRefreshControl.m
//  DPRefrshControl
//
//  Created by Dmitry Pashinskiy on 1/27/16.
//  Copyright © 2016 Dmitry Pashinskiy All rights reserved.
//

#import "DPRefreshControlCore.h"
#import "DPRefreshView.h"
#import "DPRefreshAnimationFactory.h"
#import "DPRefreshControlCore_Protected.h"
#import "DPAppearance.h"



@implementation DPRefreshControlCore 


#pragma mark - setters && getters

- (void)setRefreshAnimation:(DPRefreshAnimation *)refreshAnimation {
    NSParameterAssert(refreshAnimation);
    
    _refreshAnimation = refreshAnimation.copy;
    
    _loadingView = [_refreshAnimation sceneForAnimation];
    [_refreshView addSubview:_loadingView];
    
    _loadingViewSize = _loadingView.frame.size;
    
    _additionAnimationOffset = [_refreshAnimation additionAnimationOffset];
    _offsetForReload         = [_refreshAnimation offsetForReload];
    
    self.animationState = DPAnimationState_Ready;
    
    [self updateFrames];
}

- (void)setEnabled:(BOOL)enabled {
    _enabled = enabled;
    [self stopRefresh];
    
    [UIView animateWithDuration:kDPInsetsAnimationDuration
                     animations:^{
                         self.refreshView.alpha = enabled ? 1.0f : 0.0f;
    }];
    
    if ( enabled ) {
        [self addObservers];
    } else {
        [self removeObservers];
    }
}

- (void)setAnimationState:(DPAnimationState)animationState {
    switch (animationState) {
        case DPAnimationState_NotReady:
            break;
            
        case DPAnimationState_Ready:
            [self.refreshAnimation setAnimationToDefaultState];
            break;
            
        case DPAnimationState_Animated:{
            [self.refreshAnimation setStretchPercent:1.0f];
            [self.refreshAnimation setUpAnimations];
        }
            break;
            
        case DPAnimationState_StopAnimated:
            break;
            
            
        default:
            break;
    }
    
    _animationState = animationState;
}

- (CGFloat)originalRefreshViewHeight {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    return MAX(screenSize.height, screenSize.width);
}

- (BOOL)isContentSizeBigger {
    return self.scrollView.contentSize.height > self.scrollView.bounds.size.height;
}

- (CGFloat)insetHeightForBound {
    return _loadingView.bounds.size.height + _additionAnimationOffset;
}



#pragma mark - Public Methods

- (instancetype)initWithScrollView:(UIScrollView *)scrollView {
    return [self initWithScrollView:scrollView bottomPosition:NO];
}

- (instancetype)initWithScrollView:(UIScrollView *)scrollView bottomPosition:(BOOL)isBottom {
    self = [super init];
    if (self) {
        
        // defaults
        _additionAnimationOffset = kDPDefaultAddingOffsetAppear;
        _offsetForReload         = kDPDefaultOffsetForReload;
        _isBottomPosition        = isBottom;
        
        _enabled = YES;
        self.animationState = DPAnimationState_NotReady;
        
        _scrollView = scrollView;
        _refreshView = [DPRefreshView new];
        _refreshView.delegate = self;
        [_scrollView insertSubview:_refreshView atIndex:0];
        
        [self updateFrames];
        [self addObservers];
        
        DPAppearance *appearance = [DPAppearance appearanceForClass:[self class]];
        [appearance startForwarding:self];
        
        if (!_refreshAnimation) {
            self.refreshAnimation = DPRefreshAnimationWithType(DPRefreshType_Default);
        }
    }
    return self;
}

- (void)dealloc {
    [self removeObservers];
}

- (void)setBackgroundColor:(UIColor*)backgroundColor {
    _refreshView.backgroundColor = backgroundColor;
}

- (void)startRefresh {
    // check animation instance existing
    NSParameterAssert( self.refreshAnimation );
    
    // check is already refreshing
    if (_isRefreshing) {
        return;
    }
    _isRefreshing = YES;
    
    if (_handler) {
        _handler();
    }

    self.animationState = DPAnimationState_Animated;
    //TODO: if startRefresh will be moved to public, add logic to makeInsets
}

- (void)stopRefresh {

}

- (void)updateFrames {

}



#pragma mark - UIAppearance
+ (instancetype)appearance {
    return [DPAppearance appearanceForClass:[self class]];
}



#pragma mark - Selectors

- (void)orientationDidChange:(NSNotification*)notification {
    [self updateFrames];
}



#pragma mark - DPRefreshViewDelegate

- (void)refreshViewWillBeRemoved:(DPRefreshView*)refreshView {
    [self removeObservers];
}

- (void)refreshViewWillBeAdded:(DPRefreshView*)refreshView {
    [self addObservers];
}



#pragma mark - Private Methods


@end



#pragma mark - KVO handling

@implementation DPRefreshControlCore (WorkWithKVO)

- (void)addObservers {
    if (!_observersAdded && _scrollView) {
        _observersAdded = YES;
        
        [_scrollView addObserver:self
                      forKeyPath:kDPObserverKeyScrollContentOffset
                         options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionPrior
                         context:NULL];
        
        [_scrollView addObserver:self
                      forKeyPath:kDPObserverKeyScrollContentSize
                         options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                         context:NULL];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(orientationDidChange:)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:nil];
    }
}

- (void)removeObservers {
    if ( _observersAdded ) {
        _observersAdded = NO;
        
        [_scrollView removeObserver:self forKeyPath:kDPObserverKeyScrollContentOffset];
        [_scrollView removeObserver:self forKeyPath:kDPObserverKeyScrollContentSize];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:kDPObserverKeyScrollContentSize]) {
        [self contentSizeKeyPath];
        
    } else if ([keyPath isEqualToString:kDPObserverKeyScrollContentOffset]) {
        [self contentOffsetKeyPath];
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}



#pragma mark Helper methods to handle KVO keyPaths

- (void)contentSizeKeyPath {
    
}

- (void)contentOffsetKeyPath {
    
}


/**
 @brief will return value of scroll view, when scroll will move out of bounds,
    offset will be calculate from 0 and grather.
 */
- (CGFloat)offsetForHandleAnimation {
    @throw [NSException exceptionWithName:@"Architecture has been a violation" reason:@"Abstract method was called" userInfo:nil];
}

@end

