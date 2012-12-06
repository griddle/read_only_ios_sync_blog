//
//  Person.h
//  GRBlogWebServiceSync
//
//  Created by Garret on 12/6/12.
//  Copyright (c) 2012 Garret. All rights reserved.
//

#import "GRAbstractWebServiceModel.h"


@interface Person : GRAbstractWebServiceModel


@property (readonly) NSString *name;
@property (readonly) NSString *work_name;
@property (readonly) NSString *work_boss;

@end
