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

+ (NSMutableURLRequest *)generateSpaGetRequestForCommand:(int)command withText:(NSString *)text
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    NSString *urlString = [NSString stringWithFormat:@"https://iaqualink.zodiacpoolsystems.com/start/touch/?actionID=NL_ztO8XgpWZbrw&dt=1451349573561&command=%d", command];
    
    if (text) {
        urlString = [NSString stringWithFormat:@"%@&text=%@", urlString, text];
    }
    
    // Set the post url and headers
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    
    [request setValue:PRIVATE_COOKIE forHTTPHeaderField:@"Cookie"];
    [request setValue:@"gzip, deflate, sdch" forHTTPHeaderField:@"Accept-Encoding"];
    
    return request;
}

- (void)performBasicCommand:(int)command withCompletion:(apiRequestComplete)completionBlock
{
    [self performBasicCommand:command withText:nil withCompletion:completionBlock];
}

- (void)performBasicCommand:(int)command withText:(NSString *)text withCompletion:(apiRequestComplete)completionBlock
{
    
    NSMutableURLRequest *request = [[self class] generateSpaGetRequestForCommand:command withText:text];
    
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request
                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      if (error) {
                                          if (APP_DEBUG) {
                                              NSLog(@"Error occured in %@ %@, for command: %d with response: %@ andData: %@ error: %@, %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), command, response, [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding], error, [error userInfo]);
                                          }
                                      } else {
                                          if (APP_DEBUG) {
                                              NSLog(@"Success in %@ %@, for command: %d with response: %@ andData: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), command, response, [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                                          }
                                          if (completionBlock) {
                                              completionBlock(data);
                                          }
                                      }
                                  }];
    [task resume];
}

@end
