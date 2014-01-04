//
//  UserCell.m
//  TGFoursquareLocationDetail-Demo
//
//  Created by Thibault Guégan on 04/01/2014.
//  Copyright (c) 2014 Thibault Guégan. All rights reserved.
//

#import "UserCell.h"

@implementation UserCell

+ (UserCell*) userCell
{
    UserCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"UserCell" owner:self options:nil] objectAtIndex:0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _userImg.layer.cornerRadius = 25.0f;
    }
    return self;
}

- (void)awakeFromNib
{
    _userImg.layer.cornerRadius = 25.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
