//
//  movieCell.m
//  scanIMDB
//
//  Created by JerryTaylorKendrick on 4/11/13.
//  Copyright (c) 2013 Jerry Taylor Kendrick. All rights reserved.
//

#import "movieCell.h"

@implementation movieCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
