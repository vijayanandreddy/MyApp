//
//  MasterViewController.m
//  TableViewMULTI
//
//  Created by vijayanand reddy kolipaka on 4/1/15.
//  Copyright (c) 2015 vijayanand reddy kolipaka. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

@interface MasterViewController ()

{
    NSMutableArray *countries;
    NSMutableArray *cities;
    
}
@property NSMutableArray *objects;


@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
 
    
   countries=[[NSMutableArray alloc]initWithObjects:@"India",@"Singapore",@"china", nil];
    cities=[[NSMutableArray alloc]initWithObjects:@"Hyderabad",@"chennai",@"Delhi" ,nil];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = self.objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return countries.count;
    }
    else
    {
        return cities.count;
    }
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section==0)
    {
        return @"Countries";
    }
    else{
        return @"Cities";
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   UIStoryboard *mainstory=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
  DetailViewController *detail=[mainstory instantiateViewControllerWithIdentifier:@"DetailId"];
  // DetailViewController *detail=[[DetailViewController alloc]init];
    
   
  if(indexPath.section==0)
  {
      detail.str2=[countries objectAtIndex:indexPath.row];
      
  }
    else
    {
        detail.str2=[cities objectAtIndex:indexPath.row];
    }
    
   [self.navigationController pushViewController:detail animated:YES];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    //NSLog(@"%@",[countries objectAtIndex:0]);
    if (indexPath.section==0) {
        cell.textLabel.text=[countries objectAtIndex:indexPath.row];
    }
    else
    {
        cell.textLabel.text=[cities objectAtIndex:indexPath.row];
    }
    
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end
