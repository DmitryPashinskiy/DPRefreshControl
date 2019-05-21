//
//  DPRefreshView.m
//  DPRefrshControl
//
//  Created by Dmitry Pashinskiy on 1/27/16.
//  Copyright © 2016 Dmitry Pashinskiy All rights reserved.
//

#import "DPRefreshView.h"



@interface DPRefreshView ()

@end



@implementation DPRefreshView

- (void)willMoveToWindow:(UIWindow *)newWindow {
    if ( !newWindow ) {
        [self.delegate refreshViewWillBeRemoved:self];
    } else {
        [self.delegate refreshViewWillBeAdded:self];
    }
}

@end
