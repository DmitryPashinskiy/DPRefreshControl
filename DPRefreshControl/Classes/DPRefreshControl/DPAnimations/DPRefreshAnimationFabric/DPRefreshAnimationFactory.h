//
//  DPRefreshAnimationFabric.h
//  DPRefrshControl
//
//  Created by Dmitry Pashinskiy on 2/12/16.
//  Copyright © 2016 Dmitry Pashinskiy All rights reserved.
//

@import Foundation;
#import "DPRefreshControlTypes.h"
#import "DPRefreshDefaultAnimation.h"
#import "DPRefreshVideoAnimation.h"
#import "DPRefreshStarAnimation.h"


@interface DPRefreshAnimationFactory : NSObject

+ (DPRefreshAnimation*)animationWithType:(DPRefreshType)type;

@end


/**
 @brief Use this function to get animation by type
 */
DPRefreshAnimation * DPRefreshAnimationWithType(DPRefreshType type);
