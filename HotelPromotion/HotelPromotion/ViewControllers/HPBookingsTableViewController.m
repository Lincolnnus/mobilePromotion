//
//  HPBookingsTableViewController.m
//  HotelPromotion
//
//  Created by Le Viet Tien on 24/2/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "HPBookingsTableViewController.h"

@interface HPBookingsTableViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *bookings;
@end

@implementation HPBookingsTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.tabBarItem setTitle:@"My Bookings"];
    [[HPCredentialsManager sharedInstance] updateBookings];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableView) name:@"updateBookingsSucceed" object:nil];

}

- (void)setupTableView {
    CGRect tableViewFrame = CGRectMake(0, 0, self.view.size.width, self.view.size.height);
    UITableView *tv = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStylePlain];
    self.tableView = tv;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

- (void)refreshTableView {
    self.bookings = [[HPCredentialsManager sharedInstance] bookings];
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
