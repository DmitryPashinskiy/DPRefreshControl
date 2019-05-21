//
//  DPRefreshControlCore_Protected.h
//  DPRefrshControl
//
//  Created by Dmitry Pashinskiy on 5/10/16.
//  Copyright © 2016 Dmitry Pashinskiy All rights reserved.
//

#import "DPRefreshControlCore.h"

@interface DPRefreshControlCore () <DPRefreshViewDelegate>

@property (weak, nonatomic) UIScrollView     *scrollView;

@property (strong, nonatomic) DPRefreshView *refreshView;
@property (strong, nonatomic) UIView *loadingView;
@property (assign, nonatomic) CGSize loadingViewSize;

@property (assign, nonatomic) DPAnimationState animationState;

/**
 @brief addition to offset animation.
 animation offset to top bounds and bottom bounds
 */
@property (assign, nonatomic) CGFloat additionAnimationOffset;;

/// offset to indicate when refresh should begin.
@property (assign, nonatomic) CGFloat offsetForReload;

@property (assign, nonatomic) BOOL observersAdded;
@property (assign, nonatomic) BOOL isRefreshing;

@property (assign, nonatomic) BOOL isBottomPosition;

@property (assign, nonatomic, readonly) CGFloat insetHeightForBound;
@property (assign, nonatomic, readonly) BOOL isContentSizeBigger;

@property (assign, nonatomic, readonly) CGFloat originalRefreshViewHeight;

@property (assign, nonatomic) UIEdgeInsets originalEdgeInsents;


- (void)startRefresh;
- (void)stopRefresh;

- (void)updateFrames;


@end


@interface DPRefreshControlCore (WorkWithKVO)
- (void)addObservers;
- (void)removeObservers;

- (void)contentSizeKeyPath;
- (void)contentOffsetKeyPath;

- (CGFloat)offsetForHandleAnimation;
@end
