//
//  InterfaceController.m
//  SpaMode WatchKit Extension
//
//  Created by Joel Green on 12/28/15.
//  Copyright © 2015 Green. All rights reserved.
//

#import "InterfaceController.h"
#import "NetworkManager.h"

@interface WKInterfaceButton()
@property (nonatomic) UIColor *backgroundColor;
@end


@interface InterfaceController()

@property (strong, nonatomic) NetworkManager *networkManager;

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceGroup *jetsGroup;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *jetsButton;

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceGroup *spaLightGroup;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *spaLightButton;

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceGroup *yardLightGroup;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *yardLightButton;

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceGroup *waterfallGroup;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *waterfallButton;

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

- (void)animateSuccessOnButton:(WKInterfaceButton *)button withGroup:(WKInterfaceGroup *)group {
    [self animateWithDuration:0.33 animations:^{
        [group setBackgroundColor:[UIColor greenColor]];
    }];
    [button setEnabled:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self animateWithDuration:0.5 animations:^{
            [group setBackgroundColor:[UIColor clearColor]];
        }];
    });
}

- (IBAction)tappedJets {
    [self.jetsButton setEnabled:NO];
    [self.networkManager performBasicCommand:TOGGLE_JET_PUMP withCompletion:^(NSData *data) {
        [self animateSuccessOnButton:self.jetsButton withGroup:self.jetsGroup];
    }];
}

- (IBAction)tappedSpaLight {
    [self.spaLightButton setEnabled:NO];
    [self.networkManager performBasicCommand:TOGGLE_SPA_LIGHTS withCompletion:^(NSData *data) {
        [self animateSuccessOnButton:self.spaLightButton withGroup:self.spaLightGroup];
    }];
}

- (IBAction)tappedYardLight {
    [self.yardLightButton setEnabled:NO];
    [self.networkManager performBasicCommand:TOGGLE_YARD_LIGHTS withCompletion:^(NSData *data) {
        [self animateSuccessOnButton:self.yardLightButton withGroup:self.yardLightGroup];
    }];
}

- (IBAction)tappedWaterfall {
    [self.waterfallButton setEnabled:NO];
    [self.networkManager performBasicCommand:TOGGLE_WATERFALL withCompletion:^(NSData *data) {
        [self animateSuccessOnButton:self.waterfallButton withGroup:self.waterfallGroup];
    }];
}

- (NetworkManager *)networkManager
{
    if (!_networkManager) {
        _networkManager = [NetworkManager new];
    }
    return _networkManager;
}

@end



