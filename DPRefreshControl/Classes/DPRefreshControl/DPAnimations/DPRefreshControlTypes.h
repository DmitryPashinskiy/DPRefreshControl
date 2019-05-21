//
//  DPRefreshControlTypes.h
//  DPRefrshControl
//
//  Created by Dmitry Pashinskiy on 2/19/16.
//  Copyright © 2016 Dmitry Pashinskiy All rights reserved.
//

typedef void (^DPRefreshHandler)();


/**
 @brief types for factory to instantiate and return coorect animation.
 */
typedef NS_ENUM( NSUInteger, DPRefreshType)
{
    DPRefreshType_Default,
    DPRefreshType_Star,
    DPRefreshType_VideoAnimation
    
    
};

typedef NS_ENUM( NSUInteger, DPAnimationState)
{
    DPAnimationState_NotReady,
    DPAnimationState_Ready,
    DPAnimationState_Animated,
    DPAnimationState_StopAnimated
};



// ===== ===== ===== ===== ========== ===== ===== ===== ===== //
// ----- ----- ----- | UNDER CONSTRUCTION | ----- ----- ----- //
// ===== ===== ===== ===== ========== ===== ===== ===== ===== //

/// under construction
typedef NS_ENUM(NSUInteger, DPRefreshEvent) {
    DPRefreshEvent_Prepared,
    DPRefreshEvent_StartStretching,
    DPRefreshEvent_EndStretching,
    DPRefreshEvent_StartAnimating,
    DPRefreshEvent_EndAnimating,
} __unavailable;
