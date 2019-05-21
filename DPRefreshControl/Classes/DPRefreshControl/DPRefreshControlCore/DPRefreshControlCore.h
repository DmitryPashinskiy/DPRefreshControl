//
//  DPRefreshControl.h
//  DPRefrshControl
//
//  Created by Dmitry Pashinskiy on 1/27/16.
//  Copyright © 2016 Dmitry Pashinskiy All rights reserved.
//

@import Foundation;
@import UIKit;

#import "DPRefreshAnimation.h"
#import "DPRefreshConstants.h"
#import "DPRefreshControlTypes.h"
#import "DPRefreshAnimationFactory.h"

typedef void (^DPRefreshHandler)();



@interface DPRefreshControlCore : NSObject <UIAppearance>

/// Will be called when refresh begin start animating
@property (copy, nonatomic) DPRefreshHandler handler;


/**
 @discussion You can use DPRefreshAnimationWithType() to create animation
 by setting a DPRefreshType, and you will get one of the default animations.
 Or you can inherits from DPRefreshAnimation and create your own animation = )
 */
@property (copy, nonatomic) __kindof DPRefreshAnimation *refreshAnimation;

/// flag to indicate status of refreshing
@property (assign, nonatomic, readonly) BOOL isRefreshing;

/// wil enabled / disable refresher
@property (assign, nonatomic) BOOL enabled;



/// stop refreshing
- (void)stopRefresh;



/**
 @brief Main constructor for creating refresh controll, after constructor
 refresh controll will be automatically added to scrollView.
 @param scrollView - receive any heirs of UIScrollView.
 @param isBottom - define position of refresh control. If NO - position will be top
 */
- (instancetype)initWithScrollView:(UIScrollView *)scrollView bottomPosition:(BOOL)isBottom;
- (instancetype)initWithScrollView:(UIScrollView *)scrollView;


/// set up of background color
- (void)setBackgroundColor:(UIColor*)backgroundColor;


- (instancetype)init __attribute__((unavailable("use -initWithScrollView:  instead")));

@end

