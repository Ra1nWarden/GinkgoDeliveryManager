//
//  GinkgoDeliveryManagerViewController.m
//  GinkgoDeliveryManager
//
//  Created by Zihao Wang on 8/3/14.
//  Copyright (c) 2014 Zihao Wang. All rights reserved.
//

#import "GinkgoDeliveryManagerViewController.h"

@interface GinkgoDeliveryManagerViewController ()

@end

@implementation GinkgoDeliveryManagerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] = @"bar";
    [testObject saveInBackground];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
