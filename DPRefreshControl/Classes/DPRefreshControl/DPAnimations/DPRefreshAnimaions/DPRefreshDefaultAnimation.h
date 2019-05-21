//
//  DPRefreshDefaultAniamation.h
//  DPRefrshControl
//
//  Created by Dmitry Pashinskiy on 2/12/16.
//  Copyright © 2016 Dmitry Pashinskiy All rights reserved.
//

#import "DPRefreshAnimation.h"

@interface DPRefreshDefaultAnimation : DPRefreshAnimation

@property (strong, nonatomic) UIColor *sceneColor;

@property (assign, nonatomic) NSUInteger instanceCount;

@property (assign, nonatomic) NSTimeInterval dashAnimationDuration;

@end
