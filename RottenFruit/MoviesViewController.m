//
//  MovieViewsController.m
//  RottenFruit
//
//  Created by Kent Lee on 2015/6/17.
//  Copyright (c) 2015年 Kent Lee. All rights reserved.
//

#import "MoviesViewController.h"
#import "RottenMovieCell.h"
#import "GeneralUtil.h"
#import "ViewController.h"
#import <UIImageView+AFNetworking.h>

static NSString *rottenTomatoesAPI = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=7ue5rxaj9xn4mhbmsuexug54&limit=20&country=us";

@interface MoviesViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) NSArray *movies;
@property (strong, nonatomic) NSMutableDictionary *moviePosters;

@end

@implementation MoviesViewController

@synthesize movies, moviePosters;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    
    [GeneralUtil asynchronousRequestOnJsonAPI:rottenTomatoesAPI callback:^(NSData *data) {
        NSError *jsonParsingError = nil;
        NSDictionary *apiResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParsingError];
        if (!jsonParsingError) {
            self.movies = apiResponse[@"movies"];
            self.moviePosters = [[NSMutableDictionary alloc] initWithCapacity:self.movies.count];
            [self.myTableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //NSLog(@"%d", self.movies.count);
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RottenMovieCell *cell = (RottenMovieCell *)[self.myTableView dequeueReusableCellWithIdentifier:@"MyMovieCell" forIndexPath:indexPath];
    NSDictionary *movie = self.movies[indexPath.row];
    cell.movieTitle.text = movie[@"title"];
    cell.movieSynopsis.text = movie[@"synopsis"];

    [cell.moviePoster setImageWithURL: [NSURL URLWithString: [movie valueForKeyPath: @"posters.profile"]]];
    
    /*
    NSString *key = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    if (self.moviePosters[key] != nil) {
        cell.moviePoster.image = self.moviePosters[key];
    }
    else {
        cell.moviePoster.image = nil;
        NSDictionary *posters = movie[@"posters"];
        [GeneralUtil asynchronousRequestOnJsonAPI:posters[@"profile"] callback:^(NSData *data) {
            NSString *key = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
            self.moviePosters[key] = [[UIImage alloc] initWithData:data];
            RottenMovieCell *updateCell = (RottenMovieCell *)[self.myTableView cellForRowAtIndexPath:indexPath];
            updateCell.moviePoster.image = self.moviePosters[key];
        }];
    }
     */
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.myTableView deselectRowAtIndexPath:indexPath animated:YES];
    /*
    ViewController *movieView = [self.storyboard instantiateViewControllerWithIdentifier:@"MovieView"];
    NSDictionary *movie = self.movies[indexPath.row];
    NSDictionary *posters = movie[@"posters"];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"http(s)?:.+x[\\d]+\\/" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *posterUrl = [regex stringByReplacingMatchesInString:posters[@"profile"] options:0 range:NSMakeRange(0, [posters[@"profile"] length]) withTemplate:@"http://"];
    movieView.title = movie[@"title"];
    movieView.synopsis = movie[@"synopsis"];
    movieView.posterUrl = posterUrl;
    [self presentViewController:movieView animated:YES completion:nil];
     */
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    RottenMovieCell *cell = sender;
    NSIndexPath *indexPath = [self.myTableView indexPathForCell:cell];
    NSDictionary *movie = self.movies[indexPath.row];
    NSString *thumbnail = [movie valueForKeyPath:@"posters.thumbnail"];
    
    ViewController *movieView = segue.destinationViewController;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"http(s)?:.+cloudfront.net" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *posterUrl = [regex stringByReplacingMatchesInString:thumbnail options:0 range:NSMakeRange(0, thumbnail.length) withTemplate:@"http://content6.flixster.com"];
    movieView.titleString = movie[@"title"];
    movieView.synopsis = movie[@"synopsis"];
    movieView.posterUrl = posterUrl;
}

@end
