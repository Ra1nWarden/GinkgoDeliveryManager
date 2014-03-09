//
//  GinkgoDeliveryManagerDetailsViewController.m
//  GinkgoDeliveryManager
//
//  Created by Zihao Wang on 8/3/14.
//  Copyright (c) 2014 Zihao Wang. All rights reserved.
//

#import "GinkgoDeliveryManagerDetailsViewController.h"


@interface GinkgoDeliveryManagerDetailsViewController ()

@property (nonatomic, strong) UIPopoverController *masterPopOver;

@end

@implementation GinkgoDeliveryManagerDetailsViewController

@synthesize object = _object;
@synthesize name;
@synthesize topBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setObject:(PFObject *)newobject {
    if (_object != newobject) {
        _object = newobject;
        [self configureView];
    }
    
    if (self.masterPopOver != nil) {
        [self.masterPopOver dismissPopoverAnimated:YES];
    }
}

- (void)configureView {
    if(self.object != nil) {
        self.name.text = [self.object valueForKey:@"name"];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc {
    barButtonItem.title = @"订单";
    [self.topBar setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopOver = pc;
}

- (void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
    [self.topBar setLeftBarButtonItem:nil animated:YES];
    self.masterPopOver = nil;
}

@end
