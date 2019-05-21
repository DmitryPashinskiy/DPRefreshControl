//
//  UIScrollView+DPRefreshControl.h
//  DPRefrshControl
//
//  Created by Dmitry Pashinskiy on 2/15/16.
//  Copyright © 2016 Dmitry Pashinskiy All rights reserved.
//

#import "DPPullToRefresh.h"
#import "DPInfiniteScroll.h"
@import UIKit;



@interface UIScrollView (DPRefreshControl)

/**
 @brief property of the current refreshControl,
 read DPRefreshControl documentation to see more posibilities.
 */
@property (strong, nonatomic, readonly) DPPullToRefresh *dp_pullToRefresh;

@property (strong, nonatomic, readonly) DPPullToRefresh *dp_bottomPullToRefresh;

@property (strong, nonatomic, readonly) DPInfiniteScroll *dp_infiniteRefresh;



#pragma mark - Adding PullToRefresh
// by default will add refresher to TOP
- (void)dp_addPullToRefreshWithHandler:(DPRefreshHandler)handler;
- (void)dp_addPullToRefreshWithHandler:(DPRefreshHandler)handler type:(DPRefreshType)type;
- (void)dp_addPullToRefreshWithHandler:(DPRefreshHandler)handler animation:(DPRefreshAnimation*)animation;

- (void)dp_addBottomPullToRefreshWithHandler:(DPRefreshHandler)handler;
- (void)dp_addBottomPullToRefreshWithHandler:(DPRefreshHandler)handler type:(DPRefreshType)type;
- (void)dp_addBottomPullToRefreshWithHandler:(DPRefreshHandler)handler animation:(DPRefreshAnimation*)animation;



#pragma mark - Adding InfiniteRefresh
- (void)dp_addInfiniteRefreshWithHandler:(DPRefreshHandler)handler;
- (void)dp_addInfiniteRefreshWithHandler:(DPRefreshHandler)handler type:(DPRefreshType)type;
- (void)dp_addInfiniteRefreshWithHandler:(DPRefreshHandler)handler animation:(DPRefreshAnimation*)animation;



#pragma mark - Manage Behaviour
- (void)dp_stopRefresh;

@end
