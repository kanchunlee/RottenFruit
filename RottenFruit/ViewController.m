//
//  ViewController.m
//  RottenFruit
//
//  Created by Kent Lee on 2015/6/17.
//  Copyright (c) 2015年 Kent Lee. All rights reserved.
//

#import "ViewController.h"
#import "GeneralUtil.h"
#import <UIImageView+AFNetworking.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *moviePoster;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *movieSynopsis;

@end

@implementation ViewController

@synthesize posterUrl, title, synopsis;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.movieTitle.text = self.titleString;
    self.movieSynopsis.text = self.synopsis;
    [self.moviePoster setImageWithURL: [NSURL URLWithString: self.posterUrl]];
    /*
    [GeneralUtil asynchronousRequestOnJsonAPI:self.posterUrl callback:^(NSData *data) {
        self.moviePoster.image = [[UIImage alloc] initWithData:data];
    }];
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
