//
//  Person.m
//  GRBlogWebServiceSync
//
//  Created by Garret on 12/6/12.
//  Copyright (c) 2012 Garret. All rights reserved.
//

#import "Person.h"


@interface Person()

@property (readwrite) NSString *name;
@property (readwrite) NSString *work_name;
@property (readwrite) NSString *work_boss;

@end



@implementation Person


@synthesize name = _name;
@synthesize work_name = _work_name;
@synthesize work_boss = _work_boss;


- (NSURLRequest *)request {
    NSString *urlStr = @"http://mf_temp/web_ios_sync_blog/fake.json";
    NSURL *url = [NSURL URLWithString:urlStr];
    return [NSURLRequest requestWithURL:url];
}

- (void)webserviceValue:(id)val forKey:(NSString *)key {
    if ([key isEqualToString:@"name"]){
        self.name = val;
    }
    else if ([key isEqualToString:@"work"]){
        [self webserviceValuesForDict:val withPrefix:@"work_"];
    }
    else if ([key isEqualToString:@"work_name"]){
        self.work_name = val;
    }
    else if ([key isEqualToString:@"work_boss"]){
        self.work_boss = val;
    }
}


- (void)webserviceAfterSuccess:(id)JSON request:(NSURLRequest*)request response:(NSHTTPURLResponse*)response{
    NSLog(@"success");
    NSLog(@"%@", JSON);
}
- (void)webserviceAfterNetworkError:(NSError*)error json:(id)JSON request:(NSURLRequest*)request response:(NSHTTPURLResponse*)response{
    NSLog(@"network error");
    NSLog(@"%@", [error localizedDescription]);
}
- (void)webserviceAfterResponseError:(NSError*)error json:(id)JSON request:(NSURLRequest*)request response:(NSHTTPURLResponse*)response{
    NSLog(@"response error");
    NSLog(@"%@", [error localizedDescription]);
}

@end









