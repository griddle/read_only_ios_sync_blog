//
//  GarretViewController.m
//  GRBlogWebServiceSync
//
//  Created by Garret on 12/5/12.
//  Copyright (c) 2012 Garret. All rights reserved.
//

#import "GarretViewController.h"
#import "Person.h"


@interface GarretViewController ()

@end

@implementation GarretViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[[Person alloc] init] updateSuccess:^(id param){
//            NSLog(@"%@", param);
        } failure:^(id param){
            
        }];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
