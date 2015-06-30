//
//  RottenMovieCell.h
//  RottenFruit
//
//  Created by Kent Lee on 2015/6/17.
//  Copyright (c) 2015年 Kent Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RottenMovieCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *movieSynopsis;
@property (weak, nonatomic) IBOutlet UIImageView *moviePoster;

@end
