//
//  GinkgoDeliveryManagerOrdersTableViewController.h
//  GinkgoDeliveryManager
//
//  Created by Zihao Wang on 8/3/14.
//  Copyright (c) 2014 Zihao Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface GinkgoDeliveryManagerOrdersTableViewController : UITableViewController

@property (nonatomic) PFQuery * query;
@property (nonatomic) NSArray * orders;

@end
