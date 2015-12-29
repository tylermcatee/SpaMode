//
//  InterfaceController.m
//  SpaMode WatchKit Extension
//
//  Created by Joel Green on 12/28/15.
//  Copyright © 2015 Green. All rights reserved.
//

#import "InterfaceController.h"
#import "NetworkManager.h"


@interface InterfaceController()

@property (strong, nonatomic) NetworkManager *networkManager;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)tappedJets {
    [self.networkManager toggleSpaModeWithCompletion:nil];
}

- (NetworkManager *)networkManager
{
    if (!_networkManager) {
        _networkManager = [NetworkManager new];
    }
    return _networkManager;
}

@end



