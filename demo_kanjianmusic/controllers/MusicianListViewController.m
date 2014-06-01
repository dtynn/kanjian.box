//
//  MusicianListViewController.m
//  demo_kanjianmusic
//
//  Created by 王麟 on 14-6-1.
//  Copyright (c) 2014年 dtynn. All rights reserved.
//

#import "MusicianListViewController.h"
#import "DataModel.h"
#import "PlayerBar.h"
#import "Musician.h"
#import "MusicianDetailViewController.h"
#import "PlayerController.h"

#import "UIImageView+AFNetworking.h"

@interface MusicianListViewController ()

@end

@implementation MusicianListViewController {
    DataModel *_dataModel;
    PlayerBar *_playerBar;
    UITableView *_tableView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithDataModel:(DataModel *)dataModel andPlayerBar:(PlayerBar *)playerBar {
    self = [super init];
    if (self) {
        _dataModel = dataModel;
        _playerBar = playerBar;
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    //table view
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGRect tableViewFrame = CGRectMake(0, 0, size.width, size.height-44-20);
    _tableView = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStylePlain];
    _tableView.rowHeight = 60;
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    
    [self.view addSubview:_tableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self reloadMusicianList];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = @"Kanjian";
    
    [self.view addSubview:_playerBar];
}

- (void)reloadMusicianList {
    [_dataModel loadMusicians:^(NSError *error){
        if (!error) {
            [_tableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataModel.musicians count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIndentifier = @"MusicianListCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndentifier];
    }
    
    Musician *musician = _dataModel.musicians[indexPath.row];
    cell.textLabel.text = musician.name;
    cell.detailTextLabel.text = musician.styles;
    NSURL *avatartUrl = [NSURL URLWithString:musician.avatarUrl];
    [cell.imageView setImageWithURL:avatartUrl placeholderImage:[UIImage imageNamed:@"kanjianfm"]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Musician *musician = _dataModel.musicians[indexPath.row];
    _dataModel.chosenMusician = musician;
    
    MusicianDetailViewController *viewController = [[MusicianDetailViewController alloc] initWithDataModel:_dataModel andPlayerBar:_playerBar];
    viewController.delegate = (PlayerController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    viewController.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController pushViewController:viewController animated:YES];
    self.title = @"";
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (viewController == self) {
        _dataModel.chosenMusician = nil;
    }
}

@end
