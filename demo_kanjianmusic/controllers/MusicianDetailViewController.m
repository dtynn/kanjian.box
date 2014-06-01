//
//  MusicianDetailViewController.m
//  demo_kanjianmusic
//
//  Created by 王麟 on 14-6-1.
//  Copyright (c) 2014年 dtynn. All rights reserved.
//

#import "MusicianDetailViewController.h"
#import "DataModel.h"
#import "PlayerBar.h"
#import "Musician.h"
#import "Song.h"

#import "UIImageView+AFNetworking.h"

@interface MusicianDetailViewController ()

@end

@implementation MusicianDetailViewController {
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

- (id)initWithDataModel:(id)dataModel andPlayerBar:(PlayerBar *)playerBar {
    self = [super init];
    if (self) {
        _dataModel = dataModel;
        _playerBar = playerBar;
        
    }
    return self;
}

- (void)loadView {
    [super loadView];
    self.title = _dataModel.chosenMusician.name;
    
    CGSize size = [[UIScreen mainScreen] bounds].size;
    
    CGRect avatarViewFrame = CGRectMake(20, 85, 120, 120);
    UIImageView *avatarView = [[UIImageView alloc] initWithFrame:avatarViewFrame];
    NSURL *avatarUrl = [NSURL URLWithString:_dataModel.chosenMusician.avatarUrl];
    [avatarView setImageWithURL:avatarUrl placeholderImage:[UIImage imageNamed:@"kanjianfm"]];
    
    CGRect tableViewFrame = CGRectMake(0, 225, size.width, size.height-225-44-20);
    _tableView = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStylePlain];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    
    if (_playerBar != nil) {
        [self.view addSubview:_playerBar];
    }
    [self.view addSubview:avatarView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([_dataModel.chosenMusician.songs count] == 0) {
        [self reloadSongs];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view addSubview:_tableView];
}

- (void)reloadSongs {
    [_dataModel.chosenMusician loadSongs:^(NSError *error){
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

#pragma table view

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataModel.chosenMusician.songs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIndentifier = @"MusicianDetailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    Song *song = _dataModel.chosenMusician.songs[indexPath.row];
    cell.textLabel.text = song.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Song *chosenSong = _dataModel.chosenMusician.songs[indexPath.row];
    if (_dataModel.chosenSong != chosenSong) {
        _dataModel.chosenSong = chosenSong;
        [_tableView reloadData];
        [self.delegate didSelectASongToPlay];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
