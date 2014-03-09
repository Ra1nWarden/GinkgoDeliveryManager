//
//  GinkgoDeliveryManagerOrdersTableViewController.m
//  GinkgoDeliveryManager
//
//  Created by Zihao Wang on 8/3/14.
//  Copyright (c) 2014 Zihao Wang. All rights reserved.
//

#import "GinkgoDeliveryManagerOrdersTableViewController.h"

@interface GinkgoDeliveryManagerOrdersTableViewController ()

@end

@implementation GinkgoDeliveryManagerOrdersTableViewController

@synthesize query = _query;
@synthesize orders = _orders;
@synthesize searchResult = _searchResult;
@synthesize searchBar;
@synthesize filteredResults = _filteredResults;
@synthesize detailViewController = _detailViewController;

- (GinkgoDeliveryManagerDetailsViewController *)detailViewController {
    if(!_detailViewController) {
        _detailViewController = [self.splitViewController.viewControllers lastObject];
    }
    return _detailViewController;
}

- (NSMutableArray *)filteredResults {
    if(!_filteredResults) {
        _filteredResults = [[NSMutableArray alloc] initWithCapacity:[self.orders count]];
    }
    return _filteredResults;
}

- (PFQuery *)query {
    if(!_query) {
        _query = [PFQuery queryWithClassName:@"Order"];
    }
    return _query;
}

- (NSArray *)orders {
    if(!_orders) {
        _orders = [self.query findObjects];
    }
    return _orders;
}

- (UISearchDisplayController *)searchResult {
    if(!_searchResult) {
        _searchResult = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
        _searchResult.delegate = self;
        _searchResult.searchResultsDelegate = self;
        _searchResult.searchResultsDataSource = self;
    }
    return _searchResult;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)matchPFObject:(PFObject *)obj withSearchText:(NSString *)searchText {
    NSString * name = [obj valueForKey:@"name"];
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF contains[c] %@", searchText];
    return [pred evaluateWithObject:name];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self.filteredResults removeAllObjects];
    for (PFObject* eachObj in self.orders) {
        if([self matchPFObject:eachObj withSearchText:searchString]) {
            [self.filteredResults addObject:eachObj];
        }
    };
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    if(tableView == self.searchResult.searchResultsTableView) {
        return [self.filteredResults count];
    }
    else {
        return [self.orders count];

    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    PFObject* obj;
    if(tableView == self.searchResult.searchResultsTableView) {
        obj = [self.filteredResults objectAtIndex:indexPath.row];
    }
    else {
        obj = [self.orders objectAtIndex:indexPath.row];
    }
    cell.textLabel.text = [obj valueForKey:@"name"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    NSString * dateInString = [dateFormatter stringFromDate:[obj valueForKey:@"createdAt"]];
    cell.detailTextLabel.text = dateInString;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PFObject * obj;
    if (tableView == self.searchResult.searchResultsTableView) {
        obj = [self.filteredResults objectAtIndex:indexPath.row];
    }
    else {
        obj = [self.orders objectAtIndex:indexPath.row];
    }
    self.detailViewController.object = obj;
//    [self.detailViewController.view setNeedsDisplay];
    NSLog(@"just called set needs display");
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
