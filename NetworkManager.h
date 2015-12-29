//
//  NetworkManager.h
//  SpaMode
//
//  Created by Joel Green on 12/28/15.
//  Copyright © 2015 Green. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^apiRequestComplete)(NSData *);

#define TOGGLE_SPA_LIGHTS 24
#define TOGGLE_YARD_LIGHTS 25
#define TOGGLE_JET_PUMP 21
#define TOGGLE_WATERFALL 22
#define SPA_MODE_OFF 20
#define SPA_MODE_ON 128

@interface NetworkManager : NSObject

- (void)performBasicCommand:(int)command withCompletion:(apiRequestComplete)completionBlock;
- (void)performBasicCommand:(int)command withText:(NSString *)text withCompletion:(apiRequestComplete)completionBlock;

@end
