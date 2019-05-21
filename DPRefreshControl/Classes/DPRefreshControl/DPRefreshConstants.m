//
//  DPRefreshConstants.m
//  DPRefrshControl
//
//  Created by Dmitry Pashinskiy on 2/24/16.
//  Copyright © 2016 Dmitry Pashinskiy All rights reserved.
//

#import "DPRefreshConstants.h"


// KVO keys
NSString * const kDPObserverKeyScrollContentInset  = @"contentInset";
NSString * const kDPObserverKeyScrollContentOffset = @"contentOffset";
NSString * const kDPObserverKeyScrollContentSize   = @"contentSize";


//defaults
const CGFloat kDPDefaultAddingOffsetAppear = 30.0f;
const CGFloat kDPDefaultOffsetForReload    = 80.0f;

const NSTimeInterval kDPInsetsAnimationDuration = 0.5;
