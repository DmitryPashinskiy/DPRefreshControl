//
//  DPAppearance.h
//  Pods
//
//  Created by Dmitry Pashinskiy on 6/9/16.
//
//

#import <Foundation/Foundation.h>

@interface DPAppearance : NSObject

+ (id) appearanceForClass:(Class)thisClass;

-(void)startForwarding:(id)sender;

@end
