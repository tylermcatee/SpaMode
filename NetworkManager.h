//
//  NetworkManager.h
//  SpaMode
//
//  Created by Joel Green on 12/28/15.
//  Copyright © 2015 Green. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^apiRequestComplete)(NSData *);

@interface NetworkManager : NSObject

- (void)toggleSpaModeWithCompletion:(apiRequestComplete)completionBlock;

@end
