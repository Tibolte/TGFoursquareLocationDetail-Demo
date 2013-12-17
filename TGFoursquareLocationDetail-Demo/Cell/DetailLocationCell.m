//
//  DetailLocationCell.m
//  TGFoursquareLocationDetail-Demo
//
//  Created by Thibault Guégan on 17/12/2013.
//  Copyright (c) 2013 Thibault Guégan. All rights reserved.
//

#import "DetailLocationCell.h"

@implementation DetailLocationCell

+ (DetailLocationCell*) detailLocationCell
{
    DetailLocationCell * cell = [[[NSBundle mainBundle] loadNibNamed:@"DetailLocationCell" owner:self options:nil] objectAtIndex:0];
    return cell;
}

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
