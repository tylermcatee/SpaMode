//
//  NetworkManager.m
//  SpaMode
//
//  Created by Joel Green on 12/28/15.
//  Copyright © 2015 Green. All rights reserved.
//

#import "NetworkManager.h"
#import "PrivateConstants.h"

#define APP_DEBUG YES

@interface NetworkManager ()

@property (nonatomic, strong) NSURLSession *session;

@end


@implementation NetworkManager

- (id)init {
    if (self = [super init]) {
        [self configureNSURLSession];
    }
    return self;
}

- (void)configureNSURLSession
{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    _session = [NSURLSession sessionWithConfiguration:config];
}

+ (NSMutableURLRequest *)generateSpaGetRequestForCommand:(int)command
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    NSString *urlString = [NSString stringWithFormat:@"https://iaqualink.zodiacpoolsystems.com/start/touch/?actionID=NL_ztO8XgpWZbrw&dt=1451349573561&command=%d", command];
    
    // Set the post url and headers
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    
    [request setValue:PRIVATE_COOKIE forHTTPHeaderField:@"Cookie"];
    [request setValue:@"gzip, deflate, sdch" forHTTPHeaderField:@"Accept-Encoding"];
    
    return request;
}

- (void)toggleSpaModeWithCompletion:(apiRequestComplete)completionBlock
{
    
    NSMutableURLRequest *request = [[self class] generateSpaGetRequestForCommand:21];
    
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request
                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      if (error) {
                                          if (APP_DEBUG) {
                                              NSLog(@"Error occured requesting all customers with response: %@ andData: %@ error: %@, %@", response, [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding], error, [error userInfo]);
                                          }
                                      } else {
                                          if (APP_DEBUG) {
                                              NSLog(@"Success requesting requesting all customers with response: %@ andData: %@", response, [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                                          }
                                          if (completionBlock) {
                                              completionBlock(data);
                                          }
                                      }
                                  }];
    [task resume];
}

@end
