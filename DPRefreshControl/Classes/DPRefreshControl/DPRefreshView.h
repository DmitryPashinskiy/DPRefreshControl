//
//  DPRefreshView.h
//  DPRefrshControl
//
//  Created by Dmitry Pashinskiy on 1/27/16.
//  Copyright © 2016 Dmitry Pashinskiy All rights reserved.
//

@import UIKit;

@protocol DPRefreshViewDelegate;

@interface DPRefreshView : UIView

@property (nonatomic, weak) id <DPRefreshViewDelegate> delegate;

@end


@protocol DPRefreshViewDelegate <NSObject>
- (void)refreshViewWillBeRemoved:(DPRefreshView*)refreshView;
- (void)refreshViewWillBeAdded:(DPRefreshView*)refreshView;
@end
