//
//  GinkgoDeliveryManagerOrdersTableViewController.h
//  GinkgoDeliveryManager
//
//  Created by Zihao Wang on 8/3/14.
//  Copyright (c) 2014 Zihao Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface GinkgoDeliveryManagerOrdersTableViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>

@property (nonatomic) PFQuery *query;
@property (nonatomic) NSArray *orders;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic) UISearchDisplayController *searchResult;
@property (nonatomic) NSMutableArray *filteredResults;

@end
