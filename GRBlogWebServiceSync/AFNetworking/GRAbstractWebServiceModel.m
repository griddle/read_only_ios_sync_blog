//
//  GRAbstractWebServiceModel.m
//  GRBlogWebServiceSync
//
//  Created by Garret on 12/5/12.
//  Copyright (c) 2012 Garret. All rights reserved.
//

#import "GRAbstractWebServiceModel.h"
#import "AFJSONRequestOperation.h"


@interface GRAbstractWebServiceModel()
- (NSURLRequest *)request;
- (void)webserviceValue:(id)val forKey:(NSString *)key;

- (void)webserviceAfterSuccess:(id)JSON request:(NSURLRequest*)request response:(NSHTTPURLResponse*)response;
- (void)webserviceAfterNetworkError:(NSError*)error json:(id)JSON request:(NSURLRequest*)request response:(NSHTTPURLResponse*)response;
- (void)webserviceAfterResponseError:(NSError*)error json:(id)JSON request:(NSURLRequest*)request response:(NSHTTPURLResponse*)response;

- (void)webserviceValuesForDict:(NSDictionary *)group withPrefix:(NSString *)prefix;
@end



@implementation GRAbstractWebServiceModel


# pragma mark - override these
- (NSURLRequest *)request {
    [NSException raise:@"Must override request method" format:@""];
    return nil;
}
- (void)webserviceValue:(id)val forKey:(NSString *)key {
    NSLog(@"%@ - %@", key, val);
}


#pragma mark - optional override
- (void)webserviceAfterSuccess:(id)JSON request:(NSURLRequest*)request response:(NSHTTPURLResponse*)response{}
- (void)webserviceAfterNetworkError:(NSError*)error json:(id)JSON request:(NSURLRequest*)request response:(NSHTTPURLResponse*)response{}
- (void)webserviceAfterResponseError:(NSError*)error json:(id)JSON request:(NSURLRequest*)request response:(NSHTTPURLResponse*)response{}


#pragma mark - update methods
- (void)update {
    [self updateSuccess:nil failure:nil];
}
- (void)updateSuccess:(OneParamBlock)onSuccess failure:(OneParamBlock)onFailure {
    NSURLRequest *request = [self request];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        if ([JSON isKindOfClass:[NSDictionary class]] && [JSON objectForKey:@"error"]){
            // http success but json indicates error
            NSDictionary *errorObj = [JSON objectForKey:@"error"];
            NSDictionary *userInfo = [NSMutableDictionary dictionaryWithObject:[errorObj objectForKey:@"message"] forKey:NSLocalizedDescriptionKey];
            NSError *error = [NSError errorWithDomain:@"ws" code:200 userInfo:userInfo];
            [self webserviceAfterResponseError:error json:JSON request:request response:response];
            if (onFailure) onFailure(error);
        }
        else {
            // success
            [self webserviceValuesForDict:JSON withPrefix:nil];
            [self webserviceAfterSuccess:JSON request:request response:response];
            if (onSuccess) onSuccess(JSON);
        }
    }
    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
        // http fail
        [self webserviceAfterNetworkError:error json:JSON request:request response:response];
        if (onFailure) onFailure(error);
    }];
    [operation start];
}


#pragma mark -
- (void)webserviceValuesForDict:(NSDictionary *)group withPrefix:(NSString *)prefix {
    if (![group isKindOfClass:[NSDictionary class]]) return;
    for (id key in group){
        // key needs to be a string
        if (![key isKindOfClass:[NSString class]]) continue;
        NSString *newKey = (prefix) ? [prefix stringByAppendingString:key] : key;
        [self webserviceValue:[group objectForKey:key] forKey:newKey];
    }
}



@end








