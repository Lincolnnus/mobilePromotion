//
//  HPPromotionsViewController.m
//  HotelPromotion
//
//  Created by Le Viet Tien on 24/2/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "HPPromotionsViewController.h"
#import "HPPromotionTableViewCell.h"
#import "HPPromotionDetailViewController.h"

@interface HPPromotionsViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *promotions;
@end

@implementation HPPromotionsViewController

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
    [self.navigationItem setTitle:@"Promotions"];
    [self.navigationController.tabBarItem setTitle:@"Promotions"];
    
    [self setupTableView];
    [[HPCredentialsManager sharedInstance] updatePromotions];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableView) name:@"updatePromotionsSucceed" object:nil];
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
    self.promotions = [[HPCredentialsManager sharedInstance] promotions];
    [self.tableView reloadData];
}

#pragma mark - UITableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.promotions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *contactTableViewCellIdentifier = @"PromotionViewCell";
    HPPromotionTableViewCell *cell = (HPPromotionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:contactTableViewCellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HPPromotionTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    HPPromotion *promotion = [self.promotions objectAtIndex:indexPath.row];
    cell.textLabel.text = promotion.title;
    cell.detailTextLabel.text = promotion.content;
    [cell.imageView setImageWithURL:[NSURL URLWithString:promotion.thumbnail] placeholderImage:[UIImage imageNamed:@"promotion_picture_placeholder"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    HPPromotion *promotion = [self.promotions objectAtIndex:indexPath.row];
//    HPPromotionDetailViewController *detailVC = [[HPPromotionDetailViewController alloc] initWithPromotion:promotion];
//    [self.navigationController pushViewController:detailVC animated:YES];
    
    [self performSegueWithIdentifier:@"PromotionDetailSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PromotionDetailSegue"]) {
        /*
        HPPromotionDetailViewController *detailVC = (HPPromotionDetailViewController *)segue.destinationViewController;
        NSIndexPath *indexPath = (NSIndexPath *)sender;
        HPPromotion *promotion = [self.promotions objectAtIndex:indexPath.row];
        detailVC.promotion = promotion;
         */
    
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        HPPromotion *promotion = [self.promotions objectAtIndex:indexPath.row];
        HPPromotionDetailViewController *detailVC = (HPPromotionDetailViewController *)segue.destinationViewController;
        detailVC.promotion = promotion;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
