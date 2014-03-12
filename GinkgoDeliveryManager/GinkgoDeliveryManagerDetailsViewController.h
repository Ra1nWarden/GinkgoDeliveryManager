//
//  GinkgoDeliveryManagerDetailsViewController.h
//  GinkgoDeliveryManager
//
//  Created by Zihao Wang on 8/3/14.
//  Copyright (c) 2014 Zihao Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface GinkgoDeliveryManagerDetailsViewController : UIViewController <UISplitViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, UITabBarDelegate>

@property (nonatomic) PFObject * object;
@property (nonatomic) NSArray * orderList;
@property (weak, nonatomic) IBOutlet UINavigationItem *topBar;
@property (weak, nonatomic) IBOutlet UITableView *orderDetail;
@property (weak, nonatomic) IBOutlet UILabel *emptyLabel;
@property (weak, nonatomic) IBOutlet UITabBar *btmTabBar;

@end
