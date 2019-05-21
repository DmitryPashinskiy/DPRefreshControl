//
//  DPRefreshAnimationFabric.m
//  DPRefrshControl
//
//  Created by Dmitry Pashinskiy on 2/12/16.
//  Copyright © 2016 Dmitry Pashinskiy All rights reserved.
//

#import "DPRefreshAnimationFactory.h"
#import "DPRefreshAnimation.h"

static NSString * kDPRefreAnimationTypesStrArr[] = {
    [DPRefreshType_Default]        = @"DPRefreshDefaultAnimation",
    [DPRefreshType_Star]           = @"DPRefreshStarAnimation",
    [DPRefreshType_VideoAnimation] = @"DPRefreshVideoAnimation"
};



@implementation DPRefreshAnimationFactory

+ (DPRefreshAnimation*)animationWithType:(DPRefreshType)type {
    // getting of identifier
    NSString *identifier = kDPRefreAnimationTypesStrArr[type];
    if (!identifier || !identifier.length){
        NSLog(@"There is no such identifier type");
        return nil;
    }
    
    // getting of Class
    Class myClass = NSClassFromString(identifier) ;
    if (!myClass){
        NSLog(@"There is no such class with such identifier");
        return nil;
    }
    
    DPRefreshAnimation *animation = [myClass animation];
    return animation;
}

@end



DPRefreshAnimation * DPRefreshAnimationWithType(DPRefreshType type) {
    return [DPRefreshAnimationFactory animationWithType:type];
}
