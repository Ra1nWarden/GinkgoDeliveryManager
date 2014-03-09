//
//  GinkgoDeliveryManagerDetailsViewController.h
//  GinkgoDeliveryManager
//
//  Created by Zihao Wang on 8/3/14.
//  Copyright (c) 2014 Zihao Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface GinkgoDeliveryManagerDetailsViewController : UIViewController <UISplitViewControllerDelegate>

@property (nonatomic) PFObject * object;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UINavigationItem *topBar;

@end
