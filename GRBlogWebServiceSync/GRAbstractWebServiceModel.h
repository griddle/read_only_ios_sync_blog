//
//  GRAbstractWebServiceModel.h
//  GRBlogWebServiceSync
//
//  Created by Garret on 12/5/12.
//  Copyright (c) 2012 Garret. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^ OneParamBlock)(id);


@interface GRAbstractWebServiceModel : NSObject

- (void)update;
- (void)updateSuccess:(OneParamBlock)success failure:(OneParamBlock)failure;

@end


@interface GRAbstractWebServiceModel(ProtectedMethods)
- (void)webserviceValuesForDict:(NSDictionary *)group withPrefix:(NSString *)prefix;
@end