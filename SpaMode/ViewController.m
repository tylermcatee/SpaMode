//
//  ViewController.m
//  SpaMode
//
//  Created by Joel Green on 12/28/15.
//  Copyright © 2015 Green. All rights reserved.
//

#import "ViewController.h"
#import "NetworkManager.h"

@interface ViewController ()

@property (strong, nonatomic) NetworkManager *networkManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)didTapButton:(id)sender
{
    NSLog(@"tapped");
    [self.networkManager performBasicCommand:TOGGLE_JET_PUMP withCompletion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NetworkManager *)networkManager
{
    if (!_networkManager) {
        _networkManager = [NetworkManager new];
    }
    return _networkManager;
}

@end
