//
//  DPRefreshVideoAnimation.h
//  DPRefrshControl
//
//  Created by Dmitry Pashinskiy on 2/12/16.
//  Copyright © 2016 Dmitry Pashinskiy All rights reserved.
//

#import "DPRefreshAnimation.h"

@interface DPRefreshVideoAnimation : DPRefreshAnimation

- (void)setupVideo:(NSURL*)videoURL;

/// move video while scrollview is stretching
@property (assign, nonatomic) NSTimeInterval playSecondsBeforeRefresh;

/// video height. Default 150.0f .
@property (assign, nonatomic) CGFloat videoHeight;

@end

