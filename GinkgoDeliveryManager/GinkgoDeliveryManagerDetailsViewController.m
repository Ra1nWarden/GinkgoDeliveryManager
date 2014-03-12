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
@synthesize orderList = _orderList;
@synthesize topBar;
@synthesize orderDetail;
@synthesize emptyLabel;
@synthesize btmTabBar;

- (NSArray *)orderList {
    if(! _orderList) {
        if(! self.object) {
            return [[NSArray alloc] init];
        }
        else {
            _orderList = (NSArray *) [self.object valueForKey:@"order"];
        }
    }
    return _orderList;
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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.orderDetail.delegate = self;
        self.orderDetail.dataSource = self;
        self.btmTabBar.delegate = self;
    }
    return self;
}

- (void)configureView {
    if(self.object != nil) {
        self.emptyLabel.hidden = YES;
        self.orderDetail.hidden = NO;
        self.btmTabBar.hidden = NO;
        [self.orderDetail reloadData];
        NSLog(@"number of items is %d", [self.btmTabBar.items count]);
        
        NSString * order_status = [self.object valueForKey:@"status"];
        if ([order_status isEqualToString:@"Pending"]) {
            [self.btmTabBar setSelectedItem:[self.btmTabBar.items objectAtIndex:0]];
        }
        else if ([order_status isEqualToString:@"Accepted"]) {
            [self.btmTabBar setSelectedItem:[self.btmTabBar.items objectAtIndex:1]];
        }
        else if ([order_status isEqualToString:@"Ready"]) {
            [self.btmTabBar setSelectedItem:[self.btmTabBar.items objectAtIndex:2]];
        }
        else if ([order_status isEqualToString:@"Completed"]) {
            [self.btmTabBar setSelectedItem:[self.btmTabBar.items objectAtIndex:3]];
        }
        else if ([order_status isEqualToString:@"Voided"]) {
            [self.btmTabBar setSelectedItem:[self.btmTabBar.items objectAtIndex:4]];
        }

    }
    else {
        self.emptyLabel.hidden = NO;
        self.orderDetail.hidden = YES;
        self.btmTabBar.hidden = YES;
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


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section == 0) {
        return @"订单信息";
    }
    else if (section == 1) {
        return @"顾客信息";
    }
    else if (section == 2) {
        return @"订单内容";
    }
    else {
        return @"金额";
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 订单信息
    if (section == 0) {
        return 3;
    }
    // 顾客信息
    else if (section == 1) {
        // 姓名，电话，地址，其他
        return 4;
    }
    // 订单内容
    else if (section == 2) {
        return [self.orderList count];
    }
    // 金额
    else {
        return 4;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"SingleOrderCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    // 订单信息
    if(indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"订单号";
            cell.detailTextLabel.text = [[self.object valueForKey:@"orderNo"] stringValue];
        }
        else if(indexPath.row == 1) {
            cell.textLabel.text = @"订单类别";
            NSString * kind = [self.object valueForKey:@"method"];
            if ([kind isEqualToString:@"Lunch"]) {
                cell.detailTextLabel.text = @"盒饭";
            }
            else if ([kind isEqualToString:@"Delivery"]) {
                cell.detailTextLabel.text = @"外卖";
            }
            else {
                cell.detailTextLabel.text = @"店内取货";
            }
        }
        else {
            cell.textLabel.text = @"下单时间";
            NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSString * time = [formatter stringFromDate:[self.object valueForKey:@"createdAt"]];
            cell.detailTextLabel.text = time;
        }
    }
    // 顾客信息
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"姓名";
            cell.detailTextLabel.text = [self.object valueForKey:@"name"];
        }
        else if (indexPath.row == 1) {
            cell.textLabel.text = @"电话";
            cell.detailTextLabel.text = [self.object valueForKey:@"phoneNo"];
        }
        else if (indexPath.row == 2){
            cell.textLabel.text = @"地址";
            cell.detailTextLabel.text = [self.object valueForKey:@"address"];
            if ([[self.object valueForKey:@"method"] isEqualToString:@"Delivery"]) {
                cell.detailTextLabel.numberOfLines = 2;
                cell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
            }
        }
        else {
            cell.textLabel.text = @"其他";
            cell.detailTextLabel.text = [self.object valueForKey:@"specialIns"];
        }
    }
    // 订单内容
    else if (indexPath.section == 2){
        NSDictionary * currentDish = [self.orderList objectAtIndex:indexPath.row];
        cell.textLabel.text = [currentDish objectForKey:@"NameChs"];
        cell.detailTextLabel.text = [[currentDish objectForKey:@"Quantity"] stringValue];
    }
    // 金额
    else {
        NSNumber * salePrice = [self.object valueForKey:@"salePrice"];
        NSNumber * deliveryPrice = [[NSNumber alloc] initWithDouble:0];
        if(indexPath.row == 0) {
            cell.textLabel.text = @"小计";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"$ %.2f", [salePrice doubleValue]];
        }
        if(indexPath.row == 1) {
            cell.textLabel.text = @"税";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"$ %.2f", [salePrice doubleValue] * 0.04];
        }
        if(indexPath.row == 2) {
            cell.textLabel.text = @"送餐费";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"$ %.2f", [deliveryPrice doubleValue]];
        }
        if(indexPath.row == 3) {
            cell.textLabel.text = @"总计";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"$ %.2f", ([salePrice doubleValue] * 1.04 + [deliveryPrice doubleValue])];
        }

    }
    return cell;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if (item.tag == 0) {
        self.object[@"status"] = @"Pending";
        [self.object saveInBackground];
    }
    else if (item.tag == 1) {
        self.object[@"status"] = @"Accepted";
        [self.object saveInBackground];
    }
    else if (item.tag == 2) {
        self.object[@"status"] = @"Ready";
        [self.object saveInBackground];
    }
    else if (item.tag == 3) {
        self.object[@"status"] = @"Completed";
        [self.object saveInBackground];
    }
    else {
        self.object[@"status"] = @"Voided";
        [self.object saveInBackground];
    }
}

@end
