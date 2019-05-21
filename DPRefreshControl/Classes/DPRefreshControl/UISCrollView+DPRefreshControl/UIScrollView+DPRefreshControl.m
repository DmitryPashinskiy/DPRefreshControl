//
//  UIScrollView+DPRefreshControl.m
//  DPRefrshControl
//
//  Created by Dmitry Pashinskiy on 2/15/16.
//  Copyright © 2016 Dmitry Pashinskiy All rights reserved.
//

#import "UIScrollView+DPRefreshControl.h"
#import <objc/runtime.h>

// keys for associated objects
static NSString * const kDPAssocatedKeyPullToRefresh       = @"DPAssocatedKeyPullToRefresh";
static NSString * const kDPAssocatedKeyBottomPullToRefresh = @"DPAssocatedKeyBottomPullToRefresh";
static NSString * const kDPAssocatedKeyInfiniteRefresh     = @"DPAssocatedKeyInfiniteRefresh";



@implementation UIScrollView (DPRefreshControl)



#pragma mark - setters && getters
#pragma mark setters
- (void)setdp_pullToRefresh:(DPPullToRefresh *)dp_pullToRefresh {
    objc_setAssociatedObject(self,
                             &kDPAssocatedKeyPullToRefresh,
                             dp_pullToRefresh,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setdp_bottomPullToRefresh:(DPPullToRefresh *)dp_bottomPullToRefresh {
    objc_setAssociatedObject(self,
                             &kDPAssocatedKeyBottomPullToRefresh,
                             dp_bottomPullToRefresh,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setdp_infiniteRefresh:(DPInfiniteScroll *)dp_infiniteRefresh {
    objc_setAssociatedObject(self,
                             &kDPAssocatedKeyInfiniteRefresh,
                             dp_infiniteRefresh,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark getters

- (DPPullToRefresh *)dp_pullToRefresh {
    return objc_getAssociatedObject(self, &kDPAssocatedKeyPullToRefresh);
}

- (DPPullToRefresh *)dp_bottomPullToRefresh {
    return objc_getAssociatedObject(self, &kDPAssocatedKeyBottomPullToRefresh);
}

- (DPInfiniteScroll *)dp_infiniteRefresh {
    return objc_getAssociatedObject(self, &kDPAssocatedKeyInfiniteRefresh);
}



#pragma mark - Adding PullToRefresh
#pragma mark Top pull to refresh
- (void)dp_addPullToRefreshWithHandler:(DPRefreshHandler)handler {
    DPPullToRefresh *refresher = [[DPPullToRefresh alloc] initWithScrollView:self];
    refresher.handler = handler;
    [self setdp_pullToRefresh:refresher];
}

- (void)dp_addPullToRefreshWithHandler:(DPRefreshHandler)handler type:(DPRefreshType)type {
    [self dp_addPullToRefreshWithHandler:handler animation:DPRefreshAnimationWithType(type)];
}

- (void)dp_addPullToRefreshWithHandler:(DPRefreshHandler)handler animation:(DPRefreshAnimation*)animation {
    [self dp_addPullToRefreshWithHandler:handler];
    [self.dp_pullToRefresh setRefreshAnimation:animation];
}

#pragma mark Bottom pull to refresh
- (void)dp_addBottomPullToRefreshWithHandler:(DPRefreshHandler)handler {
    DPPullToRefresh *refresher = [[DPPullToRefresh alloc] initWithScrollView:self bottomPosition:YES];
    refresher.handler = handler;
    [self setdp_bottomPullToRefresh:refresher];
}

- (void)dp_addBottomPullToRefreshWithHandler:(DPRefreshHandler)handler type:(DPRefreshType)type {
    [self dp_addBottomPullToRefreshWithHandler:handler animation:DPRefreshAnimationWithType(type)];
}

- (void)dp_addBottomPullToRefreshWithHandler:(DPRefreshHandler)handler animation:(DPRefreshAnimation*)animation {
    [self dp_addBottomPullToRefreshWithHandler:handler];
    [self.dp_bottomPullToRefresh setRefreshAnimation:animation];
}



#pragma mark - Adding InfiniteRefresh

- (void)dp_addInfiniteRefreshWithHandler:(DPRefreshHandler)handler {
    DPInfiniteScroll *refresher = [[DPInfiniteScroll alloc] initWithScrollView:self];
    refresher.handler = handler;
    [self setdp_infiniteRefresh:refresher];
}

- (void)dp_addInfiniteRefreshWithHandler:(DPRefreshHandler)handler type:(DPRefreshType)type {
    [self dp_addInfiniteRefreshWithHandler:handler animation:DPRefreshAnimationWithType(type)];
}

- (void)dp_addInfiniteRefreshWithHandler:(DPRefreshHandler)handler animation:(DPRefreshAnimation*)animation {
    [self dp_addInfiniteRefreshWithHandler:handler];
    [self.dp_infiniteRefresh setRefreshAnimation:animation];
}



#pragma mark - Manage Behaviour
- (void)dp_stopRefresh {
    [self.dp_pullToRefresh stopRefresh];
    [self.dp_bottomPullToRefresh stopRefresh];
    [self.dp_infiniteRefresh stopRefresh];
}




@end
